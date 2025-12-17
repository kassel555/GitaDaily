# 🕉️ Gita Daily - iOS App

**One Bhagavad Gita verse per day, organized by curated topics**

A beautiful iOS app that helps you learn the Bhagavad Gita through daily verses with Sanskrit text, audio pronunciation, and practical explanations.

## ✨ Features

- **📚 Curated Topic Rotation**: Verses organized by themes (Duty, Stress, Wisdom, Devotion, etc.)
- **🔊 Audio Pronunciation**: Text-to-speech with Hindi/Sanskrit voices
- **🐢 Speed & Repeat Controls**: Slow playback and 1-5x repeat options
- **🔔 Daily Notifications**: Never miss a day with customizable reminders
- **🔥 Streak Tracking**: Build consistency with daily streak counters
- **🔍 Browse & Search**: Explore all verses by topic or search
- **📖 Devanagari + Transliteration**: Sanskrit text with IAST pronunciation guide

## 🎯 Daily Topic Rotation

The app follows a weekly theme rotation:
- **Monday**: Duty & Action
- **Tuesday**: Stress & Anxiety
- **Wednesday**: Discipline
- **Thursday**: Wisdom
- **Friday**: Devotion
- **Saturday**: Karma Yoga
- **Sunday**: Courage

## 🛠️ Tech Stack

- **SwiftUI**: Modern declarative UI
- **SwiftData**: Persistent storage for user progress
- **AVFoundation**: Audio playback with TTS
- **UserNotifications**: Daily reminders

## 📁 Project Structure

```
GitaDaily/
├── GitaDailyApp.swift          # App entry point
├── Models/
│   ├── Verse.swift             # Verse and Topic models
│   └── UserProgress.swift      # SwiftData models for progress tracking
├── Services/
│   ├── DailyVerseService.swift # Curated verse selection logic
│   ├── AudioService.swift      # TTS audio playback
│   └── NotificationManager.swift # Daily notification scheduling
├── Views/
│   ├── ContentView.swift       # Main tab navigation
│   ├── TodayView.swift         # Today's verse with audio controls
│   ├── HistoryView.swift       # Browse all verses
│   └── SettingsView.swift      # App settings & preferences
└── Resources/
    └── verses.json             # 15 sample verses (expand to 700+)
```

## 🚀 Getting Started

### Prerequisites
- Xcode 15.0+
- iOS 17.0+ target
- macOS 13.0+ (for development)

### Setup Instructions

1. **Create a new Xcode project**:
   - Open Xcode
   - File → New → Project
   - Choose "iOS" → "App"
   - Product Name: `GitaDaily`
   - Interface: SwiftUI
   - Storage: SwiftData
   - Language: Swift

2. **Copy the files**:
   ```bash
   # Copy all Swift files from this directory into your Xcode project
   # Make sure to add verses.json to your project's Resources
   ```

3. **Configure Info.plist**:
   Add these keys (Right-click Info.plist → Open As → Source Code):
   ```xml
   <key>NSUserNotificationsUsageDescription</key>
   <string>We'll send you a daily reminder to learn today's verse</string>
   ```

4. **Build and Run**:
   - Select a target device/simulator
   - Press Cmd+R to build and run

## 📝 Expanding the Verse Database

The sample includes 15 verses. To expand to the full 700 verses:

1. Edit `verses.json` and add more verses following the format:
   ```json
   {
     "id": "chapter.verse",
     "chapter": 2,
     "verse": 47,
     "topic": "Duty & Action",
     "devanagari": "कर्मण्येवाधिकारस्ते...",
     "transliteration": "karmaṇy-evādhikāras te...",
     "meaning": "You have the right to perform your duty...",
     "explanation": "This famous verse teaches...",
     "audioFileName": null
   }
   ```

2. Organize verses by the 10 topics:
   - Duty & Action
   - Stress & Anxiety
   - Wisdom
   - Devotion
   - Discipline
   - Detachment
   - Karma Yoga
   - Knowledge
   - Courage
   - Purpose

## 🎙️ Audio Implementation

### Current: TTS with Device Voices
- Uses `AVSpeechSynthesizer`
- Automatically selects Hindi voice if available
- Falls back to Indian English
- Supports speed control and repeat

### Future: Pre-recorded Audio
To add human chanting:
1. Record/obtain audio files for each verse
2. Add files to project: `BG_2_47.mp3`, etc.
3. Update `audioFileName` in `verses.json`
4. Modify `AudioService.swift` to use `AVAudioPlayer` when audio file exists

## 🔔 Notifications

The app schedules:
- **Daily notification**: At user-selected time (default 8:00 AM)
- **Reminder notification**: 4 hours after first (optional)

Configure in Settings → Notifications.

## 📊 Streak Logic

Streaks work as follows:
- Open the app today → Maintain streak
- Skip a day → Streak resets to 1
- Longest streak is tracked separately

## 🎨 Customization Ideas

- **Themes**: Add dark/light mode customization
- **Languages**: Add translations (Hindi, Tamil, etc.)
- **Widgets**: iOS Home Screen widget with today's verse
- **Share**: Share verses as beautiful images
- **Bookmarks**: Favorite verse collection
- **Notes**: Add personal reflections to verses

## 📱 Minimum Requirements

- iOS 17.0+
- Xcode 15.0+
- SwiftUI & SwiftData support

## 🙏 Contributing

To contribute verses or translations:
1. Follow the JSON format
2. Ensure accurate Devanagari and transliteration
3. Keep meanings concise (1-2 lines)
4. Explanations should be practical and modern

## 📄 License

This is a starter template. Add your license as needed.

## 🌟 Credits

- Verse translations: Public domain sources
- App concept: Educational tool for Bhagavad Gita study
- Icon: System SF Symbols (replace with custom icon)

---

**Made with 🧡 for spiritual seekers everywhere**

*"You have the right to perform your duty, but never to the fruits of action" - Bhagavad Gita 2.47*
