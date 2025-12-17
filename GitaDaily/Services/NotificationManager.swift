import Foundation
import UserNotifications
import Combine

class NotificationManager: NSObject, ObservableObject {
    @Published var isAuthorized: Bool = false
    @Published var notificationTime: Date = Calendar.current.date(bySettingHour: 8, minute: 0, second: 0, of: Date()) ?? Date()
    
    override init() {
        super.init()
        checkAuthorizationStatus()
    }
    
    func requestAuthorization() {
        UNUserNotificationCenter.current().requestAuthorization(options: [.alert, .sound, .badge]) { granted, error in
            DispatchQueue.main.async {
                self.isAuthorized = granted
                if granted {
                    self.scheduleDailyNotification()
                }
            }
        }
    }
    
    private func checkAuthorizationStatus() {
        UNUserNotificationCenter.current().getNotificationSettings { settings in
            DispatchQueue.main.async {
                self.isAuthorized = settings.authorizationStatus == .authorized
            }
        }
    }
    
    func scheduleDailyNotification() {
        // Remove existing notifications
        UNUserNotificationCenter.current().removePendingNotificationRequests(withIdentifiers: ["dailyVerse"])
        
        let content = UNMutableNotificationContent()
        content.title = "🕉️ Today's Gita Verse is Ready"
        content.body = "Your daily wisdom awaits. Open the app to learn today's verse."
        content.sound = .default
        content.badge = 1
        
        // Schedule for the chosen time
        let calendar = Calendar.current
        let dateComponents = calendar.dateComponents([.hour, .minute], from: notificationTime)
        
        let trigger = UNCalendarNotificationTrigger(dateMatching: dateComponents, repeats: true)
        let request = UNNotificationRequest(identifier: "dailyVerse", content: content, trigger: trigger)
        
        UNUserNotificationCenter.current().add(request) { error in
            if let error = error {
                print("Failed to schedule notification: \(error)")
            }
        }
    }
    
    func scheduleReminderNotification(hoursAfter: Int = 4) {
        let content = UNMutableNotificationContent()
        content.title = "Gentle Reminder"
        content.body = "Don't forget today's verse—keep your streak going! 🔥"
        content.sound = .default
        
        let trigger = UNTimeIntervalNotificationTrigger(timeInterval: TimeInterval(hoursAfter * 3600), repeats: false)
        let request = UNNotificationRequest(identifier: "reminderVerse", content: content, trigger: trigger)
        
        UNUserNotificationCenter.current().add(request) { error in
            if let error = error {
                print("Failed to schedule reminder: \(error)")
            }
        }
    }
    
    func updateNotificationTime(newTime: Date) {
        self.notificationTime = newTime
        if isAuthorized {
            scheduleDailyNotification()
        }
    }
    
    func cancelAllNotifications() {
        UNUserNotificationCenter.current().removeAllPendingNotificationRequests()
    }
}
