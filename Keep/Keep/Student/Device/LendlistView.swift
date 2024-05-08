//
//  LendlistView.swift
//  Keep
//
//  Created by bibiga on 4/8/24.
//

import SwiftUI

struct LendItemView: View {
    var lendName: String
    var lendDate: String
    
    var body: some View {
        Rectangle()
            .frame(width: 340, height: 60)
            .foregroundColor(.buttoncolor)
            .cornerRadius(15)
            .overlay(
                HStack(spacing: 120) {
                    Text(lendName)
                        .font(.system(size: 22, weight: .semibold))
                    Text(lendDate)
                }
            )
    }
}

struct LendlistView: View {
    @State private var lendItems = [
        ("아이패드", "2024/04/13"),
    ]
    
    var body: some View {
        VStack {
            Text("나의 대여 목록")
                .font(.system(size: 28, weight: .bold))
                .padding(.trailing, 170)
            
            Rectangle()
                .frame(height: 1)
                .foregroundColor(.gray)
            
            ScrollView {
                VStack(spacing: 15) {
                    ForEach(lendItems, id: \.self.0) { item in
                        LendItemView(lendName: item.0, lendDate: item.1)
                    }
                }
            }
            .padding()
            .frame(height: 600)
        }
    }
}

#Preview {
    LendlistView()
}
