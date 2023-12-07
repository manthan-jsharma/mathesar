from django.urls import reverse
from rest_framework import serializers

from mathesar.api.display_options import DISPLAY_OPTIONS_BY_UI_TYPE
from mathesar.api.exceptions.mixins import MathesarErrorMessageMixin
from mathesar.models.base import Database


class ConnectionSerializer(MathesarErrorMessageMixin, serializers.ModelSerializer):
    supported_types_url = serializers.SerializerMethodField()
    nickname = serializers.CharField(source='name')
    database = serializers.CharField(source='db_name')

    class Meta:
        model = Database
        fields = ['id', 'nickname', 'database', 'supported_types_url', 'username', 'password', 'host', 'port']
        read_only_fields = ['id', 'supported_types_url']
        extra_kwargs = {
            'password': {'write_only': True}
        }

    def get_supported_types_url(self, obj):
        if isinstance(obj, Database) and not self.partial:
            # Only get records if we are serializing an existing table
            request = self.context['request']
            return request.build_absolute_uri(reverse('connection-types', kwargs={'pk': obj.pk}))
        else:
            return None


class TypeSerializer(MathesarErrorMessageMixin, serializers.Serializer):
    identifier = serializers.CharField()
    name = serializers.CharField()
    db_types = serializers.ListField(child=serializers.CharField())
    display_options = serializers.DictField()

    def to_representation(self, ui_type):
        primitive = dict(
            identifier=ui_type.id,
            name=ui_type.display_name,
            db_types=ui_type.db_types,
            display_options=DISPLAY_OPTIONS_BY_UI_TYPE.get(ui_type, None),
        )
        return super().to_representation(primitive)
