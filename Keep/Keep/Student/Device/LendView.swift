//
//  LendView.swift
//  Keep
//
//  Created by bibiga on 4/8/24.
//

import SwiftUI

import SwiftUI

struct ELend: View {
    var image: String
    var title: String
    var lendStatus: String
    
    var body: some View {
        NavigationLink(destination: LendDetailView()) {
            HStack {
                Image(image)
                    .resizable()
                    .frame(width: 64, height: 64)
                VStack(alignment:.leading, spacing:3) {
                    Text(title)
                        .font(.system(size: 20, weight: .bold))
                        .foregroundColor(.black)
                    Rectangle()
                        .frame(width:45,height:15)
                        .cornerRadius(7)
                        .foregroundColor(.red)
                        .overlay(
                            Text(lendStatus)
                                .foregroundColor(.white)
                                .font(.system(size: 10, weight: .thin))
                        )
                }
            }
            .padding(.trailing,100)
        }
    }
}

struct LendView: View {
    @State private var lendUsing: String = "사용 중"
    var body: some View {
        NavigationView {
            VStack {
                Text("기기 대여")
                    .font(.system(size: 28, weight: .bold))
                    .padding(.trailing,200)
                ScrollView {
                    VStack(alignment: .leading, spacing:10) {
                        ELend(image: "macbook", title: "노트북", lendStatus: lendUsing)
                        ELend(image: "macbook", title: "노트북", lendStatus: lendUsing)
                    }
                    .padding(.trailing,100)
                }
                .frame(height:600)
            }
            .navigationBarTitle("")
            .navigationBarHidden(true)
        }
    }
}


#Preview {
    LendView()
}
