INSERT INTO user_account
(NAME, PHONE_NUMBER, EMAIL, ACCOUNT_PASSWORD, GENDER, AVATAR) VALUES
('Đặng Quí', '0474213546', 'dangqui@example.com', 'dangqui', 'Male', NULL),
('Vương Anh Tuấn', '036988860', 'vuonganhtuan@example.com', 'vuonganhtuan', 'Male', NULL),
('Lạc Toàn Quân', '0119094843', 'lactoanquan@example.com', 'lactoanquan', 'Male', NULL),
('Chu Minh Thức', '0276301993', 'chuminhthuc@example.com', 'chuminhthuc', 'Male', NULL),
('Phan Ngọc Giác', '0257991897', 'phanngocgiac@example.com', 'phanngocgiac', 'Male', NULL),
('Vương Kim', '0880550902', 'vuongkim@example.com', 'vuongkim', 'Female', NULL),
('Trương Thị Vy', '0393012273', 'truongthivy@example.com', 'truongthivy', 'Female', NULL),
('Ngô Tham', '0438911414', 'ngotham@example.com', 'ngotham', 'Male', NULL),
('Đào Bình Viện', '0478471276', 'daobinhvien@example.com', 'daobinhvien', 'Male', NULL),
('Trương Trúc Nam', '0772619483', 'truongtrucnam@example.com', 'truongtrucnam', 'Female', NULL);

INSERT INTO user_notification
(TITLE, CONTENT,TIME) VALUES
('Deal sốc năm mới','Từ 1/1/2026 đến ngày 3/1/2026, giảm 30% cho cuốc đi xe ôtô.','2026-01-01 09:30:00'),
('Khao trọn ngày cá tháng tư','Trong ngày 1/4/2026, giảm 15% nếu thanh toán bằng thẻ tín dụng OCB','2026-04-01 09:00:00'),
('Ưu đãi từ BIDV','Từ hôm nay đến ngày 31/12/2026, BIDV có ưu đãi dành cho chủ thẻ BIDV, giảm 10.000 cho các cuốc >= 30.000, giảm 30.000 cho cuốc từ 90.000','2026-02-02 09:30:00'),
('Liên kết ví Momo, trao deal liền tay!','Đến 1/6/2026, liên kết ví Momo để nhận ngay ưu đãi giảm 20% cho cuốc đi xe ôtô.','2026-02-13 09:30:00'),
('Ưu đãi đặc biệt từ Vietcombank','Từ hôm nay đến ngày 1/5/2026, Vietcombank có ưu đãi dành cho chủ thẻ Vietcombank, giảm 15.000 cho các cuốc >= 45.000, giảm 50.000 cho cuốc từ 150.000','2026-02-14 09:30:00');

INSERT INTO TRANSPORT_MODE
(TYPE, SEAT_CAPACITY, SERVICE_LEVEL) VALUES
('Bike', 1, 'Standard'),
('Bike', 1, 'Saver'),
('Car', 4, 'Standard'),
('Car', 4, 'Saver'),
('Car', 4, 'Electric'),
('Car', 6, 'Standard');

INSERT INTO DISCOUNT
(MAX_USAGE,VALID_UNTIL_DATE,DISCOUNT_TYPE,PERCENTAGE_DISCOUNT,AMOUNT_DISCOUNT) VALUES
(5, '2026-01-01 23:59:59', 'Percentage', 0.30, NULL),
(5, '2026-04-01 23:59:59', 'Percentage', 0.15, NULL),
(5, '2026-12-31 23:59:59', 'Amount', NULL, 10000),
(5, '2026-12-31 23:59:59', 'Amount', NULL, 30000),
(5, '2026-06-01 23:59:59', 'Percentage', 0.20, NULL),
(5, '2026-05-01 23:59:59', 'Amount', NULL, 15000),
(5, '2026-05-01 23:59:59', 'Amount', NULL, 50000);