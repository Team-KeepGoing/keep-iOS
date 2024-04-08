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
                                    .frame(width:160)
                                Button {
                                    
                                } label: {
                                    Image(systemName: "arrow.right")
                                        .resizable()
                                        .scaledToFit()
                                        .foregroundColor(.black)
                                        .frame(width:20)
                                }
                            }
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
