# GreenTech Infrastructure & Technical Log Management

Mini project mô phỏng quản trị hạ tầng: tổ chức dữ liệu, lọc log theo luồng, quản lý tài sản IoT và đối soát mã linh kiện.

## 1. Cấu trúc

```text
Pham_lop_MonHoc_MiniProject_Infrastructure/
├── docs/README.md
├── docs/srs-he-thong.docx
├── scripts/auto_report.bat
├── data/log-he-thong.log
├── data/quan-ly-thiet-bi.xlsx
├── backup/bao-cao-su-co.txt
├── .env
└── .gitignore
```

## 2. Khởi tạo cây thư mục bằng một dòng lệnh

```bat
mkdir greentech-system\docs greentech-system\scripts greentech-system\data greentech-system\backup
```

Tên thư mục dùng chữ ASCII, không dấu và không khoảng trắng.

## 3. Chạy script

Mở Command Prompt tại thư mục gốc dự án:

```bat
scripts\auto_report.bat
```

Script kiểm tra log nguồn, tạo `backup/` nếu cần, ghi tiêu đề rồi nối các dòng `CRITICAL` hoặc `ERROR` vào `backup/bao-cao-su-co.txt`. Lệnh `type | findstr` xử lý theo luồng, không cần nạp toàn bộ tệp vào một biến RAM.

## 4. Cấu hình môi trường

`.env` trong dự án chỉ chứa dữ liệu giả lập. Không commit thông tin xác thực thật; `.gitignore` đã loại `.env`.

```dotenv
APP_ENV=development
LOG_LEVEL=INFO
DB_HOST=localhost
DB_USER=greentech_demo
DB_PASSWORD=CHANGE_ME_NOT_A_REAL_PASSWORD
```

## 5. Excel: Asset Database

Workbook có hai sheet:
- `danh-muc-linh-kien`: `ma_linh_kien` (khóa chính), `ten_thiet_bi`, `don_gia`, `loai_storage`.
- `trang-thai-tram`: `ma_tram`, `ma_linh_kien` (khóa ngoại), `dung_luong_ram`, `ngay_lap_dat`, `ten_thiet_bi` tra cứu.

Công thức mẫu tại `E2`:

```excel
=IFERROR(VLOOKUP(TRIM(B2),'danh-muc-linh-kien'!$A$2:$D$11,2,FALSE),"KHONG_TIM_THAY_MA")
```

`TRIM` bỏ khoảng trắng thừa, `$` cố định vùng dữ liệu, `FALSE` yêu cầu khớp chính xác. `IFERROR` hiển thị thông báo dễ hiểu nếu mã chưa tồn tại; vẫn phải kiểm tra mã không khớp. Nếu Excel dùng dấu `;` làm dấu phân cách, thay dấu phẩy bằng dấu chấm phẩy.

## 6. IPO và DIKW

- **Input:** log thô, danh mục linh kiện, dữ liệu trạm.
- **Process:** kiểm tra đường dẫn, lọc từ khóa, chuẩn hóa mã, tra cứu.
- **Output:** báo cáo sự cố và bảng tài sản đã đối soát.
- **DIKW:** Data = log thô; Information = dòng lỗi đã lọc; Knowledge = nhận diện lỗi lặp lại; Wisdom = ưu tiên xử lý theo mức độ và tần suất.

## 7. Tính thời gian tải log

`Thời gian (giây) = Kích thước (MB) × 8 / Tốc độ (Mbps)`

Ví dụ 500 MB qua mạng 100 Mbps: `500 × 8 / 100 = 40 giây` tối thiểu, chưa tính overhead và tốc độ ghi đĩa.

## 8. Checklist nghiệm thu

- [ ] Có đủ `docs/`, `scripts/`, `data/`, `backup/`.
- [ ] Script lọc đúng `CRITICAL`/`ERROR` và không xóa tệp.
- [ ] Workbook có 100 trạm, không merge cell trong vùng dữ liệu.
- [ ] VLOOKUP dùng `TRIM`, `FALSE`, tham chiếu tuyệt đối.
- [ ] SRS có Heading Styles và trường mục lục tự động.
- [ ] `.env` chỉ có giá trị giả và không chứa bí mật thật.

in
```
