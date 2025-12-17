# ✅ GitaDaily Setup Checklist

Use this checklist to set up your project step-by-step!

---

## 📋 Pre-Setup

- [ ] Install Xcode 15.0 or later
- [ ] Verify macOS 13.0+ (Ventura)
- [ ] Have an iOS 17+ device/simulator
- [ ] Read **QUICKSTART.md** (2 minutes)

---

## 🎯 Step 1: Create Xcode Project (2 min)

- [ ] Open Xcode
- [ ] File → New → Project
- [ ] Select **iOS → App**
- [ ] Configure project:
  - [ ] Product Name: **GitaDaily**
  - [ ] Interface: **SwiftUI**
  - [ ] Storage: **SwiftData**
  - [ ] Language: **Swift**
- [ ] Click **Create**
- [ ] Choose save location

---

## 📁 Step 2: Add Project Files (3 min)

### Delete Default Files
- [ ] Delete `ContentView.swift`
- [ ] Delete default `GitaDailyApp.swift` (if exists)

### Add Main App File
- [ ] Add `GitaDailyApp.swift` to root

### Add Models Folder
- [ ] Create **Models** group in Xcode
- [ ] Add `Verse.swift`
- [ ] Add `UserProgress.swift`

### Add Services Folder
- [ ] Create **Services** group in Xcode
- [ ] Add `DailyVerseService.swift`
- [ ] Add `AudioService.swift`
- [ ] Add `NotificationManager.swift`

### Add Views Folder
- [ ] Create **Views** group in Xcode
- [ ] Add `ContentView.swift`
- [ ] Add `TodayView.swift`
- [ ] Add `HistoryView.swift`
- [ ] Add `SettingsView.swift`

### Add Resources
- [ ] Create **Resources** group in Xcode
- [ ] Add `verses.json`
- [ ] Verify **Target Membership** is checked

---

## ⚙️ Step 3: Configure Permissions (1 min)

- [ ] Select project in navigator
- [ ] Select **GitaDaily** target
- [ ] Go to **Info** tab
- [ ] Add custom key:
  - [ ] Key: `Privacy - User Notifications Usage Description`
  - [ ] Value: `We'll send you a daily reminder to learn today's verse`

*OR*

- [ ] Replace `Info.plist` with provided template

---

## 🔨 Step 4: Build & Test (2 min)

### First Build
- [ ] Select target device (iPhone 15 Pro recommended)
- [ ] Press **Cmd + B** to build
- [ ] Fix any errors (check file paths, target membership)
- [ ] Press **Cmd + R** to run

### Test Core Features
- [ ] App launches successfully
- [ ] Today's verse displays
- [ ] Devanagari text shows correctly
- [ ] Play button works (TTS speaks)
- [ ] Slow speed toggle works
- [ ] Repeat count changes
- [ ] History tab opens
- [ ] Settings tab opens

### Test Notifications
- [ ] Allow notifications when prompted
- [ ] Go to Settings → set notification to 1 min from now
- [ ] Close app
- [ ] Wait for notification
- [ ] Tap notification → app opens

### Test Streak
- [ ] Check "Day 1" shows on Today screen
- [ ] Close and reopen app → should still show Day 1
- [ ] (Optional) Change device date to tomorrow → should show Day 2

---

## 🎨 Step 5: Customize (Optional)

- [ ] Change accent color (in Assets)
- [ ] Add custom app icon
- [ ] Modify topic colors in `Verse.swift`
- [ ] Adjust notification time default
- [ ] Add more verses to `verses.json`

---

## 📚 Step 6: Read Documentation

- [ ] Read **README.md** for full overview
- [ ] Read **FILE_STRUCTURE.md** to understand architecture
- [ ] Read **TOPIC_ROTATION.md** to understand verse selection
- [ ] Read **PROJECT_SUMMARY.md** for quick reference

---

## 🚀 Step 7: Expand & Deploy

### Expand Verses
- [ ] Plan verse distribution (aim for ~70 per topic)
- [ ] Add verses from Chapter 1
- [ ] Add verses from Chapter 2
- [ ] ... continue to Chapter 18
- [ ] Test with new verses

### Polish App
- [ ] Create custom app icon (1024x1024)
- [ ] Add screenshots for App Store
- [ ] Write app description
- [ ] Test on real devices
- [ ] Get user feedback

### Prepare for Release
- [ ] Update version number
- [ ] Add privacy policy (if needed)
- [ ] Test all features thoroughly
- [ ] Create App Store listing
- [ ] Submit for review

---

## ⚠️ Troubleshooting Checklist

### Build Errors
- [ ] All files have correct target membership?
- [ ] SwiftData schema matches models?
- [ ] verses.json is in proper format?
- [ ] All imports are correct?

### Runtime Issues
- [ ] verses.json loads successfully?
  - [ ] Check: print statement in `loadVerses()`
- [ ] Audio not playing?
  - [ ] Check device volume
  - [ ] Check audio session configuration
  - [ ] Try different voices
- [ ] Notifications not appearing?
  - [ ] Check permission granted
  - [ ] Check notification time is in future
  - [ ] Check Settings → Notifications → GitaDaily

### Data Issues
- [ ] Streak not updating?
  - [ ] Check date comparison logic
  - [ ] Verify SwiftData container
- [ ] Verses not showing?
  - [ ] Verify JSON syntax
  - [ ] Check filter logic

---

## 🎓 Learning Checklist

- [ ] Understand SwiftUI view hierarchy
- [ ] Understand @StateObject vs @ObservedObject
- [ ] Understand SwiftData @Model macro
- [ ] Understand AVSpeechSynthesizer basics
- [ ] Understand local notifications
- [ ] Understand date calculations
- [ ] Understand JSON decoding

---

## ✨ Feature Testing Matrix

| Feature                    | iOS Simulator | iPad | Real iPhone | Status |
|----------------------------|---------------|------|-------------|--------|
| Today screen loads         | [ ]           | [ ]  | [ ]         |        |
| Audio playback             | [ ]           | [ ]  | [ ]         |        |
| Slow speed                 | [ ]           | [ ]  | [ ]         |        |
| Repeat 1-5x                | [ ]           | [ ]  | [ ]         |        |
| History browse             | [ ]           | [ ]  | [ ]         |        |
| Topic filter               | [ ]           | [ ]  | [ ]         |        |
| Search verses              | [ ]           | [ ]  | [ ]         |        |
| Settings - Notifications   | [ ]           | [ ]  | [ ]         |        |
| Settings - Audio prefs     | [ ]           | [ ]  | [ ]         |        |
| Mark as learned            | [ ]           | [ ]  | [ ]         |        |
| Streak tracking            | [ ]           | [ ]  | [ ]         |        |
| Daily notification         | -             | -    | [ ]         |        |
| Landscape orientation      | [ ]           | [ ]  | [ ]         |        |

---

## 🎯 Success Criteria

Your setup is complete when:

✅ App builds without errors  
✅ All 3 tabs work correctly  
✅ Audio plays with all controls functioning  
✅ Daily verse changes by topic (test by changing date)  
✅ Notifications schedule successfully  
✅ Streak counter increments  
✅ Search and filter work in History  
✅ Settings save and apply  

---

## 📞 Need Help?

1. **Build errors?** → Check FILE_STRUCTURE.md for correct file organization
2. **Feature not working?** → Read relevant section in README.md
3. **Don't understand something?** → Read PROJECT_SUMMARY.md for overview
4. **Want to modify?** → Read TOPIC_ROTATION.md for algorithm details

---

## 🎉 You're Done When...

- ✅ All checkboxes above are checked
- ✅ App runs without errors
- ✅ All features work as expected
- ✅ You understand the code structure
- ✅ You're ready to customize and expand

**Congratulations!** You now have a fully functional Bhagavad Gita learning app! 🕉️

---

**Next Steps**: Start adding verses to `verses.json` and customize to your liking!

**Share your progress**: Take a screenshot of the app and tag #GitaDaily 📱✨
