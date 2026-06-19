---
description: Thiết kế slide bài giảng chuyên nghiệp bằng HTML/CSS — từ outline đến bộ slide sư phạm hoàn chỉnh có preview trực quan
argument-hint: [tên-bài-giảng] [số-slide]
---

Khởi động **Hivi Slide Designer** để chuyển hóa dàn ý bài giảng thành bộ slide HTML/CSS chuyên nghiệp, thẩm mỹ cao — với quy trình Planning → Preview → Review → Export.

<args>$ARGUMENTS</args>

---

## Tùy chọn tham số

| Tham số | Giá trị hợp lệ | Mô tả |
|---------|----------------|-------|
| `[tên-bài-giảng]` | Bất kỳ tên bài/chủ đề nào | Tên bài giảng hoặc chủ đề cần thiết kế slide. VD: `gioi-thieu-khoa-hoc`, `module-1-nen-tang` |
| `[số-slide]` | Số nguyên hoặc `auto` | Số slide mong muốn (mặc định: `12`). Dùng `auto` để agent tự đề xuất |

### Layout chuẩn hỗ trợ:

| Layout | Khi nào dùng |
|--------|-------------|
| `Title_Slide` | Slide tiêu đề đầu bài |
| `Section_Title` | Slide tiêu đề chương/phần |
| `Two_Column` | So sánh hai nội dung song song |
| `Tiled_Text_With_Icons` | Danh sách điểm kèm icon |
| `Timeline` | Quy trình, lộ trình, lịch sử |
| `Chart` | Biểu đồ số liệu |
| `Table` | Bảng dữ liệu so sánh |
| `Quote` | Trích dẫn nổi bật |
| `Full_Image` | Hình minh họa toàn trang |

---

## Quy trình thực thi

1. **Kích hoạt** Slide Designer Agent (`agents/slide_designer.md`)
2. **Load** Slide Designer Skill (`skills/slide_designer/SKILL.md`)
3. **Nhận dàn ý** từ người dùng (output từ `/course_outline_creator` hoặc paste trực tiếp)
4. **Lập kế hoạch slide** — đề xuất số lượng, layout, nội dung chính cho từng slide; chờ xác nhận
5. **Tạo HTML Preview** — thiết kế tĩnh bằng HTML/CSS trong khối `slides:title:filename.html`; chờ duyệt
6. **Review & Hiệu chỉnh** — sửa theo phản hồi, lặp cho đến khi ưng ý
7. **Export** — xác nhận cấu trúc cuối và hướng dẫn chuyển sang `.pptx`

> **Nguyên tắc Stop & Wait:** Agent KHÔNG tự ý chuyển bước nếu chưa có xác nhận từ người dùng.

---

## Ví dụ lệnh

```
/slide_designer
```
→ Kích hoạt agent, chờ người dùng paste dàn ý để bắt đầu quy trình Planning

```
/slide_designer gioi-thieu-khoa-hoc 10
```
→ Thiết kế bộ 10 slide cho bài giảng Giới thiệu khóa học

```
/slide_designer module-marketing-can-ban auto
```
→ Thiết kế slide cho Module Marketing Căn bản, để agent tự đề xuất số lượng tối ưu

```
/slide_designer nen-tang-tai-chinh 15
```
→ Thiết kế 15 slide cho bài giảng Nền tảng Tài chính cá nhân

---

## Tips sử dụng hiệu quả

💡 **Dùng output từ `/course_outline_creator`:** Copy từng dòng trong bảng dàn ý 5 cột làm input cho slide designer — agent sẽ tự phân bổ layout phù hợp.

💡 **Chỉ định layout rõ ràng nếu biết:** Gợi ý layout mong muốn trong yêu cầu (VD: "dùng Timeline cho phần quy trình") để agent không cần đoán mò.

💡 **Preview trước khi chốt:** Luôn yêu cầu xem HTML Preview trước khi đồng ý export — tránh phải sửa lại nhiều lần sau.

💡 **Batch theo module:** Thiết kế từng module riêng (10-15 slide/lần) thay vì toàn bộ khóa học một lúc — dễ review và kiểm soát chất lượng hơn.

💡 **Feed into other agents:** Sau khi có slide, dùng nội dung để:
- `/video_script_writer` — Viết kịch bản video bài giảng dựa trên slide
- `/ad_content_writer` — Trích dẫn key points từ slide làm hook quảng cáo
