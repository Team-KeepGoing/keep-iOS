//
//  SignupView.swift
//  Keep
//
//  Created by bibiga on 3/12/24.
//

import SwiftUI
import Alamofire

struct SignupData: Encodable {
    let email: String
    let password: String
    let name: String
}

struct SignupResponse: Codable {
    let success: Bool
    let message: String?
}

struct SignupView: View {
    @State private var email: String = ""
    @State private var name: String = ""
    @State private var password: String = ""
    @State private var repassword: String = ""
    @State private var teacher: Bool = false
    @State private var signupSuccess: Bool = false
    @State private var navigateToHome: Bool = false
    
    var body: some View {
        NavigationView {
            VStack {
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
                    TextField("", text: $email)
                        .frame(width: 290,height:20)
                    Rectangle()
                        .frame(width:290,height:1)
                    
                    Spacer()
                        .frame(height:20)
                    
                    Text("이름")
                        .bold()
                    TextField("", text: $name)
                        .frame(width: 290,height:20)
                    Rectangle()
                        .frame(width:290,height:1)
                    
                    Spacer()
                        .frame(height:20)
                    
                    Text("비밀번호")
                        .bold()
                    SecureField("", text: $password)
                        .frame(width: 290,height:20)
                    Rectangle()
                        .frame(width:290,height:1)
                    
                    Spacer()
                        .frame(height:20)
                    
                    Text("비밀번호 확인")
                        .bold()
                    SecureField("", text: $repassword)
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
                    sendDataToServer()
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
                .background(
                    NavigationLink(destination: TabbarView(), isActive: $navigateToHome) {
                        EmptyView()
                    }
                        .opacity(0)
                )
            }
            .navigationBarHidden(true)
        }
        .onChange(of: signupSuccess) { newValue in
            if newValue {
                navigateToHome = true
            }
        }
    }
    
    func sendDataToServer() {
        let signupData = SignupData(email: email, password: password, name: name)
        sendSignupRequest(signupData: signupData)
    }
    
    func sendSignupRequest(signupData: SignupData) {
        let url = "http://52.79.143.148:8080/user/signup"
        
        AF.request(url, method: .post, parameters: signupData, encoder: JSONParameterEncoder.default)
            .validate()
            .responseDecodable(of: SignupResponse.self) { response in
                switch response.result {
                case .success(let signupResponse):
                    if signupResponse.success {
                        print("회원가입 성공: \(signupResponse)")
                        self.signupSuccess = true
                    } else {
                        print("회원가입 실패: \(signupResponse.message ?? "Unknown error")")
                    }
                case .failure(let error):
                    print("회원가입 실패: \(error)")
                }
            }
    }
}

#Preview {
    SignupView()
}
