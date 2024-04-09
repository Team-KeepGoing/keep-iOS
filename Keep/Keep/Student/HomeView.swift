//
//  HomeView.swift
//  Keep
//
//  Created by bibiga on 4/4/24.
//

import SwiftUI

struct HomeView: View {
    var body: some View {
        ZStack {
            Rectangle()
                .foregroundColor(.buttoncolor)
                .frame(height:800)
                .offset(y: -60)
            Image("Character")
                .resizable()
                .scaledToFit()
                .frame(width: 44)
                .offset(x:-150,y:-350)
            ScrollView {
                Rectangle()
                    .frame(width:350,height:200)
                    .foregroundColor(.white)
                    .cornerRadius(15)
                    .padding()
                    .overlay(
                        VStack {
                            HStack {
                                Image(systemName: "qrcode")
                                    .resizable()
                                    .scaledToFit()
                                    .frame(width:23)
                                    .padding(5)
                                Text("도서 대출")
                                    .font(.system(size: 23, weight: .bold))
                                Spacer()
                                    .frame(width:150)
                                Button {
                                    
                                } label: {
                                    Image(systemName: "arrow.right")
                                        .resizable()
                                        .scaledToFit()
                                        .foregroundColor(.black)
                                        .frame(width:20)
                                }
                            }
                            Button {
                                
                            } label: {
                                Rectangle()
                                    .foregroundColor(.buttoncolor)
                                    .frame(width:125,height:35)
                                    .cornerRadius(10)
                                    .overlay(
                                        Text("나의 대출 목록")
                                            .foregroundColor(.black)
                                            .font(.system(size: 17, weight: .semibold))
                                    )
                            }
                            .padding(.leading,180)
                            VStack(alignment: .leading) {
                                Text("회원님이 대출중인 책")
                                Text("미래의 사랑 이야기")
                                    .font(.system(size: 15, weight: .thin))
                                Text("화를 극복해내는 방법")
                                    .font(.system(size: 15, weight: .thin))
                            }
                            .offset(x:-80,y:10)
                        }
                    )
                Rectangle()
                    .frame(width:350,height:420)
                    .foregroundColor(.white)
                    .cornerRadius(15)
            }
            .padding(80)
        }
    }
}

#Preview {
    HomeView()
}
