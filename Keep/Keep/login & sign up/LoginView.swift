//
//  LoginView.swift
//  Keep
//
//  Created by bibiga on 3/12/24.
//

import SwiftUI
import Alamofire

struct LoginView: View {
    @State private var email: String = ""
    @State private var password: String = ""
    @State private var isLoggedIn: Bool = false
    @State private var isTeacher: Bool = false
    @Environment(\.presentationMode) var presentationMode
    
    var body: some View {
        NavigationView {
            VStack {
                ZStack {
                    Image("loginsign")
                        .resizable()
                        .scaledToFit()
                        .frame(width:316,height:208)
                    VStack {
                        Button(action: {
                            presentationMode.wrappedValue.dismiss()
                        }) {
                            HStack {
                                Image(systemName: "chevron.backward")
                                    .resizable()
                                    .scaledToFit()
                                    .frame(width:13)
                                    .foregroundColor(.white)
                                    .padding(3)
                                Text("뒤로가기")
                                    .font(.system(size: 18, weight: .medium))
                                    .foregroundColor(.white)
                            }
                        }
                        Text("로그인")
                            .font(.system(size: 28, weight: .bold))
                            .foregroundColor(.white)
                    }
                    .offset(x:-50,y:10)
                }
                .offset(x:-70,y:-150)
                .frame(height:70)
                
                Image("Logo")
                    .resizable()
                    .scaledToFit()
                    .frame(width: 120)
                VStack(alignment: .leading) {
                    Text("이메일")
                        .font(.system(size: 17, weight: .bold))
                    TextField("", text: $email)
                        .padding()
                        .background(
                            RoundedRectangle(cornerRadius: 10)
                                .foregroundColor(.buttoncolor)
                                .frame(width: 300, height: 45)
                        )
                    Spacer()
                        .frame(height: 20)
                    Text("비밀번호")
                        .font(.system(size: 17, weight: .bold))
                    SecureField("", text: $password)
                        .padding()
                        .background(
                            RoundedRectangle(cornerRadius: 10)
                                .foregroundColor(.buttoncolor)
                                .frame(width: 300, height: 45)
                        )
                }
                .padding(50)
                Button(action: {
                    AF.request(Storage().loginapiKey, method: .post, parameters: ["email": self.email, "password": self.password], encoding: JSONEncoding.default)
                        .responseJSON { response in
                            switch response.result {
                            case .success(let value):
                                if let statusCode = response.response?.statusCode, statusCode == 401 {
                                    isLoggedIn = false
                                    print("JSON: \(value)")
                                } else if let json = value as? [String: Any], let token = json["token"] as? String, let teacher = json["teacher"] as? Int {
                                    TokenManager.shared.token = token
                                    isLoggedIn = true
                                    isTeacher = teacher == 1
                                    print("JSON: \(value)")
                                    UserDefaults.standard.set(email, forKey: "email")
                                }
                            case .failure(let error):
                                print(error)
                            }
                        }
                }) {
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
                    NavigationLink(destination: {
                        if isTeacher {
                            return AnyView(TeacherHomeView())
                        } else {
                            return AnyView(TabbarView())
                        }
                    }(), isActive: $isLoggedIn) {
                        EmptyView()
                    }
                        .hidden()
                )
            }
        }
        .navigationBarBackButtonHidden(true)
    }
}

#Preview {
    LoginView()
}
