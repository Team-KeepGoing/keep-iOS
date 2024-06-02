//
//  LendDetailView.swift
//  Keep
//
//  Created by bibiga on 4/15/24.
//

import SwiftUI
import SDWebImageSwiftUI

struct LendDetailView: View {
    let deviceName: String
    let imgUrl: String?
    let status: Int

    var body: some View {
        VStack {
            Text("기기 대여")
                .font(.system(size: 28, weight: .semibold))
                .offset(x: -100, y: -90)
            VStack(spacing: 10) {
                if let imgUrl = imgUrl, let url = URL(string: imgUrl) {
                    WebImage(url: url)
                        .resizable()
                        .scaledToFit()
                        .frame(width: 200)
                } else {
                    Image("placeholder")
                        .resizable()
                        .scaledToFit()
                        .frame(width: 200)
                }
                Text(deviceName)
                    .font(.system(size: 27, weight: .semibold))
                Rectangle()
                    .frame(width: 60, height: 20)
                    .cornerRadius(9)
                    .foregroundColor(status == 2 ? .red : .blue)
                    .overlay(
                        Text(status == 2 ? "사용 중" : "대여 가능")
                            .foregroundColor(.white)
                            .font(.system(size: 11, weight: .regular))
                    )

                Spacer()
                    .frame(height: 120)

                Rectangle()
                    .frame(width: 230, height: 45)
                    .cornerRadius(12)
                    .foregroundColor(status == 2 ? .red : .blue)
                    .overlay(
                        Text(status == 2 ? "사용 중" : "미사용")
                            .font(.system(size: 19, weight: .medium))
                            .foregroundColor(.white)
                    )
            }
            .padding()
        }
    }
}

#Preview {
    LendDetailView(deviceName: "노트북", imgUrl: nil, status: 1)
}
