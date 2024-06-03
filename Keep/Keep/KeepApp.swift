//
//  KeepApp.swift
//  Keep
//
//  Created by bibiga on 3/12/24.
//

import SwiftUI

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


//let headers: HTTPHeaders = ["Authorization": "Bearer \(TokenManager.shared.token ?? "")"]

//AF.request("YOUR_API_ENDPOINT", headers: headers)
//.responseJSON { response in
// 응답 처리 코드...
//}
