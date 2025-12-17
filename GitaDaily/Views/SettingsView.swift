import SwiftUI

struct SettingsView: View {
    @EnvironmentObject var notificationManager: NotificationManager
    @EnvironmentObject var verseService: DailyVerseService
    @EnvironmentObject var audioService: AudioService
    @State private var notificationTime = Date()
    @State private var showTransliterationDefault = true
    @State private var defaultSlowSpeed = false
    @State private var defaultRepeatCount = 1
    @State private var showAbout = false

    var body: some View {
        NavigationStack {
            List {
                progressSection
                notificationsSection
                audioPreferencesSection
                displaySection
                aboutSection
                versionSection
            }
            .navigationTitle("Settings")
            .sheet(isPresented: $showAbout) {
                AboutView()
            }
        }
    }

    // MARK: - Progress Section

    private var progressSection: some View {
        Section {
            HStack {
                Label("Current Streak", systemImage: "flame.fill")
                    .foregroundStyle(.orange)
                Spacer()
                Text("\(verseService.currentStreak) days")
                    .fontWeight(.semibold)
            }

            HStack {
                Label("Longest Streak", systemImage: "star.fill")
                    .foregroundStyle(.yellow)
                Spacer()
                Text("\(verseService.longestStreak) days")
                    .fontWeight(.semibold)
            }
        } header: {
            Text("Your Progress")
        }
    }

    // MARK: - Notifications Section

    private var notificationsSection: some View {
        Section {
            Toggle(isOn: $notificationManager.isAuthorized) {
                Label("Daily Reminders", systemImage: "bell.fill")
            }
            .onChange(of: notificationManager.isAuthorized) { _, newValue in
                if newValue {
                    notificationManager.requestAuthorization()
                } else {
                    notificationManager.cancelAllNotifications()
                }
            }

            if notificationManager.isAuthorized {
                DatePicker(
                    "Notification Time",
                    selection: $notificationTime,
                    displayedComponents: .hourAndMinute
                )
                .onChange(of: notificationTime) { _, newValue in
                    notificationManager.updateNotificationTime(newTime: newValue)
                }
            }
        } header: {
            Text("Notifications")
        } footer: {
            Text("Receive a daily reminder to learn today's verse")
        }
    }

    // MARK: - Audio Preferences Section

    private var audioPreferencesSection: some View {
        Section {
            Picker("Pronunciation Mode", selection: $audioService.pronunciationMode) {
                ForEach(PronunciationMode.allCases, id: \.self) { mode in
                    Text(mode.rawValue).tag(mode)
                }
            }

            Picker("Default Repeat Count", selection: $defaultRepeatCount) {
                ForEach(1...5, id: \.self) { count in
                    Text("\(count)x").tag(count)
                }
            }

            Toggle(isOn: $defaultSlowSpeed) {
                Label("Slow Speed by Default", systemImage: "tortoise.fill")
            }
        } header: {
            Text("Audio Preferences")
        } footer: {
            Text("Transliteration mode often sounds clearer than Devanagari with TTS")
        }
    }

    // MARK: - Display Section

    private var displaySection: some View {
        Section {
            Toggle(isOn: $showTransliterationDefault) {
                Label("Show Transliteration", systemImage: "textformat")
            }
        } header: {
            Text("Display")
        } footer: {
            Text("Show IAST transliteration for pronunciation help")
        }
    }

    // MARK: - About Section

    private var aboutSection: some View {
        Section {
            Button(action: { showAbout.toggle() }) {
                HStack {
                    Label("About Gita Daily", systemImage: "info.circle")
                    Spacer()
                    Image(systemName: "chevron.right")
                        .font(.caption)
                        .foregroundStyle(.secondary)
                }
            }
            .foregroundStyle(.primary)

            Link(destination: URL(string: "https://www.holy-bhagavad-gita.org")!) {
                HStack {
                    Label("Learn More About Bhagavad Gita", systemImage: "book.circle")
                    Spacer()
                    Image(systemName: "arrow.up.right")
                        .font(.caption)
                        .foregroundStyle(.secondary)
                }
            }
        } header: {
            Text("About")
        }
    }

    // MARK: - Version Section

    private var versionSection: some View {
        Section {
            HStack {
                Text("Version")
                    .foregroundStyle(.secondary)
                Spacer()
                Text("1.0.0")
                    .foregroundStyle(.secondary)
            }
        }
    }
}

#Preview {
    SettingsView()
        .environmentObject(NotificationManager())
        .environmentObject(DailyVerseService())
        .environmentObject(AudioService())
}
