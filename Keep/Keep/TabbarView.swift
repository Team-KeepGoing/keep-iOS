//
//  TabbarView.swift
//  Keep
//
//  Created by bibiga on 4/4/24.
//

import SwiftUI

struct TabbarView: View {
    @EnvironmentObject var tokenManager: TokenManager
    var body: some View {
        TabView {
            HomeView()
                .tabItem {
                    Image(systemName: "house")
                    Text("홈")
                }
                .environmentObject(tokenManager)
            BooklistView()
                .tabItem {
                    Image(systemName: "book.closed.fill")
                    Text("도서")
                }
                .environmentObject(tokenManager)
            QrView()
                .tabItem {
                    Image(systemName: "qrcode.viewfinder")
                    Text("QR")
                }
                .environmentObject(tokenManager)
            LendView()
                .tabItem {
                    Image(systemName: "laptopcomputer")
                    Text("기기")
                }
                .environmentObject(tokenManager)
            MypageView()
                .tabItem {
                    Image(systemName: "person")
                    Text("MY")
                }
                .environmentObject(tokenManager)
        }
    }
}

#Preview {
    TabbarView()
}
