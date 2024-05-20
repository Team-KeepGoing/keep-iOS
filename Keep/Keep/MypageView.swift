//
//  MypageView.swift
//  Keep
//
//  Created by bibiga on 4/8/24.
//

import SwiftUI

struct MypageView: View {
    var body: some View {
        ZStack {
            Rectangle()
                .foregroundColor(.buttoncolor)
                .frame(height:800)
                .offset(y: -60)
            VStack {
                VStack(alignment: .leading) {
                    Text("마이페이지")
                        .font(.system(size: 28, weight: .semibold))
                    HStack {
                        Image(systemName: "person.circle.fill")
                            .resizable()
                            .scaledToFit()
                            .frame(width:112)
                        Spacer()
                            .frame(width:20)
                        VStack(alignment: .leading, spacing:10) {
                            Text("김주환")
                                .font(.system(size: 24, weight: .semibold))
                            Text("2학년 2반 8번")
                                .font(.system(size: 18, weight: .light))
                            Text("010-3852-4644")
                                .font(.system(size: 18, weight: .light))
                        }
                    }
                }
                .padding(.trailing,30)
                Spacer()
                    .frame(height: 30)
                VStack {
                    Text("회원님이 대출중인 책")
                        .font(.system(size: 15, weight: .semibold))
                        .padding(.trailing, 170)
                    ScrollView{
                        HStack {
                            Image("book1")
                                .resizable()
                                .scaledToFit()
                                .frame(width:100)
                                .padding(.bottom, 30)
                            Image("book1")
                                .resizable()
                                .scaledToFit()
                                .frame(width:100)
                                .padding(.bottom, 30)
                            Image("book1")
                                .resizable()
                                .scaledToFit()
                                .frame(width:100)
                                .padding(.bottom, 30)
                            Image("book1")
                                .resizable()
                                .scaledToFit()
                                .frame(width:100)
                                .padding(.bottom, 30)
                        }
                    }
                    .frame(height: 170)
                }
                Button {
                    
                } label: {
                    Text("나의 대출 목록 확인")
                        .font(.system(size: 13, weight: .medium))
                        .padding(.leading,220)
                }
                VStack {
                    Text("회원님이 대여중인 기자재")
                        .font(.system(size: 15, weight: .semibold))
                        .padding(.trailing, 150)
                    HStack{
                        ScrollView{
                            
                        }
                        .frame(height: 170)
                    }
                }
            }
        }
    }
}

#Preview {
    MypageView()
}
