//
//  LendDetailView.swift
//  Keep
//
//  Created by bibiga on 4/15/24.
//

import SwiftUI

struct LendDetailView: View {
    var body: some View {
        Text("기기 대여")
            .font(.system(size: 28, weight: .semibold))
            .offset(x:-100,y:-120)
        VStack(spacing:10) {
            Image("macbook")
                .resizable()
                .scaledToFit()
                .frame(width:200)
            Text("노트북")
                .font(.system(size: 27, weight: .semibold))
            Rectangle()
                .frame(width:60,height:20)
                .cornerRadius(9)
                .foregroundColor(.red)
                .overlay(
                    Text("사용 중")
                        .foregroundColor(.white)
                        .font(.system(size: 11, weight: .regular))
                )
            Text("2024/04/06 부터 대여가능")
                .font(.system(size: 16, weight: .regular))
        }
        .padding(.bottom,50)
    }
}

#Preview {
    LendDetailView()
}
