//
//  TabbarView.swift
//  Keep
//
//  Created by bibiga on 4/4/24.
//

import SwiftUI

struct TabbarView: View {
    var body: some View {
        TabView {
            HomeView()
                .tabItem {
                    Image(systemName: "house")
                    Text("홈")
                }
            BooklistView()
                .tabItem {
                    Image(systemName: "book.closed.fill")
                    Text("도서")
                }
            QrView()
                .tabItem {
                    Image(systemName: "qrcode.viewfinder")
                    Text("QR")
                }
            LendView()
                .tabItem {
                    Image(systemName: "laptopcomputer")
                    Text("기기")
                }
            MypageView()
                .tabItem {
                    Image(systemName: "person")
                    Text("MY")
                }
            
        }
    }
}

#Preview {
    TabbarView()
}
