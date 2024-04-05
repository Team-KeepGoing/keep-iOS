//
//  ContentView.swift
//  Keep
//
//  Created by bibiga on 3/12/24.
//

import SwiftUI

struct ContentView: View {
    var body: some View {
        VStack {
            Image("Logo")
                .resizable()
                .scaledToFit()
                .frame(width:130)
            Text("대출/반납을 더욱 간편하게")
                .font(.system(size:16,weight:.thin))
        }
        .padding(30)
        VStack {
            Button(action: {
                
            }, label: {
                Rectangle()
                    .foregroundColor(.buttoncolor)
                    .frame(width: 310, height: 60)
                    .cornerRadius(20)
                    .overlay(
                        Text("로그인")
                            .foregroundColor(.black)
                            .font(.system(size: 30, weight: .bold, design: .default))
                    )
            })
            Button(action: {

            }, label: {
                Rectangle()
                    .foregroundColor(.buttoncolor)
                    .frame(width: 310, height: 60)
                    .cornerRadius(20)
                    .overlay(
                        Text("회원가입")
                            .foregroundColor(.black)
                            .font(.system(size: 30, weight: .bold, design: .default))
                    )
            })
            .padding()
        }
    }
}

#Preview {
    ContentView()
}
