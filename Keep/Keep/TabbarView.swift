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
        }
    }
}

#Preview {
    TabbarView()
}
