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
    
    var body: some View {
        NavigationView { // NavigationView로 둘러싸서 네비게이션을 사용합니다.
            VStack {
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
                    AF.request("http://52.79.143.148:8080/user/signin", method: .post, parameters: ["email": self.email, "password": self.password])
                        .responseJSON { response in
                            switch response.result {
                            case .success(let value):
                                print("JSON: \(value)")
                                isLoggedIn = true
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
                    NavigationLink(destination: TabbarView(), isActive: $isLoggedIn) {
                        EmptyView()
                    }
                    .hidden()
                )
            }
        }
    }
}

#Preview {
    LoginView()
}
