import { writable, get as getStoreValue } from 'svelte/store';
import { States, getAPI, deleteAPI } from '@mathesar/utils/api';
import { TabularType } from '@mathesar/App.d';
import type {
  Writable,
  Updater,
  Subscriber,
  Unsubscriber,
} from 'svelte/store';
import type { PaginatedResponse } from '@mathesar/utils/api';
import type { CancellablePromise } from '@mathesar/components';
import type { DBObjectEntry } from '@mathesar/App.d';
import type { Meta } from './meta';
import type { Columns, TableColumn } from './columns';

export interface TableRecord {
  [key: string]: unknown,
  __isGroupHeader?: boolean,
  __rowNumber?: number,
  __state: string,
  __groupInfo?: {
    columns: string[],
    values: Record<string, unknown>,
  }
}

export interface GroupData {
  [key: string]: GroupData | number
}

interface TableRecordData {
  state: States,
  error?: string,
  data: TableRecord[],
  totalCount: number,
  groupData?: GroupData
}

interface TableRecordResponse extends PaginatedResponse<TableRecord> {
  group_count?: {
    group_count_by?: TableColumn['name'][],
    results?: {
      count: number,
      values: string[]
    }[]
  }
}

function mapGroupCounts(groupInfo: TableRecordResponse['group_count']): GroupData {
  const groupResults = groupInfo.results;
  const groupMap: GroupData = {};
  groupResults?.forEach((result) => {
    let group = groupMap;
    for (let i = 0; i < result.values.length - 1; i += 1) {
      const value = result.values[i];
      if (!group[value]) {
        group[value] = {};
      }
      group = group[value] as GroupData;
    }
    group[result.values[result.values.length - 1]] = result.count;
  });
  return groupMap;
}

function preprocessRecords(offset: number, response: TableRecordResponse): TableRecord[] {
  const groupColumns = response?.group_count?.group_count_by;
  const isResultGrouped = groupColumns?.length > 0;

  const records = response.results || [];
  const combinedRecords: TableRecord[] = [];
  let index = 0;

  records.forEach((record) => {
    if (isResultGrouped) {
      let isGroup = false;
      if (index === 0) {
        isGroup = true;
      } else {
        // eslint-disable-next-line no-restricted-syntax
        for (const column of groupColumns) {
          if (records[index - 1][column] !== records[index][column]) {
            isGroup = true;
            break;
          }
        }
      }

      if (isGroup) {
        combinedRecords.push({
          __isGroupHeader: true,
          __groupInfo: {
            columns: groupColumns,
            values: record,
          },
          __state: 'done',
        });
      }
    }

    combinedRecords.push({
      ...record,
      __rowNumber: offset + index + 1,
      __state: 'done',
    });
    index += 1;
  });
  return combinedRecords;
}

export class Records implements Writable<TableRecordData> {
  _type: TabularType;

  _parentId: DBObjectEntry['id'];

  _store: Writable<TableRecordData>;

  _promise: CancellablePromise<TableRecordResponse>;

  _url: string;

  _meta: Meta;

  _columns: Columns;

  _fetchCallback?: (storeData: TableRecordData) => void;

  _requestParamsUnsubscriber: Unsubscriber;

  constructor(
    type: TabularType,
    parentId: number,
    meta: Meta,
    columns: Columns,
    fetchCallback?: (storeData: TableRecordData) => void,
  ) {
    this._type = type;
    this._parentId = parentId;
    this._store = writable({
      state: States.Loading,
      data: [],
      groupData: null,
      totalCount: null,
    });
    this._meta = meta;
    this._columns = columns;
    this._url = `/${this._type === TabularType.Table ? 'tables' : 'views'}/${this._parentId}/records/`;
    this._fetchCallback = fetchCallback;
    void this.fetch();

    // subscribers
    this._requestParamsUnsubscriber = this._meta.recordRequestParams.subscribe(() => {
      void this.fetch();
    });
  }

  async fetch(hideLoadingOnExistingRows = false): Promise<TableRecordData> {
    this._promise?.cancel();
    this._store.update((existingData) => {
      let { data } = existingData;

      data.length = getStoreValue(this._meta.pageSize);
      if (hideLoadingOnExistingRows) {
        data = data.map((entry) => {
          if (!entry) {
            return { __state: 'loading' };
          }
          return entry;
        });
      } else {
        data.fill({ __state: 'loading' });
      }

      return {
        ...existingData,
        data,
        state: States.Loading,
        error: null,
      };
    });

    try {
      const params = getStoreValue(this._meta.recordRequestParams);
      this._promise = getAPI<TableRecordResponse>(`${this._url}?${params ?? ''}`);

      const response = await this._promise;
      const totalCount = response.count || 0;

      const groupColumns = response?.group_count?.group_count_by;
      const isResultGrouped = groupColumns?.length > 0;
      let groupData: GroupData = null;
      if (isResultGrouped) {
        groupData = mapGroupCounts(response.group_count);
      }

      const records = preprocessRecords(getStoreValue(this._meta.offset), response);

      const storeData: TableRecordData = {
        state: States.Done,
        data: records,
        groupData,
        totalCount,
      };
      this._store.set(storeData);
      this._fetchCallback?.(storeData);
      return storeData;
    } catch (err) {
      this._store.set({
        state: States.Error,
        error: err instanceof Error ? err.message : null,
        data: [],
        totalCount: null,
      });
    } finally {
      this._promise = null;
    }
    return null;
  }

  set(value: TableRecordData): void {
    this._store.set(value);
  }

  update(updater: Updater<TableRecordData>): void {
    this._store.update(updater);
  }

  subscribe(
    run: Subscriber<TableRecordData>,
  ): Unsubscriber {
    return this._store.subscribe(run);
  }

  get(): TableRecordData {
    return getStoreValue(this._store);
  }

  async deleteSelected(): Promise<void> {
    const pks = getStoreValue(this._meta.selectedRecords);

    if (pks.length > 0) {
      const pkSet = new Set(pks);
      this._store.update((existingData) => {
        // TODO: Retain map with pk uuid hash for record operations
        const data = existingData.data.map((entry) => {
          if (entry && pkSet.has(entry[this._columns.get().primaryKey]?.toString())) {
            return {
              ...entry,
              __state: 'deleting',
            };
          }
          return entry;
        });

        return {
          ...existingData,
          data,
        };
      });

      try {
        const success = new Set();
        const failed = new Set();
        // TODO: Convert this to single request
        const promises = pks.map((pk) => deleteAPI<unknown>(`${this._url}${pk}/`)
          .then(() => {
            success.add(pk);
            return success;
          })
          .catch(() => {
            failed.add(pk);
            return failed;
          }));
        await Promise.all(promises);

        this._store.update((existingData) => {
          const data = existingData.data.map((entry) => {
            if (entry && failed.has(entry[this._columns.get().primaryKey]?.toString())) {
              return {
                ...entry,
                __state: 'deletionFailed',
              };
            }
            return entry;
          });

          return {
            ...existingData,
            data,
          };
        });

        void this.fetch(true);
      } catch (err) {
        this._store.update((existingData) => {
          // TODO: Retain map with pk uuid hash for record operations
          const data = existingData.data.map((entry) => {
            if (entry && pkSet.has(entry[this._columns.get().primaryKey]?.toString())) {
              return {
                ...entry,
                __state: 'deletionError',
              };
            }
            return entry;
          });

          return {
            ...existingData,
            data,
          };
        });
      } finally {
        this._meta.clearSelectedRecords();
      }
    }
  }

  destroy(): void {
    this._promise?.cancel();
    this._promise = null;

    this._requestParamsUnsubscriber();
  }
}