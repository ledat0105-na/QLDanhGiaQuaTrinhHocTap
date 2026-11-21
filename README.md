# Quản lý thực tập sinh viên – Nhóm Mất phương hướng

Nhóm trưởng: **Lê Nguyễn Tiến Đạt**. Server dùng Java 17, Spring Boot MVC, Gradle (Groovy DSL). Client dùng HTML/CSS/JavaScript, được đóng gói cùng server khi build nhưng mã nguồn vẫn ở thư mục riêng.

| Thành viên | Mô-đun | Nhánh đề xuất | Phần việc |
|---|---|---|---|
| Trần Quốc Cường | hoc-vu | feature/hoc-vu | Tài khoản, phân quyền, đơn vị và sinh viên |
| Lê Nguyễn Tiến Đạt (nhóm trưởng) | dang-ky | feature/dang-ky | Đợt, xét điều kiện, đăng ký và phân công; tích hợp các mô-đun |
| Lê Nguyễn Hải | van-ban | feature/van-ban | Đề cương, ký xác nhận, đóng dấu và phát hành |
| Trương Văn Trà | theo-doi | feature/theo-doi | Tiến độ, chuyên cần, đánh giá, điểm và kết quả |

Mỗi người phụ trách cả Model/Controller trong `server/src/main/java/vn/quanlythuctap/modules/` lẫn View tương ứng trong `client/modules/`. API mẫu: `GET /api/modules/{ma}`. SQL MySQL 21 bảng ở `server/database/schema.sql`. Demo chỉ đọc dữ liệu mẫu, chưa kết nối MySQL hoặc thực hiện xác thực/CRUD.

## Chạy ở máy cá nhân

Cài JDK 17 và Gradle 8.14.x, sau đó:

```sh
cd server
gradle test
gradle bootRun
```

Mở http://localhost:8080. Trong IntelliJ IDEA có thể mở `server/build.gradle` dưới dạng Gradle project nhưng cần giữ nguyên thư mục `client` bên cạnh `server`. Để bổ sung Gradle Wrapper, chạy `gradle wrapper --gradle-version 8.14.3` từ `server`, sau đó dùng `gradlew.bat bootRun` trên Windows hoặc `./gradlew bootRun` trên macOS/Linux.

## Đưa lên GitHub

Nhóm trưởng tạo repo Public trống, mở terminal tại thư mục chứa README:

```sh
git init -b main
git add .
git commit -m "Khoi tao MVC Spring Boot va phan cong nhom"
git remote add origin https://github.com/TAI_KHOAN/quan-ly-thuc-tap-mvc.git
git push -u origin main
```

Thay URL bằng repo thật. Mời ba thành viên vào repo. Mỗi người tạo nhánh được giao, tự commit và mở Pull Request vào `main`. Không đưa mật khẩu, dữ liệu sinh viên thật hoặc tệp cấu hình bí mật lên repo Public.
