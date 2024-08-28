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
    let status: String
    
    // 상수 정의
    private let titleFontSize: CGFloat = 28
    private let deviceNameFontSize: CGFloat = 27
    private let statusFontSize: CGFloat = 19
    private let rectangleWidth: CGFloat = 230
    private let rectangleHeight: CGFloat = 45
    
    var body: some View {
        VStack(spacing: 10) {
            headerView
            
            deviceImageView
            
            Text(deviceName)
                .font(.system(size: deviceNameFontSize, weight: .semibold))
            
            Spacer()
                .frame(height: 120)
            
            statusView
        }
        .frame(height: 400)
        .padding()
    }
    
    // 헤더 뷰
    private var headerView: some View {
        Text("기기 대여")
            .font(.system(size: titleFontSize, weight: .semibold))
            .offset(x: -100, y: -90)
    }
    
    // 기기 이미지 뷰
    @ViewBuilder
    private var deviceImageView: some View {
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
    }
    
    // 상태 표시 뷰
    private var statusView: some View {
        Rectangle()
            .frame(width: rectangleWidth, height: rectangleHeight)
            .cornerRadius(12)
            .foregroundColor(statusColor)
            .overlay(
                Text(statusText)
                    .font(.system(size: statusFontSize, weight: .medium))
                    .foregroundColor(.white)
            )
    }
    
    // 상태에 따른 색상 반환
    private var statusColor: Color {
        switch status {
        case "RENTED":
            return .red
        case "UNAVAILABLE":
            return Color("unavcolor") // 사용자 정의 색상
        default:
            return .blue
        }
    }
    
    // 상태에 따른 텍스트 반환
    private var statusText: String {
        switch status {
        case "RENTED":
            return "사용 중"
        case "UNAVAILABLE":
            return "대여 불가"
        default:
            return "대여 가능"
        }
    }
}

#Preview {
    LendDetailView(deviceName: "노트북", imgUrl: nil, status: "RENTED")
}

