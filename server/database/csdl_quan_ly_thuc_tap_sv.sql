-- MySQL 8.0.16+ | Quản lý thực tập sinh viên | ERD tinh gọn: 21 bảng.
-- Không DROP, DELETE hay vô hiệu hóa khóa ngoại. Không chuyển dữ liệu từ bản cũ.
-- Các giá trị ENUM là đề xuất để triển khai; đồng bộ với mã nguồn khi tích hợp.
-- Các quy tắc liên bảng (chỉ hồ sơ đã xét đạt; đủ 3 chữ ký đề cương;
-- thứ tự phê duyệt/đóng dấu; giới hạn điểm theo tiêu chí) do dịch vụ kiểm tra.
CREATE DATABASE IF NOT EXISTS quan_ly_thuc_tap_tinh_gon
  CHARACTER SET utf8mb4 COLLATE utf8mb4_unicode_ci;
USE quan_ly_thuc_tap_tinh_gon;
SET NAMES utf8mb4;

-- Đơn vị nhà trường
CREATE TABLE IF NOT EXISTS `don_vi_nha_truong` (
  `id_don_vi` BIGINT NOT NULL AUTO_INCREMENT,
  `ten_don_vi` VARCHAR(200) NOT NULL,
  `loai_don_vi` ENUM('KHOA', 'PHONG_DAO_TAO', 'PHONG_CTSV', 'HANH_CHINH', 'BAN_GIAM_HIEU', 'KHAC') NOT NULL,
  `trang_thai` ENUM('HOAT_DONG', 'NGUNG_HOAT_DONG') NOT NULL,
  PRIMARY KEY (`id_don_vi`)
) ENGINE=InnoDB;

-- Đơn vị thực tập
CREATE TABLE IF NOT EXISTS `don_vi_thuc_tap` (
  `id_don_vi_tt` BIGINT NOT NULL AUTO_INCREMENT,
  `ten_don_vi` VARCHAR(200) NOT NULL,
  `dia_chi` VARCHAR(300) NOT NULL,
  `nguoi_dai_dien` VARCHAR(150) NOT NULL,
  `dien_thoai` VARCHAR(20) NOT NULL,
  `trang_thai` ENUM('HOAT_DONG', 'NGUNG_HOAT_DONG') NOT NULL,
  PRIMARY KEY (`id_don_vi_tt`)
) ENGINE=InnoDB;

-- Tài khoản
CREATE TABLE IF NOT EXISTS `tai_khoan` (
  `id_tai_khoan` BIGINT NOT NULL AUTO_INCREMENT,
  `ten_dang_nhap` VARCHAR(100) NOT NULL,
  `mat_khau_bam` VARCHAR(255) NOT NULL,
  `ho_ten` VARCHAR(150) NOT NULL,
  `email` VARCHAR(200) NOT NULL,
  `trang_thai` ENUM('HOAT_DONG', 'BI_KHOA') NOT NULL,
  PRIMARY KEY (`id_tai_khoan`),
  UNIQUE KEY (`ten_dang_nhap`)
) ENGINE=InnoDB;

-- Vai trò theo phạm vi
CREATE TABLE IF NOT EXISTS `vai_tro_theo_pham_vi` (
  `id_phan_quyen` BIGINT NOT NULL AUTO_INCREMENT,
  `id_tai_khoan` BIGINT NOT NULL,
  `id_don_vi` BIGINT NULL,
  `id_don_vi_tt` BIGINT NULL,
  `ma_vai_tro` ENUM('SINH_VIEN', 'GIAO_VU', 'PHO_KHOA', 'TRUONG_KHOA', 'NHAN_VIEN_DAO_TAO', 'PHO_PHONG_DAO_TAO', 'NHAN_VIEN_CTSV', 'PHO_PHONG_CTSV', 'HANH_CHINH', 'BAN_GIAM_HIEU', 'GIANG_VIEN_HUONG_DAN', 'DON_VI_THUC_TAP', 'NGUOI_TIEP_NHAN', 'NGUOI_QUAN_LY_THUC_TAP', 'NGUOI_HUONG_DAN', 'QUAN_TRI') NOT NULL,
  `hieu_luc_tu` DATE NOT NULL,
  `hieu_luc_den` DATE NULL,
  PRIMARY KEY (`id_phan_quyen`),
  FOREIGN KEY (`id_tai_khoan`) REFERENCES `tai_khoan` (`id_tai_khoan`) ON DELETE RESTRICT ON UPDATE RESTRICT,
  FOREIGN KEY (`id_don_vi`) REFERENCES `don_vi_nha_truong` (`id_don_vi`) ON DELETE RESTRICT ON UPDATE RESTRICT,
  FOREIGN KEY (`id_don_vi_tt`) REFERENCES `don_vi_thuc_tap` (`id_don_vi_tt`) ON DELETE RESTRICT ON UPDATE RESTRICT,
  CHECK (id_don_vi IS NULL OR id_don_vi_tt IS NULL),
  CHECK (hieu_luc_den IS NULL OR hieu_luc_den >= hieu_luc_tu)
) ENGINE=InnoDB;

-- Sinh viên
CREATE TABLE IF NOT EXISTS `sinh_vien` (
  `id_sinh_vien` BIGINT NOT NULL AUTO_INCREMENT,
  `id_tai_khoan` BIGINT NOT NULL,
  `id_khoa` BIGINT NOT NULL,
  `ma_sinh_vien` VARCHAR(30) NOT NULL,
  `lop` VARCHAR(50) NOT NULL,
  `nganh` VARCHAR(100) NOT NULL,
  `ngay_sinh` DATE NOT NULL,
  `trang_thai_hoc` ENUM('DANG_HOC', 'BAO_LUU', 'THOI_HOC', 'DA_TOT_NGHIEP') NOT NULL,
  PRIMARY KEY (`id_sinh_vien`),
  UNIQUE KEY (`id_tai_khoan`),
  FOREIGN KEY (`id_tai_khoan`) REFERENCES `tai_khoan` (`id_tai_khoan`) ON DELETE RESTRICT ON UPDATE RESTRICT,
  FOREIGN KEY (`id_khoa`) REFERENCES `don_vi_nha_truong` (`id_don_vi`) ON DELETE RESTRICT ON UPDATE RESTRICT,
  UNIQUE KEY (`ma_sinh_vien`)
) ENGINE=InnoDB;

-- Kế hoạch và đợt thực tập
CREATE TABLE IF NOT EXISTS `ke_hoach_va_dot_thuc_tap` (
  `id_dot` BIGINT NOT NULL AUTO_INCREMENT,
  `id_khoa` BIGINT NOT NULL,
  `ten_dot` VARCHAR(200) NOT NULL,
  `hoc_ky` VARCHAR(30) NOT NULL,
  `nam_hoc` VARCHAR(20) NOT NULL,
  `ngay_bat_dau` DATE NOT NULL,
  `ngay_ket_thuc` DATE NOT NULL,
  `mo_dang_ky` DATETIME NOT NULL,
  `dong_dang_ky` DATETIME NOT NULL,
  `lich_bao_cao` DATETIME NOT NULL,
  `noi_dung_de_xuat` TEXT NOT NULL,
  `trang_thai` ENUM('NHAP', 'CHO_PHE_DUYET', 'DA_PHE_DUYET', 'TU_CHOI', 'MO_DANG_KY', 'DONG_DANG_KY', 'KET_THUC', 'HUY') NOT NULL,
  PRIMARY KEY (`id_dot`),
  FOREIGN KEY (`id_khoa`) REFERENCES `don_vi_nha_truong` (`id_don_vi`) ON DELETE RESTRICT ON UPDATE RESTRICT,
  CHECK (ngay_ket_thuc >= ngay_bat_dau),
  CHECK (dong_dang_ky >= mo_dang_ky)
) ENGINE=InnoDB;

-- Xét điều kiện
CREATE TABLE IF NOT EXISTS `xet_dieu_kien` (
  `id_xet` BIGINT NOT NULL AUTO_INCREMENT,
  `id_dot` BIGINT NOT NULL,
  `id_sinh_vien` BIGINT NOT NULL,
  `ket_luan` ENUM('CHO_XET', 'DAT', 'KHONG_DAT') NOT NULL,
  `ly_do` TEXT NOT NULL,
  `thoi_gian_xet` DATETIME NOT NULL,
  PRIMARY KEY (`id_xet`),
  FOREIGN KEY (`id_dot`) REFERENCES `ke_hoach_va_dot_thuc_tap` (`id_dot`) ON DELETE RESTRICT ON UPDATE RESTRICT,
  FOREIGN KEY (`id_sinh_vien`) REFERENCES `sinh_vien` (`id_sinh_vien`) ON DELETE RESTRICT ON UPDATE RESTRICT,
  UNIQUE KEY (id_dot, id_sinh_vien)
) ENGINE=InnoDB;

-- Chi tiết xét điều kiện
CREATE TABLE IF NOT EXISTS `chi_tiet_xet_dieu_kien` (
  `id_chi_tiet` BIGINT NOT NULL AUTO_INCREMENT,
  `id_xet` BIGINT NOT NULL,
  `id_nguoi_xac_nhan` BIGINT NOT NULL,
  `ten_tieu_chi` VARCHAR(200) NOT NULL,
  `nguong_ap_dung` VARCHAR(150) NOT NULL,
  `gia_tri_doi_chieu` VARCHAR(150) NOT NULL,
  `nguon_minh_chung` TEXT NOT NULL,
  `ket_qua` ENUM('DAT', 'KHONG_DAT') NOT NULL,
  `thoi_gian_xac_nhan` DATETIME NOT NULL,
  PRIMARY KEY (`id_chi_tiet`),
  FOREIGN KEY (`id_xet`) REFERENCES `xet_dieu_kien` (`id_xet`) ON DELETE RESTRICT ON UPDATE RESTRICT,
  FOREIGN KEY (`id_nguoi_xac_nhan`) REFERENCES `tai_khoan` (`id_tai_khoan`) ON DELETE RESTRICT ON UPDATE RESTRICT
) ENGINE=InnoDB;

-- Hồ sơ thực tập
CREATE TABLE IF NOT EXISTS `ho_so_thuc_tap` (
  `id_ho_so` BIGINT NOT NULL AUTO_INCREMENT,
  `id_xet` BIGINT NOT NULL,
  `id_don_vi_tt` BIGINT NULL,
  `id_gvhd` BIGINT NULL,
  `vi_tri_cong_viec` VARCHAR(200) NOT NULL,
  `mo_ta_cong_viec` TEXT NOT NULL,
  `ngay_tiep_nhan` DATE NULL,
  `ngay_bat_dau_thuc_te` DATE NULL,
  `ngay_ket_thuc_thuc_te` DATE NULL,
  `trang_thai` ENUM('CHO_GOI_DON_VI', 'CHO_DUYET', 'CHO_TIEP_NHAN', 'DA_TIEP_NHAN', 'DANG_THUC_TAP', 'HOAN_THANH', 'TU_CHOI', 'HUY') NOT NULL,
  `ly_do_ngoai_le` TEXT NOT NULL,
  `ngay_nop` DATETIME NOT NULL,
  PRIMARY KEY (`id_ho_so`),
  UNIQUE KEY (`id_xet`),
  FOREIGN KEY (`id_xet`) REFERENCES `xet_dieu_kien` (`id_xet`) ON DELETE RESTRICT ON UPDATE RESTRICT,
  FOREIGN KEY (`id_don_vi_tt`) REFERENCES `don_vi_thuc_tap` (`id_don_vi_tt`) ON DELETE RESTRICT ON UPDATE RESTRICT,
  FOREIGN KEY (`id_gvhd`) REFERENCES `tai_khoan` (`id_tai_khoan`) ON DELETE RESTRICT ON UPDATE RESTRICT
) ENGINE=InnoDB;

-- Người phụ trách hồ sơ
CREATE TABLE IF NOT EXISTS `nguoi_phu_trach_ho_so` (
  `id_phan_cong` BIGINT NOT NULL AUTO_INCREMENT,
  `id_ho_so` BIGINT NOT NULL,
  `id_tai_khoan` BIGINT NOT NULL,
  `vai_tro_thuc_tap` ENUM('NGUOI_TIEP_NHAN', 'NGUOI_QUAN_LY_THUC_TAP', 'NGUOI_HUONG_DAN', 'GIANG_VIEN_HUONG_DAN', 'CAN_BO_CTSV') NOT NULL,
  `ngay_bat_dau` DATE NOT NULL,
  `ngay_ket_thuc` DATE NULL,
  `trang_thai` ENUM('HIEU_LUC', 'KET_THUC', 'HUY') NOT NULL,
  PRIMARY KEY (`id_phan_cong`),
  FOREIGN KEY (`id_ho_so`) REFERENCES `ho_so_thuc_tap` (`id_ho_so`) ON DELETE RESTRICT ON UPDATE RESTRICT,
  FOREIGN KEY (`id_tai_khoan`) REFERENCES `tai_khoan` (`id_tai_khoan`) ON DELETE RESTRICT ON UPDATE RESTRICT,
  CHECK (ngay_ket_thuc IS NULL OR ngay_ket_thuc >= ngay_bat_dau)
) ENGINE=InnoDB;

-- Văn bản và phiên bản
CREATE TABLE IF NOT EXISTS `van_ban_va_phien_ban` (
  `id_phien_ban` BIGINT NOT NULL AUTO_INCREMENT,
  `id_dot` BIGINT NOT NULL,
  `id_ho_so` BIGINT NULL,
  `ma_van_ban` VARCHAR(80) NOT NULL,
  `so_phien_ban` INT NOT NULL,
  `loai_van_ban` ENUM('KE_HOACH', 'GIAY_GIOI_THIEU', 'DE_CUONG', 'PHIEU_NHAN_XET', 'PHIEU_CHAM_DIEM', 'GIAY_XAC_NHAN', 'KHAC') NOT NULL,
  `duong_dan_tep` VARCHAR(1000) NOT NULL,
  `ma_bam_tep` CHAR(64) NOT NULL,
  `trang_thai` ENUM('NHAP', 'CHO_KY', 'DA_KY', 'DA_DONG_DAU', 'DA_PHAT_HANH', 'THU_HOI') NOT NULL,
  `id_nguoi_dong_dau` BIGINT NULL,
  `ngay_dong_dau` DATETIME NULL,
  `ngay_gui` DATETIME NULL,
  `ngay_nhan_lai` DATETIME NULL,
  `noi_nhan` VARCHAR(200) NOT NULL,
  PRIMARY KEY (`id_phien_ban`),
  FOREIGN KEY (`id_dot`) REFERENCES `ke_hoach_va_dot_thuc_tap` (`id_dot`) ON DELETE RESTRICT ON UPDATE RESTRICT,
  FOREIGN KEY (`id_ho_so`) REFERENCES `ho_so_thuc_tap` (`id_ho_so`) ON DELETE RESTRICT ON UPDATE RESTRICT,
  FOREIGN KEY (`id_nguoi_dong_dau`) REFERENCES `tai_khoan` (`id_tai_khoan`) ON DELETE RESTRICT ON UPDATE RESTRICT,
  UNIQUE KEY (ma_van_ban, so_phien_ban),
  CHECK (so_phien_ban > 0)
) ENGINE=InnoDB;

-- Chữ ký xác nhận
CREATE TABLE IF NOT EXISTS `chu_ky_xac_nhan` (
  `id_chu_ky` BIGINT NOT NULL AUTO_INCREMENT,
  `id_phien_ban` BIGINT NOT NULL,
  `id_nguoi_ky` BIGINT NOT NULL,
  `vai_tro_ky` ENUM('SINH_VIEN', 'CTSV', 'NGUOI_HUONG_DAN', 'TRUONG_KHOA', 'DON_VI_THUC_TAP', 'BAN_GIAM_HIEU') NOT NULL,
  `thoi_gian_ky` DATETIME NOT NULL,
  `tham_chieu_chu_ky` VARCHAR(500) NOT NULL,
  `trang_thai` ENUM('HIEU_LUC', 'THU_HOI') NOT NULL,
  PRIMARY KEY (`id_chu_ky`),
  FOREIGN KEY (`id_phien_ban`) REFERENCES `van_ban_va_phien_ban` (`id_phien_ban`) ON DELETE RESTRICT ON UPDATE RESTRICT,
  FOREIGN KEY (`id_nguoi_ky`) REFERENCES `tai_khoan` (`id_tai_khoan`) ON DELETE RESTRICT ON UPDATE RESTRICT
) ENGINE=InnoDB;

-- Đề cương thực tập
CREATE TABLE IF NOT EXISTS `de_cuong_thuc_tap` (
  `id_de_cuong` BIGINT NOT NULL AUTO_INCREMENT,
  `id_ho_so` BIGINT NOT NULL,
  `id_phien_ban` BIGINT NOT NULL,
  `muc_tieu` TEXT NOT NULL,
  `noi_dung` TEXT NOT NULL,
  `ket_qua_du_kien` TEXT NOT NULL,
  `trang_thai` ENUM('NHAP', 'CHO_KY', 'DA_XAC_NHAN', 'TRA_LAI') NOT NULL,
  PRIMARY KEY (`id_de_cuong`),
  UNIQUE KEY (`id_ho_so`),
  FOREIGN KEY (`id_ho_so`) REFERENCES `ho_so_thuc_tap` (`id_ho_so`) ON DELETE RESTRICT ON UPDATE RESTRICT,
  UNIQUE KEY (`id_phien_ban`),
  FOREIGN KEY (`id_phien_ban`) REFERENCES `van_ban_va_phien_ban` (`id_phien_ban`) ON DELETE RESTRICT ON UPDATE RESTRICT
) ENGINE=InnoDB;

-- Lịch biểu thực tập
CREATE TABLE IF NOT EXISTS `lich_bieu_thuc_tap` (
  `id_lich` BIGINT NOT NULL AUTO_INCREMENT,
  `id_de_cuong` BIGINT NOT NULL,
  `tu_ngay` DATE NOT NULL,
  `den_ngay` DATE NOT NULL,
  `nhiem_vu` TEXT NOT NULL,
  `san_pham_du_kien` TEXT NOT NULL,
  `trang_thai` ENUM('DU_KIEN', 'DANG_THUC_HIEN', 'HOAN_THANH', 'HUY') NOT NULL,
  PRIMARY KEY (`id_lich`),
  FOREIGN KEY (`id_de_cuong`) REFERENCES `de_cuong_thuc_tap` (`id_de_cuong`) ON DELETE RESTRICT ON UPDATE RESTRICT,
  CHECK (den_ngay >= tu_ngay)
) ENGINE=InnoDB;

-- Nhật ký và chuyên cần
CREATE TABLE IF NOT EXISTS `nhat_ky_va_chuyen_can` (
  `id_nhat_ky` BIGINT NOT NULL AUTO_INCREMENT,
  `id_lich` BIGINT NOT NULL,
  `id_nguoi_xac_nhan` BIGINT NULL,
  `ngay` DATE NOT NULL,
  `noi_dung` TEXT NOT NULL,
  `ket_qua` TEXT NOT NULL,
  `trang_thai_chuyen_can` ENUM('CO_MAT', 'VANG_CO_PHEP', 'VANG_KHONG_PHEP', 'CHO_XAC_NHAN') NOT NULL,
  `gio_vao` DATETIME NULL,
  `gio_ra` DATETIME NULL,
  `minh_chung` VARCHAR(1000) NOT NULL,
  `nhan_xet` TEXT NOT NULL,
  `thoi_gian_xac_nhan` DATETIME NULL,
  PRIMARY KEY (`id_nhat_ky`),
  FOREIGN KEY (`id_lich`) REFERENCES `lich_bieu_thuc_tap` (`id_lich`) ON DELETE RESTRICT ON UPDATE RESTRICT,
  FOREIGN KEY (`id_nguoi_xac_nhan`) REFERENCES `tai_khoan` (`id_tai_khoan`) ON DELETE RESTRICT ON UPDATE RESTRICT,
  UNIQUE KEY (id_lich, ngay)
) ENGINE=InnoDB;

-- Sự cố và giám sát
CREATE TABLE IF NOT EXISTS `su_co_va_giam_sat` (
  `id_su_co` BIGINT NOT NULL AUTO_INCREMENT,
  `id_ho_so` BIGINT NOT NULL,
  `id_nguoi_bao` BIGINT NOT NULL,
  `id_nguoi_xu_ly` BIGINT NULL,
  `loai_su_kien` ENUM('GIAM_SAT', 'SU_CO') NOT NULL,
  `noi_dung` TEXT NOT NULL,
  `huong_xu_ly` TEXT NOT NULL,
  `trang_thai` ENUM('MO', 'DANG_XU_LY', 'DA_XU_LY') NOT NULL,
  `ngay_ghi_nhan` DATETIME NOT NULL,
  PRIMARY KEY (`id_su_co`),
  FOREIGN KEY (`id_ho_so`) REFERENCES `ho_so_thuc_tap` (`id_ho_so`) ON DELETE RESTRICT ON UPDATE RESTRICT,
  FOREIGN KEY (`id_nguoi_bao`) REFERENCES `tai_khoan` (`id_tai_khoan`) ON DELETE RESTRICT ON UPDATE RESTRICT,
  FOREIGN KEY (`id_nguoi_xu_ly`) REFERENCES `tai_khoan` (`id_tai_khoan`) ON DELETE RESTRICT ON UPDATE RESTRICT
) ENGINE=InnoDB;

-- Phiếu đánh giá
CREATE TABLE IF NOT EXISTS `phieu_danh_gia` (
  `id_phieu` BIGINT NOT NULL AUTO_INCREMENT,
  `id_ho_so` BIGINT NOT NULL,
  `id_nguoi_danh_gia` BIGINT NOT NULL,
  `loai_phieu` ENUM('NHAN_XET', 'CHAM_DIEM') NOT NULL,
  `nhan_xet_chung` TEXT NOT NULL,
  `ngay_nop` DATETIME NOT NULL,
  `trang_thai` ENUM('NHAP', 'DA_NOP', 'DA_XAC_NHAN', 'TRA_LAI') NOT NULL,
  PRIMARY KEY (`id_phieu`),
  FOREIGN KEY (`id_ho_so`) REFERENCES `ho_so_thuc_tap` (`id_ho_so`) ON DELETE RESTRICT ON UPDATE RESTRICT,
  FOREIGN KEY (`id_nguoi_danh_gia`) REFERENCES `tai_khoan` (`id_tai_khoan`) ON DELETE RESTRICT ON UPDATE RESTRICT
) ENGINE=InnoDB;

-- Tiêu chí chấm điểm
CREATE TABLE IF NOT EXISTS `tieu_chi_cham_diem` (
  `id_tieu_chi` BIGINT NOT NULL AUTO_INCREMENT,
  `id_dot` BIGINT NOT NULL,
  `ten_tieu_chi` VARCHAR(200) NOT NULL,
  `diem_toi_da` DECIMAL(5,2) NOT NULL,
  `trong_so` DECIMAL(5,2) NOT NULL,
  `thu_tu` INT NOT NULL,
  PRIMARY KEY (`id_tieu_chi`),
  FOREIGN KEY (`id_dot`) REFERENCES `ke_hoach_va_dot_thuc_tap` (`id_dot`) ON DELETE RESTRICT ON UPDATE RESTRICT,
  CHECK (diem_toi_da > 0),
  CHECK (trong_so BETWEEN 0 AND 100)
) ENGINE=InnoDB;

-- Điểm theo tiêu chí
CREATE TABLE IF NOT EXISTS `diem_theo_tieu_chi` (
  `id_phieu` BIGINT NOT NULL,
  `id_tieu_chi` BIGINT NOT NULL,
  `diem` DECIMAL(5,2) NOT NULL,
  `nhan_xet` TEXT NOT NULL,
  PRIMARY KEY (`id_phieu`, `id_tieu_chi`),
  FOREIGN KEY (`id_phieu`) REFERENCES `phieu_danh_gia` (`id_phieu`) ON DELETE RESTRICT ON UPDATE RESTRICT,
  FOREIGN KEY (`id_tieu_chi`) REFERENCES `tieu_chi_cham_diem` (`id_tieu_chi`) ON DELETE RESTRICT ON UPDATE RESTRICT,
  CHECK (diem >= 0)
) ENGINE=InnoDB;

-- Kết quả thực tập
CREATE TABLE IF NOT EXISTS `ket_qua_thuc_tap` (
  `id_ket_qua` BIGINT NOT NULL AUTO_INCREMENT,
  `id_ho_so` BIGINT NOT NULL,
  `diem_tong_ket` DECIMAL(5,2) NOT NULL,
  `ket_luan` ENUM('DAT', 'KHONG_DAT') NOT NULL,
  `id_don_vi_xac_nhan` BIGINT NULL,
  `id_khoa_phe_duyet` BIGINT NULL,
  `id_dt_ghi_nhan` BIGINT NULL,
  `ngay_xac_nhan` DATETIME NULL,
  `ngay_phe_duyet` DATETIME NULL,
  `ngay_ghi_nhan` DATETIME NULL,
  `trang_thai` ENUM('CHO_XAC_NHAN_DON_VI', 'CHO_PHE_DUYET_KHOA', 'CHO_GHI_NHAN', 'DA_GHI_NHAN', 'TRA_LAI') NOT NULL,
  PRIMARY KEY (`id_ket_qua`),
  UNIQUE KEY (`id_ho_so`),
  FOREIGN KEY (`id_ho_so`) REFERENCES `ho_so_thuc_tap` (`id_ho_so`) ON DELETE RESTRICT ON UPDATE RESTRICT,
  FOREIGN KEY (`id_don_vi_xac_nhan`) REFERENCES `tai_khoan` (`id_tai_khoan`) ON DELETE RESTRICT ON UPDATE RESTRICT,
  FOREIGN KEY (`id_khoa_phe_duyet`) REFERENCES `tai_khoan` (`id_tai_khoan`) ON DELETE RESTRICT ON UPDATE RESTRICT,
  FOREIGN KEY (`id_dt_ghi_nhan`) REFERENCES `tai_khoan` (`id_tai_khoan`) ON DELETE RESTRICT ON UPDATE RESTRICT
) ENGINE=InnoDB;

-- Lịch sử xử lý
CREATE TABLE IF NOT EXISTS `lich_su_xu_ly` (
  `id_lich_su` BIGINT NOT NULL AUTO_INCREMENT,
  `id_ho_so` BIGINT NULL,
  `id_phien_ban` BIGINT NULL,
  `id_dot` BIGINT NULL,
  `id_nguoi_xu_ly` BIGINT NOT NULL,
  `buoc_xu_ly` VARCHAR(100) NOT NULL,
  `hanh_dong` VARCHAR(100) NOT NULL,
  `trang_thai_cu` VARCHAR(50) NOT NULL,
  `trang_thai_moi` VARCHAR(50) NOT NULL,
  `du_lieu_truoc` JSON NOT NULL,
  `du_lieu_sau` JSON NOT NULL,
  `ly_do` TEXT NOT NULL,
  `thoi_gian` DATETIME NOT NULL,
  PRIMARY KEY (`id_lich_su`),
  FOREIGN KEY (`id_ho_so`) REFERENCES `ho_so_thuc_tap` (`id_ho_so`) ON DELETE RESTRICT ON UPDATE RESTRICT,
  FOREIGN KEY (`id_phien_ban`) REFERENCES `van_ban_va_phien_ban` (`id_phien_ban`) ON DELETE RESTRICT ON UPDATE RESTRICT,
  FOREIGN KEY (`id_dot`) REFERENCES `ke_hoach_va_dot_thuc_tap` (`id_dot`) ON DELETE RESTRICT ON UPDATE RESTRICT,
  FOREIGN KEY (`id_nguoi_xu_ly`) REFERENCES `tai_khoan` (`id_tai_khoan`) ON DELETE RESTRICT ON UPDATE RESTRICT
) ENGINE=InnoDB;
