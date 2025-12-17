import SwiftUI
import SwiftData

@main
struct GitaDailyApp: App {
    @StateObject private var verseService = DailyVerseService()
    @StateObject private var audioService = AudioService()
    @StateObject private var notificationManager = NotificationManager()
    @StateObject private var favoritesManager = FavoritesManager()

    var body: some Scene {
        WindowGroup {
            ContentView()
                .environmentObject(verseService)
                .environmentObject(audioService)
                .environmentObject(notificationManager)
                .environmentObject(favoritesManager)
                .onAppear {
                    notificationManager.requestAuthorization()
                    verseService.checkAndUpdateStreak()
                }
        }
        .modelContainer(for: [UserProgress.self, VerseHistory.self]) { result in
            switch result {
            case .success(let container):
                Task { @MainActor in
                    favoritesManager.configure(with: container.mainContext)
                }
            case .failure(let error):
                print("Failed to create model container: \(error)")
            }
        }
    }
}
