# 🚀 Quick Start Guide - Gita Daily

Get your app running in **5 minutes**!

## Step 1: Create Xcode Project (2 min)

1. Open **Xcode**
2. **File → New → Project**
3. Select **iOS → App**
4. Configure:
   - Product Name: `GitaDaily`
   - Interface: **SwiftUI**
   - Storage: **SwiftData**
   - Language: **Swift**
5. Click **Create**

## Step 2: Add Files to Project (2 min)

### Delete the default files:
- Right-click `ContentView.swift` → Delete → Move to Trash
- Right-click `GitaDailyApp.swift` → Delete → Move to Trash (if it exists)

### Add the new files:
1. **Drag and drop** all files from this package into your Xcode project
2. When prompted, check **"Copy items if needed"**
3. Organize by folders:
   ```
   GitaDaily/
   ├── GitaDailyApp.swift
   ├── Models/
   ├── Services/
   ├── Views/
   └── Resources/
   ```

### Add verses.json:
1. Right-click on your project
2. **Add Files to "GitaDaily"...**
3. Select `verses.json` from Resources folder
4. Check **"Copy items if needed"**
5. Ensure **"GitaDaily" target is checked**

## Step 3: Configure Permissions (1 min)

1. Select your project in the navigator
2. Select your **target**
3. Go to **Info** tab
4. Add this key:
   - **Key**: `Privacy - User Notifications Usage Description`
   - **Value**: `We'll send you a daily reminder to learn today's verse`

*Or copy the provided `Info.plist` content into your project's Info.plist*

## Step 4: Build & Run! ⚡

1. Select a simulator or device (iPhone 15 Pro recommended)
2. Press **Cmd + R** or click the ▶️ Play button
3. Allow notifications when prompted
4. Enjoy your first verse!

---

## 🎯 What You'll See

### Today Screen
- Current day's verse based on topic rotation
- Sanskrit/Devanagari text
- Transliteration for pronunciation
- Audio playback with speed/repeat controls
- English meaning + explanation
- "Mark as learned" button

### History Screen
- Browse all 15 sample verses
- Filter by topic
- Search by keyword
- View any verse in detail

### Settings Screen
- Current streak counter
- Notification time picker
- Audio preferences
- About the app

---

## 🐛 Troubleshooting

### "Cannot find 'DailyVerseService' in scope"
- Make sure all files are added to the **target**
- Check that files are in the correct folders
- Clean build folder: **Cmd + Shift + K**

### "verses.json not found"
- Right-click verses.json → **Show File Inspector**
- Ensure **Target Membership** includes "GitaDaily"
- Try removing and re-adding the file

### No audio playing
- Check device/simulator volume
- Go to Settings → Allow audio playback
- Restart the simulator

### Notifications not appearing
- Go to iOS Settings → GitaDaily → Notifications
- Enable "Allow Notifications"
- Check notification time in app Settings

---

## 📈 Next Steps

1. **Add more verses**: Expand `verses.json` with all 700 verses
2. **Customize topics**: Modify the topic rotation in `DailyVerseService.swift`
3. **Add audio files**: Record/obtain Sanskrit chanting and update `AudioService.swift`
4. **Design app icon**: Replace SF Symbols with custom icon
5. **Test notifications**: Wait until your set time or change time to 1 minute from now

---

## 💡 Pro Tips

- **Test notifications quickly**: Set notification time to 1 minute in the future
- **Reset streak**: Delete the app and reinstall to test streak logic
- **View logs**: Open Console app to see debug prints
- **Hot reload**: Press Cmd + Ctrl + P for quick preview updates

---

## 🎨 Customization Points

Want to personalize the app? Check these files:

- **Colors**: Update `TopicBadge` view with custom color schemes
- **Fonts**: Modify `.font()` modifiers throughout views
- **Topic rotation**: Change the weekly schedule in `DailyVerseService`
- **Audio speed**: Adjust `utterance.rate` multipliers in `AudioService`

---

## 📚 Resources

- [SwiftUI Documentation](https://developer.apple.com/documentation/swiftui)
- [AVFoundation Audio](https://developer.apple.com/documentation/avfoundation/audio)
- [UserNotifications Framework](https://developer.apple.com/documentation/usernotifications)
- [SwiftData Guide](https://developer.apple.com/documentation/swiftdata)

---

**Questions or issues?** Review the main `README.md` for detailed architecture info.

**Ready to ship?** See `README.md` for expansion ideas and best practices.

🙏 Happy coding and may the Gita's wisdom guide your journey!
