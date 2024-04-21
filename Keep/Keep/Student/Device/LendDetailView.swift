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
            .offset(x:-100,y:-90)
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
            Spacer()
                .frame(height:120)
            Button {
                
            } label: {
                Rectangle()
                    .frame(width:230,height: 45)
                    .cornerRadius(12)
                    .foregroundColor(.lendbutton)
                    .overlay(
                        Text("대여하기")
                            .font(.system(size: 19, weight: .medium))
                            .foregroundColor(.white)
                    )
            }
        }
    }
}

#Preview {
    LendDetailView()
}
