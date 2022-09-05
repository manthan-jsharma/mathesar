-- Start date: 2022-05-01
-- End date: 2022-08-10
--
TRUNCATE TABLE "Checkouts";
SELECT pg_catalog.setval('"Checkouts_id_seq"', 1, false);

INSERT INTO "Checkouts" ("Item", "Patron", "Checkout Time", "Due Date", "Check In Time") VALUES
(40, 7, '2022-05-02 11:24:41.145373', '2022-05-16', null),
(29, 27, '2022-05-03 10:53:21.277204', '2022-05-17', '2022-05-17 12:17:17.899355'),
(60, 10, '2022-05-03 15:42:21.196209', '2022-05-17', '2022-05-25 21:52:37.331009'),
(77, 25, '2022-05-04 12:35:23.682814', '2022-05-18', '2022-05-22 23:34:41.913516'),
(98, 23, '2022-05-04 13:16:07.300468', '2022-05-18', '2022-05-22 14:56:51.33729'),
(63, 11, '2022-05-05 11:51:22.375107', '2022-05-19', '2022-05-19 08:26:59.960458'),
(54, 29, '2022-05-05 13:57:37.009534', '2022-05-19', '2022-05-19 23:54:34.140988'),
(39, 18, '2022-05-05 18:57:28.818575', '2022-05-19', '2022-05-26 06:53:22.139141'),
(116, 9, '2022-05-06 12:38:57.213352', '2022-05-20', '2022-06-04 18:46:00.316469'),
(80, 4, '2022-05-06 19:32:12.235195', '2022-05-20', '2022-05-13 18:07:30.262606'),
(88, 28, '2022-05-09 16:57:02.283327', '2022-05-23', '2022-05-24 10:45:38.107989'),
(59, 16, '2022-05-10 10:18:10.725054', '2022-05-24', '2022-06-30 09:41:20.182768'),
(4, 10, '2022-05-11 14:01:43.260999', '2022-05-25', '2022-05-24 00:46:43.343492'),
(16, 27, '2022-05-12 12:59:55.374758', '2022-05-26', '2022-06-04 20:31:02.96494'),
(106, 11, '2022-05-12 15:28:15.109885', '2022-05-26', '2022-06-01 11:28:10.409452'),
(115, 3, '2022-05-12 17:13:53.297443', '2022-05-26', '2022-06-06 12:11:26.101853'),
(107, 27, '2022-05-13 13:55:04.110614', '2022-05-27', '2022-05-17 18:45:46.479949'),
(57, 11, '2022-05-16 14:18:24.338066', '2022-05-30', '2022-06-01 02:58:00.265881'),
(22, 19, '2022-05-17 12:02:46.256', '2022-05-31', '2022-06-02 14:34:57.359432'),
(100, 19, '2022-05-17 13:27:41.761887', '2022-05-31', '2022-05-28 11:59:59.363153'),
(110, 22, '2022-05-17 16:53:49.253252', '2022-05-31', '2022-05-28 21:51:42.568678'),
(104, 23, '2022-05-17 19:55:17.419053', '2022-05-31', null),
(95, 15, '2022-05-18 14:12:16.765674', '2022-06-01', '2022-06-11 04:17:50.593317'),
(20, 18, '2022-05-19 12:56:05.522502', '2022-06-02', '2022-05-29 09:21:09.96497'),
(103, 25, '2022-05-19 13:30:38.270586', '2022-06-02', '2022-06-17 20:06:37.042626'),
(27, 20, '2022-05-20 17:34:46.955496', '2022-06-03', '2022-05-21 20:25:43.40664'),
(112, 5, '2022-05-23 10:57:44.724423', '2022-06-06', '2022-06-22 08:38:38.730633'),
(14, 21, '2022-05-24 11:40:36.809586', '2022-06-07', '2022-05-31 14:53:23.770517'),
(73, 14, '2022-05-24 12:00:39.215901', '2022-06-07', '2022-05-30 19:14:45.75156'),
(108, 14, '2022-05-25 10:50:23.724544', '2022-06-08', '2022-06-15 09:19:34.092197'),
(17, 1, '2022-05-26 12:54:00.286569', '2022-06-09', '2022-06-05 22:28:25.643612'),
(69, 27, '2022-05-27 12:44:36.796756', '2022-06-10', '2022-06-11 10:59:03.315205'),
(44, 15, '2022-05-27 15:07:11.915359', '2022-06-10', '2022-06-25 13:06:10.755371'),
(89, 20, '2022-05-27 19:05:43.121606', '2022-06-10', '2022-07-12 12:53:40.561356'),
(20, 24, '2022-05-30 10:49:25.714241', '2022-06-13', '2022-06-15 15:15:38.867578'),
(66, 9, '2022-05-30 19:22:38.341382', '2022-06-13', '2022-06-15 22:38:40.98668'),
(80, 7, '2022-05-31 13:16:54.846261', '2022-06-14', '2022-06-09 05:20:12.839893'),
(83, 24, '2022-05-31 17:18:36.973664', '2022-06-14', '2022-07-01 14:36:02.331719'),
(10, 11, '2022-05-31 19:34:57.76247', '2022-06-14', '2022-06-03 00:29:10.325961'),
(51, 5, '2022-06-01 12:55:21.296217', '2022-06-15', '2022-06-05 14:28:37.576752'),
(64, 23, '2022-06-02 10:32:11.64267', '2022-06-16', null),
(41, 11, '2022-06-03 10:34:44.765402', '2022-06-17', '2022-06-03 14:55:12.380124'),
(110, 10, '2022-06-03 18:45:05.601823', '2022-06-17', null),
(50, 3, '2022-06-06 15:37:14.454277', '2022-06-20', '2022-06-23 06:56:22.59012'),
(25, 6, '2022-06-06 19:48:45.22341', '2022-06-20', '2022-07-02 22:51:52.131292'),
(85, 27, '2022-06-08 13:51:36.948346', '2022-06-22', '2022-07-02 01:56:29.458533'),
(98, 12, '2022-06-08 19:47:39.526757', '2022-06-22', '2022-07-03 20:17:43.177128'),
(107, 15, '2022-06-09 10:58:25.140759', '2022-06-23', '2022-07-16 19:16:40.577513'),
(61, 16, '2022-06-09 16:04:53.945311', '2022-06-23', '2022-06-20 04:26:09.677562'),
(41, 2, '2022-06-10 13:41:47.028432', '2022-06-24', '2022-07-02 06:21:14.863189'),
(96, 5, '2022-06-13 14:59:17.9154', '2022-06-27', '2022-06-20 08:38:30.164026'),
(78, 14, '2022-06-14 19:49:25.357347', '2022-06-28', '2022-07-06 18:03:53.463908'),
(31, 2, '2022-06-15 10:55:12.333293', '2022-06-29', '2022-06-17 09:19:33.368514'),
(77, 8, '2022-06-16 11:15:56.738546', '2022-06-30', '2022-06-24 02:30:48.544288'),
(93, 26, '2022-06-17 19:38:01.002484', '2022-07-01', '2022-06-25 19:49:05.132294'),
(8, 3, '2022-06-20 16:38:50.111934', '2022-07-04', '2022-07-14 06:30:08.356461'),
(32, 7, '2022-06-21 13:35:57.817286', '2022-07-05', null),
(36, 27, '2022-06-22 13:28:38.840335', '2022-07-06', '2022-07-07 10:02:24.131325'),
(2, 23, '2022-06-23 16:43:24.775602', '2022-07-07', '2022-07-19 18:25:52.696963'),
(79, 5, '2022-06-24 11:27:06.807093', '2022-07-08', '2022-07-13 19:28:02.690029'),
(14, 9, '2022-06-24 15:18:35.428251', '2022-07-08', '2022-06-24 22:38:55.693715'),
(4, 4, '2022-06-27 19:32:46.049746', '2022-07-11', '2022-07-08 14:47:20.063282'),
(90, 2, '2022-06-28 13:02:53.551443', '2022-07-12', '2022-07-19 11:35:04.941413'),
(46, 26, '2022-06-29 15:12:17.859999', '2022-07-13', null),
(39, 7, '2022-06-30 12:18:15.75246', '2022-07-14', '2022-07-14 14:20:12.468649'),
(80, 10, '2022-07-05 14:25:11.210021', '2022-07-19', '2022-07-10 06:25:53.74011'),
(84, 26, '2022-07-05 19:52:28.362598', '2022-07-19', '2022-07-07 06:10:25.237373'),
(20, 6, '2022-07-06 10:34:22.163756', '2022-07-20', '2022-07-29 03:48:28.405774'),
(70, 16, '2022-07-07 18:52:39.330957', '2022-07-21', '2022-07-23 03:32:48.936941'),
(55, 22, '2022-07-08 11:22:00.521293', '2022-07-22', '2022-07-14 11:23:20.681635'),
(74, 17, '2022-07-11 15:18:54.785094', '2022-07-25', '2022-08-10 07:50:38.919708'),
(21, 20, '2022-07-12 13:43:21.806783', '2022-07-26', '2022-07-23 04:02:54.472064'),
(53, 28, '2022-07-12 14:45:27.865498', '2022-07-26', '2022-08-08 11:31:23.868524'),
(77, 27, '2022-07-12 19:00:13.453779', '2022-07-26', '2022-07-23 05:37:11.011498'),
(18, 6, '2022-07-13 13:16:33.930797', '2022-07-27', '2022-07-20 13:50:27.197092'),
(106, 26, '2022-07-13 14:12:44.42834', '2022-07-27', null),
(68, 24, '2022-07-13 17:48:28.166565', '2022-07-27', '2022-07-25 17:54:40.399511'),
(36, 22, '2022-07-14 12:14:34.643413', '2022-07-28', '2022-08-07 08:45:18.340864'),
(43, 3, '2022-07-15 16:59:55.398353', '2022-07-29', '2022-08-10 00:39:03.602951'),
(17, 29, '2022-07-15 18:20:47.228558', '2022-07-29', '2022-07-19 06:50:24.374997'),
(15, 8, '2022-07-18 11:15:26.028786', '2022-08-01', null),
(34, 20, '2022-07-19 12:05:13.162413', '2022-08-02', '2022-07-23 10:00:34.699605'),
(99, 22, '2022-07-19 13:30:55.481408', '2022-08-02', '2022-08-06 05:42:01.548273'),
(52, 24, '2022-07-20 12:59:34.667711', '2022-08-03', '2022-07-22 11:17:35.810223'),
(49, 24, '2022-07-21 17:39:30.544932', '2022-08-04', null),
(94, 13, '2022-07-22 12:31:00.403794', '2022-08-05', null),
(71, 5, '2022-07-22 16:00:01.714755', '2022-08-05', '2022-08-01 23:43:40.502847'),
(47, 10, '2022-07-25 15:13:41.826056', '2022-08-08', null),
(103, 27, '2022-07-26 13:54:27.947145', '2022-08-09', '2022-08-08 01:38:49.55757'),
(88, 29, '2022-07-27 16:12:26.597722', '2022-08-10', null),
(115, 23, '2022-07-28 12:24:38.046847', '2022-08-11', '2022-07-28 17:38:19.363408'),
(115, 17, '2022-07-28 17:59:48.251186', '2022-08-11', null),
(28, 8, '2022-07-28 18:14:30.124546', '2022-08-11', null),
(31, 12, '2022-07-29 19:28:45.010597', '2022-08-12', '2022-08-08 17:01:25.268229'),
(69, 15, '2022-08-01 13:52:27.416765', '2022-08-15', '2022-08-05 15:47:16.754051'),
(33, 20, '2022-08-02 13:31:19.481074', '2022-08-16', null),
(20, 19, '2022-08-03 13:45:39.880852', '2022-08-17', null),
(48, 3, '2022-08-03 19:25:28.44283', '2022-08-17', '2022-08-05 11:48:33.253275'),
(66, 3, '2022-08-04 15:48:22.029545', '2022-08-18', null),
(54, 29, '2022-08-05 15:45:03.456133', '2022-08-19', null),
(103, 3, '2022-08-08 13:54:17.942311', '2022-08-22', null),
(61, 3, '2022-08-09 11:55:18.238317', '2022-08-23', null),
(41, 11, '2022-08-10 15:23:12.308987', '2022-08-24', null),
(30, 20, '2022-08-10 18:27:30.350912', '2022-08-24', null)
;
