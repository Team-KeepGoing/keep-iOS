//
//  LoginView.swift
//  Keep
//
//  Created by bibiga on 3/12/24.
//

import SwiftUI

struct LoginView: View {
    @State private var ID: String = ""
    @State private var Password: String = ""
    
    var body: some View {
        Image("Logo_2")
            .padding(30)
        VStack(alignment: .leading ,spacing: 20) {
            Text("아이디")
                .font(.system(size: 18, weight: .bold, design: .default))
            TextField("아이디를 입력해주세요.", text: $ID)
                .textFieldStyle(.roundedBorder)
                .frame(width: 320, height: 20)
            Text("비밀번호")
                .font(.system(size: 18, weight: .bold, design: .default))
            TextField("비밀번호를 입력해주세요.", text: $Password)
                .textFieldStyle(.roundedBorder)
                .frame(width: 320, height: 20)
        }
        
        HStack {
            Button {
                print(".")
            } label: {
                Text("비밀번호 찾기")
                    .foregroundColor(.black)
            }
            Text("|")
            Button {
                print(".")
            } label: {
                Text("회원가입")
                    .foregroundColor(.black)
            }
        }
        .padding()
        .padding(.leading, 150)
        
        Button {
            print("..")
        } label: {
            ZStack {
                RoundedRectangle(cornerRadius: 13)
                    .frame(width:100,height: 40)
                    .foregroundColor(.keepcolor)
                Text("로그인")
                    .foregroundColor(.white)
                    .font(.system(size: 20, weight: .bold, design: .default))
            }
        }
        .padding()
    }
}

#Preview {
    LoginView()
}
