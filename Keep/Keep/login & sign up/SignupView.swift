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
    let teacher: Bool
}

struct SignupResponse: Codable {
    let success: Bool
    let message: String?
    let data: SignupResponseData?

    struct SignupResponseData: Codable {
        let token: String?
        let teacher: Bool?
    }
}

struct SignupView: View {
    @State private var email: String = ""
    @State private var name: String = ""
    @State private var password: String = ""
    @State private var repassword: String = ""
    @State private var teacher: Bool = false
    @State private var signupSuccess: Bool = false
    @State private var showingAlert: Bool = false
    @State private var isTeacher: Bool = false
    
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
                        .frame(height: 40)
                    
                    HStack {
                        Text("이메일")
                            .bold()
                        Text("@dgsw.hs.kr 형식")
                            .foregroundColor(.gray)
                            .font(.system(size: 13, weight: .thin))
                    }
                    TextField("", text: $email)
                        .frame(width: 290, height: 20)
                    Rectangle()
                        .frame(width: 290, height: 1)
                    
                    Spacer()
                        .frame(height: 20)
                    
                    Text("이름")
                        .bold()
                    TextField("", text: $name)
                        .frame(width: 290, height: 20)
                    Rectangle()
                        .frame(width: 290, height: 1)
                    
                    Spacer()
                        .frame(height: 20)
                    
                    Text("비밀번호")
                        .bold()
                    SecureField("", text: $password)
                        .frame(width: 290, height: 20)
                    Rectangle()
                        .frame(width: 290, height: 1)
                    
                    Spacer()
                        .frame(height: 20)
                    
                    Text("비밀번호 확인")
                        .bold()
                    SecureField("", text: $repassword)
                        .frame(width: 290, height: 20)
                    Rectangle()
                        .frame(width: 290, height: 1)
                }
                HStack {
                    Spacer()
                        .frame(width: 130)
                    Text("교사인가요?")
                    Toggle(isOn: $teacher) {}
                        .frame(width: 50)
                }
                .padding()
                
                Spacer()
                    .frame(height: 30)
                
                Button {
                    if password == repassword {
                        sendDataToServer()
                    } else {
                        self.showingAlert.toggle()
                    }
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
                .alert(isPresented: $showingAlert) {
                    Alert(title: Text("비밀번호와 비밀번호 확인이 일치하지 않습니다."), message: nil, dismissButton: .default(Text("확인")))
                }
                
                NavigationLink(destination: destinationView(), isActive: $signupSuccess) {
                    EmptyView()
                }
                .hidden()
            }
        }
        .navigationBarBackButtonHidden(true)
    }
    
    func sendDataToServer() {
        let signupData = SignupData(email: email, password: password, name: name, teacher: teacher)
        sendSignupRequest(signupData: signupData)
    }
    
    func sendSignupRequest(signupData: SignupData) {
        AF.request(Storage().signupapiKey, method: .post, parameters: signupData, encoder: JSONParameterEncoder.default)
            .validate()
            .responseDecodable(of: SignupResponse.self) { response in
                switch response.result {
                case .success(let signupResponse):
                    if signupResponse.success {
                        print("회원가입 성공: \(signupResponse)")
                        if let data = signupResponse.data {
                            if let token = data.token {
                                TokenManager.shared.token = token
                                debugPrint("토큰 저장됨: \(token)")
                            }
                            if let isTeacher = data.teacher {
                                self.isTeacher = isTeacher
                            }
                        }
                        self.signupSuccess = true
                    } else {
                        print("회원가입 실패: \(signupResponse.message ?? "Unknown error")")
                    }
                case .failure(let error):
                    print("회원가입 실패: \(error)")
                }
            }
    }
    
    @ViewBuilder
    func destinationView() -> some View {
        if isTeacher {
            TeacherHomeView()
        } else {
            TabbarView()
        }
    }
}

#Preview {
    SignupView()
}
