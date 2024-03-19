//
//  SignupView.swift
//  Keep
//
//  Created by bibiga on 3/12/24.
//

import SwiftUI

struct SignupView: View {
    @State private var NewID: String = ""
    @State private var NewPassword: String = ""
    
    var body: some View {
        Image("Logo_2")
            .padding(30)
        VStack(alignment: .leading ,spacing: 20) {
            Text("아이디")
                .font(.system(size: 18, weight: .bold, design: .default))
            TextField("아이디를 입력해주세요.", text: $NewID)
                .textFieldStyle(.roundedBorder)
                .frame(width: 320, height: 20)
            Text("비밀번호")
                .font(.system(size: 18, weight: .bold, design: .default))
            SecureField("비밀번호를 입력해주세요.", text: $NewPassword)
                .textFieldStyle(.roundedBorder)
                .frame(width: 320, height: 20)
            Text("비밀번호 확인")
                .font(.system(size: 18, weight: .bold, design: .default))
            SecureField("비밀번호를 다시 입력해주세요.", text: $NewPassword)
                .textFieldStyle(.roundedBorder)
                .frame(width: 320, height: 20)
        }
        
        Button {
            print("..")
        } label: {
            ZStack {
                RoundedRectangle(cornerRadius: 13)
                    .frame(width:140,height: 40)
                    .foregroundColor(.keepcolor)
                Text("회원가입 완료")
                    .foregroundColor(.white)
                    .font(.system(size: 20, weight: .bold, design: .default))
            }
        }
        .padding(40)
    }
}

#Preview {
    SignupView()
}
