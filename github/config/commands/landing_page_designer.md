---
description: Thiết kế Landing Page bán khóa học online chuẩn CRO — từ copywriting đến code HTML/CSS/JS hoàn chỉnh
argument-hint: [thị-trường-mục-tiêu] [vấn-đề-cần-giải-quyết]
---

Kích hoạt quy trình thiết kế Landing Page bán khóa học online hoàn chỉnh theo chuẩn Direct-Response Marketing và UI/UX tối ưu chuyển đổi (CRO). Agent sẽ đồng hành từng bước: thu thập thông tin → lên nội dung copywriting → thiết kế & code HTML → preview & tinh chỉnh.

<args>$ARGUMENTS</args>

---

## 📋 Bảng tùy chọn tham số

| Tham số | Giá trị hợp lệ | Ví dụ |
|---|---|---|
| `thị-trường-mục-tiêu` | Nhóm khách hàng cụ thể (nghề nghiệp, độ tuổi, tình trạng...) | `freelancer`, `bà mẹ bỉm sữa`, `nhân viên văn phòng` |
| `vấn-đề-cần-giải-quyết` | Nỗi đau / vấn đề chính của nhóm khách hàng đó | `không có khách hàng`, `thiếu thời gian`, `thu nhập thấp` |

> **Lưu ý:** Nếu bỏ trống tham số, Agent sẽ chủ động hỏi từng thông tin theo đúng quy trình thu thập ở Bước 1.

---

## ⚙️ Quy trình thực thi (Tóm tắt 4 bước)

1. **Thu thập thông tin:** Hỏi về thị trường mục tiêu, vấn đề, thông tin khóa học và giảng viên. Dừng lại chờ xác nhận.
2. **Lên nội dung Copywriting:** Đề xuất Bonuses (giải quyết micro-problem), viết nội dung toàn bộ Sales Page theo template 10 section bằng tiếng Việt. Dừng lại chờ duyệt.
3. **Thiết kế & Code HTML/CSS/JS:** Chuyển hóa nội dung thành giao diện đẹp, responsive, tích hợp đồng hồ đếm ngược, form đăng ký, QR thanh toán (SePay/VietQR), và iframe YouTube (nếu có). Xuất file HTML để Preview.
4. **CRO Review & Tinh chỉnh:** Kiểm tra friction points, hỏi người dùng muốn điều chỉnh gì và cập nhật lại.

---

## 💡 Ví dụ lệnh

### Ví dụ 1 — Cơ bản (để Agent tự hỏi)
```
/landing_page_designer
```
> Agent sẽ bắt đầu bằng việc hỏi toàn bộ thông tin cần thiết theo quy trình Bước 1.

---

### Ví dụ 2 — Truyền tham số trực tiếp
```
/landing_page_designer freelancer-thiết-kế-đồ-họa không-có-khách-hàng-ổn-định
```
> Agent sẽ bỏ qua phần hỏi thị trường & vấn đề, tiếp tục hỏi các thông tin còn lại (tên khóa học, giảng viên, mức giá...).

---

### Ví dụ 3 — Kèm thông tin chi tiết ngay trong prompt
```
/landing_page_designer

Thị trường: Coach/Mentor mới bắt đầu
Vấn đề: Không biết cách đóng gói kiến thức thành khóa học và bán online
Tên khóa học: "Coach Pro — Hệ thống đóng gói & bán khóa học 0→1"
Giảng viên: Nguyễn Văn A — 5 năm kinh nghiệm đào tạo, 500+ học viên
Mức giá: 1.990.000 VNĐ (gốc 3.990.000 VNĐ)
```
> Agent sẽ bắt đầu ngay Bước 2 (lên Bonuses và Copywriting) mà không cần hỏi thêm thông tin cơ bản.

---

## 🔥 Tips sử dụng hiệu quả

- **Cung cấp trước càng nhiều thông tin càng tốt** (tên khóa học, mức giá, link YouTube học thử, thông tin giảng viên) để Agent bỏ qua phần hỏi và đi thẳng vào thiết kế.
- **Duyệt kỹ phần Copywriting (Bước 2) trước** khi Agent code. Sửa văn phong ở bước này dễ hơn nhiều so với sửa trong HTML.
- **Cung cấp link YouTube** để Agent nhúng video học thử vào section "Xem trước nội dung". Nhớ bỏ tham số `?si=...` trước khi đưa link.
- **Để tích hợp thanh toán QR (SePay/VietQR)**, cung cấp thêm: số tài khoản ngân hàng, tên ngân hàng, và tên chủ tài khoản ở Bước 1.
