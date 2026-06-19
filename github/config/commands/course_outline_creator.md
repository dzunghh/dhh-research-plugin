---
description: Thiết kế dàn ý khóa học chuyên nghiệp — cấu trúc chương trình, mục tiêu học tập, và lộ trình bài giảng
argument-hint: [tên-khóa-học] [đối-tượng]
---

Khởi động **Hivi Course Outline Creator** để thiết kế dàn ý khóa học chuyên nghiệp — từ khai thác thông tin thô đến bảng dàn ý 5 cột hoàn chỉnh, sẵn sàng chuyển sang thiết kế slide.

<args>$ARGUMENTS</args>

---

## Tùy chọn tham số

| Tham số | Giá trị hợp lệ | Mô tả |
|---------|----------------|-------|
| `[tên-khóa-học]` | Bất kỳ tên/chủ đề nào | Tên hoặc chủ đề khóa học cần thiết kế. VD: `marketing-online`, `lap-trinh-python`, `ky-nang-thuyet-trinh` |
| `[đối-tượng]` | Xem bảng dưới | Phân khúc học viên mục tiêu |

### Giá trị cho `[đối-tượng]`:

| Giá trị | Mô tả |
|---------|-------|
| `nguoi-moi` | Người mới bắt đầu hoàn toàn, chưa có nền tảng |
| `nguoi-di-lam` | Người đi làm muốn nâng cấp kỹ năng hoặc chuyển ngành |
| `sinh-vien` | Học sinh, sinh viên đang học tập |
| `chuyen-gia` | Chuyên sâu, nâng cao năng lực chuyên môn |
| `nguoi-kinh-doanh` | Chủ doanh nghiệp, freelancer, người kinh doanh |

---

## Quy trình thực thi

1. **Kích hoạt** Course Outline Creator Agent (`agents/course_outline_creator.md`)
2. **Load** Course Outline Skill (`skills/course_outline_creator/SKILL.md`)
3. **Thu thập thông tin** — hỏi 6 câu: tên khóa học, đối tượng, mục tiêu, thời lượng, số bài giảng, phong cách giảng dạy
4. **Thiết kế dàn ý** — tạo bảng Markdown 5 cột (Tên Chương/Bài, Nội Dung Chính, Mục Tiêu, Hoạt Động, Tài Nguyên)
5. **Gợi ý bổ sung** — đề xuất bài tập nhóm, chứng chỉ, buổi Q&A; kết thúc bằng "Nếu cần chỉnh sửa thêm, hãy cho mình biết nhé!"

---

## Ví dụ lệnh

```
/course_outline_creator
```
→ Kích hoạt agent, chờ trigger "Chào Hivi Hiếu Nguyễn" để bắt đầu quy trình hỏi đáp đầy đủ

```
/course_outline_creator marketing-online nguoi-di-lam
```
→ Thiết kế dàn ý khóa học Marketing Online cho người đi làm muốn chuyển ngành

```
/course_outline_creator lap-trinh-python nguoi-moi
```
→ Thiết kế dàn ý khóa học Lập trình Python từ đầu cho người mới hoàn toàn

```
/course_outline_creator ky-nang-thuyet-trinh nguoi-kinh-doanh
```
→ Thiết kế dàn ý khóa học Thuyết trình chuyên nghiệp cho chủ doanh nghiệp

---

## Tips sử dụng hiệu quả

💡 **Trigger đầy đủ workflow:** Gõ "Chào Hivi Hiếu Nguyễn" để agent hỏi đủ 6 câu — cho ra dàn ý chính xác nhất với đúng bối cảnh.

💡 **Cung cấp mục tiêu đầu ra rõ ràng:** Mô tả cụ thể "học viên sẽ làm được gì sau khóa học" giúp agent phân bổ nội dung theo Bloom's Taxonomy chuẩn.

💡 **Feed into other agents:** Dàn ý hoàn chỉnh là nền tảng để:
- `/slide_designer` — Thiết kế slide từng bài giảng theo dàn ý
- `/video_script_writer` — Viết kịch bản video quảng cáo cho khóa học
- `/ad_content_writer` — Viết ad copy dựa trên kết quả và modules của khóa học

💡 **Iterate từng chương:** Có thể yêu cầu agent đi sâu vào từng chương để mở rộng nội dung bài giảng chi tiết hơn.
