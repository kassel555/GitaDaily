# 🎯 Curated Topic Rotation - How It Works

## Overview

Instead of showing verses sequentially (1.1 → 18.78), **GitaDaily uses a curated approach** that groups verses by theme and rotates through topics each day. This ensures variety and relevance to different life situations.

---

## 📅 Weekly Rotation Schedule

| Day       | Topic              | Why This Day?                                   |
|-----------|--------------------|-------------------------------------------------|
| Monday    | Duty & Action      | Start the week with purpose and clarity         |
| Tuesday   | Stress & Anxiety   | Manage mid-week pressures                       |
| Wednesday | Discipline         | Build habits at the week's midpoint             |
| Thursday  | Wisdom             | Reflect deeply as the week progresses           |
| Friday    | Devotion           | Connect spiritually before the weekend          |
| Saturday  | Karma Yoga         | Understand selfless action                      |
| Sunday    | Courage            | Face fears and prepare for the new week         |

**Cycles through**: Duty → Stress → Discipline → Wisdom → Devotion → Karma → Courage

---

## 🔄 How Verses Are Selected

### 1. Determine Today's Topic
```swift
let dayOfWeek = Calendar.current.component(.weekday, from: Date())
// 1 = Sunday, 2 = Monday, ... 7 = Saturday

let topicRotation = [.duty, .stress, .discipline, .wisdom, .devotion, .karma, .courage]
let todayTopic = topicRotation[(dayOfWeek - 1) % 7]
```

**Example**:
- Today is **Wednesday** (weekday = 4)
- Index = (4 - 1) % 7 = 3
- Topic = `topicRotation[3]` = **Wisdom** ✨

### 2. Filter Verses by Topic
```swift
let versesForTopic = allVerses.filter { $0.topic == todayTopic }
// Returns all "Wisdom" verses
```

**Example**: If "Wisdom" has 3 verses:
- BG 18.78
- BG 2.56  
- BG 13.8

### 3. Rotate Within Topic
```swift
let daysSinceStart = days between Jan 1, 2025 and today
let verseIndex = (daysSinceStart / 7) % versesForTopic.count
todayVerse = versesForTopic[verseIndex]
```

**Why divide by 7?** Each topic appears once per week, so we rotate through verses of that topic across weeks.

**Example**:
- Week 1 Wednesday: Verse 0 (BG 18.78)
- Week 2 Wednesday: Verse 1 (BG 2.56)
- Week 3 Wednesday: Verse 2 (BG 13.8)
- Week 4 Wednesday: Verse 0 (cycles back)

---

## 🎨 The 10 Topics

### 1. **Duty & Action** (Karma)
Focus on responsibility, purpose, and doing what's right.
- Icon: `checkmark.circle.fill`
- Color: Blue
- Sample: BG 2.47 - "You have the right to perform your duty..."

### 2. **Stress & Anxiety** (Shanti)
Managing worry, finding peace, emotional balance.
- Icon: `heart.fill`
- Color: Green
- Sample: BG 2.56 - "One who is not disturbed by misery..."

### 3. **Wisdom** (Jnana)
Deep understanding, clarity, knowledge.
- Icon: `brain.head.profile`
- Color: Purple
- Sample: BG 18.78 - "Wherever there is Krishna..."

### 4. **Devotion** (Bhakti)
Surrender, faith, love for the Divine.
- Icon: `flame.fill`
- Color: Orange
- Sample: BG 18.66 - "Abandon all dharmas..."

### 5. **Discipline** (Sadhana)
Self-control, consistency, practice.
- Icon: `target`
- Color: Red
- Sample: BG 6.35 - "The mind is restless..."

### 6. **Detachment** (Vairagya)
Non-attachment, letting go, equanimity.
- Icon: `leaf.fill`
- Color: Teal
- Sample: BG 2.14 - "Heat and cold, pleasure and pain..."

### 7. **Karma Yoga** (Nishkama Karma)
Selfless action, working without expectation.
- Icon: `arrow.triangle.2.circlepath`
- Color: Indigo
- Sample: BG 4.18 - "Seeing inaction in action..."

### 8. **Knowledge** (Vidya)
Self-knowledge, understanding reality.
- Icon: `book.fill`
- Color: Yellow
- Sample: BG 5.21 - "Joy within..."

### 9. **Courage** (Vira)
Fearlessness, strength, bravery.
- Icon: `shield.fill`
- Color: Pink
- Sample: BG 2.38 - "Treating pleasure and pain alike..."

### 10. **Purpose** (Svadharma)
Life purpose, personal path, calling.
- Icon: `compass.fill`
- Color: Cyan
- Sample: BG 3.35 - "Better to perform one's own duty..."

---

## 📊 Distribution Example

With 15 sample verses distributed across topics:

| Topic              | Count | %    | Example Verses            |
|--------------------|-------|------|---------------------------|
| Duty & Action      | 2     | 13%  | BG 2.47, 3.35            |
| Stress & Anxiety   | 2     | 13%  | BG 2.56, 6.5             |
| Wisdom             | 3     | 20%  | BG 18.78, 13.8, 5.21     |
| Devotion           | 3     | 20%  | BG 9.22, 12.13, 18.66    |
| Discipline         | 1     | 7%   | BG 6.35                  |
| Detachment         | 1     | 7%   | BG 2.14                  |
| Karma Yoga         | 1     | 7%   | BG 4.18                  |
| Courage            | 2     | 13%  | BG 2.38, 16.1            |

**Goal for 700 verses**: ~70 verses per topic (balanced distribution)

---

## 🔄 Expansion Strategy

### When Adding New Verses:

1. **Identify the theme** of the verse
2. **Categorize into one of 10 topics**
3. **Balance distribution**:
   - Aim for ~70 verses per topic
   - Prioritize underrepresented topics first

### Example Workflow:

```json
{
  "id": "4.7",
  "chapter": 4,
  "verse": 7,
  "topic": "Purpose",  // ← Choose from 10 topics
  "devanagari": "यदा यदा हि धर्मस्य...",
  "transliteration": "yadā yadā hi dharmasya...",
  "meaning": "Whenever righteousness declines...",
  "explanation": "Krishna explains his avatars...",
  "audioFileName": null
}
```

---

## 🎯 Benefits of Curated Topics

### 1. **Variety**
Never get bored with the same chapter for weeks

### 2. **Relevance**
Get teachings that match your current needs
- Monday blues? Get Duty & Action
- Stressed? Get anxiety management verses

### 3. **Memorability**
Themes help you remember and apply verses

### 4. **Progression**
As weeks pass, you deepen understanding of each theme

### 5. **Completeness**
Eventually see all 700 verses across all themes

---

## 🧪 Testing the Rotation

### Change the Day:
```swift
// In DailyVerseService.swift
// Replace Date() with a specific date for testing

// Test Monday (Duty)
let testDate = Calendar.current.date(from: DateComponents(year: 2025, month: 1, day: 6))!

// Test Tuesday (Stress)
let testDate = Calendar.current.date(from: DateComponents(year: 2025, month: 1, day: 7))!
```

### Add Debug Logging:
```swift
print("Today is \(dayOfWeek), Topic: \(todayTopic.rawValue)")
print("Selected verse: \(todayVerse?.reference ?? "none")")
```

---

## 🚀 Future Enhancements

1. **Seasonal Themes**: Special verses for holidays (Diwali, etc.)
2. **User Preferences**: Let users choose favorite topics
3. **Difficulty Levels**: Beginner → Advanced verses
4. **Chapter Focus Mode**: Optionally go sequential through one chapter
5. **AI Suggestions**: Recommend verses based on user notes/mood

---

## 💡 Why Not Sequential?

**Sequential approach** (BG 1.1 → 18.78):
- ❌ Chapters 1-2 take months
- ❌ No variety or surprises
- ❌ May lose interest before reaching Chapter 18

**Curated approach**:
- ✅ Immediate variety
- ✅ Relevant to daily life
- ✅ All chapters represented early
- ✅ Can still browse sequentially in History view

---

## 🎓 Educational Philosophy

The Gita is meant to be **lived, not just read**. By presenting verses by theme:
1. Users can **apply** the teaching immediately
2. **Multiple perspectives** on one theme deepen understanding
3. **Repetition** across weeks reinforces key concepts
4. **Practical wisdom** is prioritized over academic order

---

**"The Gita is not a book to be read once, but a companion for life"**

This rotation ensures users return daily and build a lasting relationship with the text. 🙏
