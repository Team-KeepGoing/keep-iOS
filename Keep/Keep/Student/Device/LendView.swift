//
//  LendView.swift
//  Keep
//
//  Created by bibiga on 4/8/24.
//

import SwiftUI

struct LendView: View {
    var body: some View {
        Text("기기 대여")
            .font(.system(size: 28, weight: .bold))
            .padding(.trailing,200)
        ScrollView {
            VStack(alignment: .leading, spacing:10) {
                HStack {
                    Image("macbook")
                        .resizable()
                        .frame(width:64,height: 64)
                    VStack(alignment:.leading, spacing:3) {
                        Text("노트북")
                            .font(.system(size: 20, weight: .bold))
                        Rectangle()
                            .frame(width:45,height:15)
                            .cornerRadius(7)
                            .foregroundColor(.red)
                            .overlay(
                                Text("사용 중")
                                    .foregroundColor(.white)
                                    .font(.system(size: 10, weight: .thin))
                            )
                    }
                }
                .padding(.trailing,100)
                HStack {
                    Image("macbook")
                        .resizable()
                        .frame(width:64,height: 64)
                    VStack(alignment:.leading, spacing:3) {
                        Text("노트북")
                            .font(.system(size: 20, weight: .bold))
                        Rectangle()
                            .frame(width:45,height:15)
                            .cornerRadius(7)
                            .foregroundColor(.red)
                            .overlay(
                                Text("사용 중")
                                    .foregroundColor(.white)
                                    .font(.system(size: 10, weight: .thin))
                            )
                    }
                }
                .padding(.trailing,100)

                HStack {
                    Image("macbook")
                        .resizable()
                        .frame(width:64,height: 64)
                    VStack(alignment:.leading, spacing:3) {
                        Text("노트북")
                            .font(.system(size: 20, weight: .bold))
                        Rectangle()
                            .frame(width:45,height:15)
                            .cornerRadius(7)
                            .foregroundColor(.red)
                            .overlay(
                                Text("사용 중")
                                    .foregroundColor(.white)
                                    .font(.system(size: 10, weight: .thin))
                            )
                    }
                }
                .padding(.trailing,100)

            }
            .padding(.trailing,100)
        }
        .frame(height:600)    }
}

#Preview {
    LendView()
}
