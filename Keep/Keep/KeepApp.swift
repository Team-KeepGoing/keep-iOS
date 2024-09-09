//
//  KeepApp.swift
//  Keep
//
//  Created by bibiga on 3/12/24.
//

import SwiftUI
import UserNotifications

@main
struct KeepApp: App {
    @UIApplicationDelegateAdaptor(AppDelegate.self) var appDelegate
    let tokenManager = TokenManager.shared
    
    var body: some Scene {
        WindowGroup {
            ContentView()
                .environmentObject(TokenManager.shared)
                .onAppear {
                    UNUserNotificationCenter.current().delegate = appDelegate
                }
        }
    }
}

class AppDelegate: NSObject, UIApplicationDelegate, UNUserNotificationCenterDelegate {
    
    func application(_ application: UIApplication, didFinishLaunchingWithOptions launchOptions: [UIApplication.LaunchOptionsKey: Any]?) -> Bool {
        UNUserNotificationCenter.current().delegate = self
        return true
    }
    
    func userNotificationCenter(_ center: UNUserNotificationCenter, willPresent notification: UNNotification, withCompletionHandler completionHandler: @escaping (UNNotificationPresentationOptions) -> Void) {
        completionHandler([.banner, .sound])
    }
    
    func userNotificationCenter(_ center: UNUserNotificationCenter, didReceive response: UNNotificationResponse, withCompletionHandler completionHandler: @escaping () -> Void) {
        // 알림 클릭 시 처리 로직
        completionHandler()
    }
}



//let headers: HTTPHeaders = ["Authorization": "Bearer \(TokenManager.shared.token ?? "")"]

//AF.request("YOUR_API_ENDPOINT", headers: headers)
//.responseJSON { response in
// 응답 처리 코드...
//}
