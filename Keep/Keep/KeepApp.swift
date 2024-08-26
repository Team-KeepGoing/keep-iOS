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
    
    let tokenManager = TokenManager.shared
    
    var body: some Scene {
        WindowGroup {
            ContentView()
                .environmentObject(TokenManager.shared)
        }
    }
}

func requestNotificationPermission() {
    UNUserNotificationCenter.current().requestAuthorization(options: [.alert, .badge, .sound]) { granted, error in
        if granted {
            print("알림 권한이 허용되었습니다.")
        } else {
            print("알림 권한이 거부되었습니다.")
        }
    }
}



//let headers: HTTPHeaders = ["Authorization": "Bearer \(TokenManager.shared.token ?? "")"]

//AF.request("YOUR_API_ENDPOINT", headers: headers)
//.responseJSON { response in
// 응답 처리 코드...
//}
