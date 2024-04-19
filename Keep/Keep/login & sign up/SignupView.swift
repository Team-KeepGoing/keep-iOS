//
//  SignupView.swift
//  Keep
//
//  Created by bibiga on 3/12/24.
//

import SwiftUI
import Alamofire

struct SignupView: View {
    @State private var email: String = ""
    @State private var password: String = ""
    @State private var repassword: String = ""
    @State private var name: String = ""
    @State private var teacher: Bool = false
    
    var body: some View {
        VStack(alignment: .leading) {
            VStack(alignment: .leading) {
                Text("입력을 완료 하셨으면")
                    .font(.system(size: 22,weight: .bold))
                    .bold()
                Text("아래 확인 버튼을 눌러주세요.")
                    .font(.system(size: 22,weight: .bold))
                    .bold()
            }
            
            Spacer()
                .frame(height:40)
            
            HStack {
                Text("이메일")
                    .font(.system(size: 17,weight: .bold))
                Text("@dgsw.hs.kr 형식")
                    .foregroundColor(.gray)
                    .font(.system(size: 13, weight: .regular))
            }
            TextField("", text: $email)
                .frame(width: 290,height:20)
            Rectangle()
                .frame(width:290,height:1)
            
            Spacer()
                .frame(height:20)
            
            Text("이름")
                .font(.system(size: 17,weight: .bold))
            TextField("", text: $name)
                .frame(width: 290,height:20)
            Rectangle()
                .frame(width:290,height:1)
            
            Spacer()
                .frame(height:20)
            
            Text("비밀번호")
                .font(.system(size: 17,weight: .bold))
            SecureField("", text: $password)
                .frame(width: 290,height:20)
            Rectangle()
                .frame(width:290,height:1)
            
            Spacer()
                .frame(height:20)
            
            Text("비밀번호 확인")
                .font(.system(size: 17,weight: .bold))
            SecureField("", text: $repassword)
                .frame(width: 290,height:20)
            Rectangle()
                .frame(width:290,height:1)
        }
        HStack() {
            Spacer()
                .frame(width: 130)
            Text("교사인가요?")
                .font(.system(size: 18,weight: .light))
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
