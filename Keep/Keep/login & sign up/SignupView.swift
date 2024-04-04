//
//  SignupView.swift
//  Keep
//
//  Created by bibiga on 3/12/24.
//

import SwiftUI

struct SignupView: View {
    @State private var NewID: String = ""
    @State private var NewName: String = ""
    @State private var NewPassword: String = ""
    @State private var NewrePassword: String = ""
    @State private var teacher: Bool = false
    
    var body: some View {
        VStack(alignment: .leading) {
            VStack(alignment: .leading) {
                Text("입력을 완료 하셨으면")
                    .font(.system(size: 20))
                    .bold()
                Text("아래 확인 버튼을 눌러주세요.")
                    .font(.system(size: 20))
                    .bold()
            }
            
            Spacer()
                .frame(height:40)
            
            HStack {
                Text("이메일")
                    .bold()
                Text("@dgsw.hs.kr 형식")
                    .foregroundColor(.gray)
                    .font(.system(size: 13, weight: .thin))
            }
            TextField("", text: $NewID)
                .frame(width: 290,height:20)
            Rectangle()
                .frame(width:290,height:1)
            
            Spacer()
                .frame(height:20)
            
            Text("이름")
                .bold()
            TextField("", text: $NewName)
                .frame(width: 290,height:20)
            Rectangle()
                .frame(width:290,height:1)
            
            Spacer()
                .frame(height:20)
            
            Text("비밀번호")
                .bold()
            SecureField("", text: $NewPassword)
                .frame(width: 290,height:20)
            Rectangle()
                .frame(width:290,height:1)
            
            Spacer()
                .frame(height:20)
            
            Text("비밀번호 확인")
                .bold()
            SecureField("", text: $NewrePassword)
                .frame(width: 290,height:20)
            Rectangle()
                .frame(width:290,height:1)
        }
        HStack() {
            Spacer()
                .frame(width: 130)
            Text("교사인가요?")
            Toggle(isOn: $teacher) {}
                .frame(width:50)
        }
        
        .padding()
        Spacer()
            .frame(height: 30)
        
        Button {
            
        } label: {
            Rectangle()
                .frame(width: 110, height: 41)
                .cornerRadius(15)
                .foregroundColor(.selbutton)
                .overlay {
                    Text("완료")
                        .font(.system(size: 18))
                        .foregroundColor(.white)
                        .bold()
                }
        }
    }
}

#Preview {
    SignupView()
}
