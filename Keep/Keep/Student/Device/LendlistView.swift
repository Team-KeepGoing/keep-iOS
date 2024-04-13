//
//  LendlistView.swift
//  Keep
//
//  Created by bibiga on 4/8/24.
//

import SwiftUI

struct LendlistView: View {
    var body: some View {
        VStack {
            Text("나의 대여 목록")
                .font(.system(size: 28, weight: .bold))
                .padding(.trailing,170)
            Rectangle()
                .frame(height:1)
                .foregroundColor(.gray)
            ScrollView {
                VStack(spacing:15) {
                    Rectangle()
                        .frame(width:340,height:60)
                        .foregroundColor(.buttoncolor)
                        .cornerRadius(15)
                        .overlay(
                            HStack(spacing: 120) {
                                Text("아이패드")
                                    .font(.system(size: 22, weight: .semibold))
                                Text("2024/04/13")
                            }
                        )
                    Rectangle()
                        .frame(width:340,height:60)
                        .foregroundColor(.buttoncolor)
                        .cornerRadius(15)
                        .overlay(
                            HStack(spacing: 120) {
                                Text("아이패드")
                                    .font(.system(size: 22, weight: .semibold))
                                Text("2024/04/13")
                            }
                        )
                    Rectangle()
                        .frame(width:340,height:60)
                        .foregroundColor(.buttoncolor)
                        .cornerRadius(15)
                        .overlay(
                            HStack(spacing: 120) {
                                Text("아이패드")
                                    .font(.system(size: 22, weight: .semibold))
                                Text("2024/04/13")
                            }
                        )
                }
            }
            .padding()
            .frame(height:600)
        }
    }
}

#Preview {
    LendlistView()
}
