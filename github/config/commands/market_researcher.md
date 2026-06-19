---
description: Nghiên cứu thị trường chuyên sâu — phân tích nhu cầu, đối thủ, quy mô thị trường và đưa ra quyết định Go/No-Go
argument-hint: [ngách/thị trường] [loại phân tích]
---

Thực hiện nghiên cứu thị trường toàn diện cho ngách hoặc thị trường được chỉ định.

<args>$ARGUMENTS</args>

---

## Tùy chọn tham số

| Tham số | Giá trị hợp lệ | Mô tả |
|---------|----------------|-------|
| `[ngách]` | Bất kỳ thị trường/ngách nào | Thị trường cần nghiên cứu. VD: `khóa học online`, `SaaS tools`, `FMCG` |
| `[loại phân tích]` | `validate` / `size` / `competitor` / `trend` / `full` | Loại phân tích cần thực hiện |

### Giá trị cho `[loại phân tích]`:

| Giá trị | Mô tả |
|---------|-------|
| `validate` | Chạy Niche Validation Checklist (20 tiêu chí) — nhanh, tập trung vào Go/No-Go |
| `size` | Tập trung vào TAM/SAM/SOM và định lượng thị trường |
| `competitor` | Deep-dive phân tích đối thủ cạnh tranh |
| `trend` | Phân tích xu hướng và forecast trajectory |
| `full` | Research toàn diện theo RAPP Framework (mặc định) |

---

## Quy trình thực thi

1. **Kích hoạt** Market Research Agent (`agents/market_researcher.md`)
2. **Load** Market Research Skill (`skills/market_research/SKILL.md`)
3. **Xác định loại phân tích** dựa trên argument (mặc định: `full`)
4. **Thu thập thông tin** — đặt câu hỏi về target audience, scope, objectives
5. **Chạy Live Research** — web search, fetch competitor data, marketplace signals
6. **Áp dụng Framework** — TAM/SAM/SOM, PESTEL, Gap Analysis, Validation Checklist
7. **Output Report** theo template trong `skills/market_research/templates/`

---

## Ví dụ lệnh

```
/market_researcher khóa học online marketing
```
→ Full market research cho thị trường khóa học marketing online tại Việt Nam

```
/market_researcher SaaS tools quản lý dự án validate
```
→ Chạy Niche Validation Checklist (20 tiêu chí) nhanh để Go/No-Go decision

```
/market_researcher dropshipping mỹ phẩm competitor
```
→ Deep-dive phân tích top 10 đối thủ trong ngách dropshipping mỹ phẩm

```
/market_researcher edtech vietnam size
```
→ Tập trung định lượng quy mô thị trường EdTech Việt Nam (TAM/SAM/SOM)

```
/market_researcher digital agency trend
```
→ Phân tích xu hướng thị trường digital agency và forecast 2-3 năm tới

---

## Tips sử dụng hiệu quả

💡 **Combine commands:** Sau `/market_researcher [ngách] validate`, dùng `/market_researcher [ngách] competitor` để có full picture trước khi ra quyết định.

💡 **Start broad, then narrow:** Đầu tiên research `khóa học online`, sau đó narrow xuống `khóa học Photoshop cho freelancer` dựa trên gaps tìm thấy.

💡 **Feed into other agents:** Kết quả research là foundation cho:
- `/ad_content_writer` — Viết ad copy dựa trên pain points tìm được
- `/landing_page_designer` — Build landing page với positioning đã xác định
- `/course_outline_creator` — Design course cho nhu cầu validated

💡 **Trigger đầy đủ workflow:** Gõ "Chào Hivi Hiếu Nguyễn" để agent hỏi thông tin đầy đủ trước khi bắt đầu — tốt hơn khi bạn chưa biết chính xác mình cần gì.

💡 **Save your reports:** Yêu cầu agent export report ra file Markdown để lưu lại và share với team.
