//
//  ContentView.swift
//  Keep
//
//  Created by bibiga on 3/12/24.
//

import SwiftUI
import UserNotifications

struct ContentView: View {
    var body: some View {
        NavigationView {
            VStack {
                Image("Logo")
                    .resizable()
                    .scaledToFit()
                    .frame(width: 130)
                Text("대출/반납을 더욱 간편하게")
                    .font(.system(size: 20, weight: .light))
                
                Spacer()
                    .frame(height:40)
                
                NavigationLink(destination: LoginView()) {
                    ZStack {
                        Rectangle()
                            .foregroundColor(.buttoncolor)
                            .frame(width: 310, height: 60)
                            .cornerRadius(20)
                        Text("로그인")
                            .foregroundColor(.black)
                            .font(.system(size: 27, weight: .bold))
                    }
                }
                .padding(.bottom)
                
                NavigationLink(destination: SignupView()) {
                    ZStack {
                        Rectangle()
                            .foregroundColor(.buttoncolor)
                            .frame(width: 310, height: 60)
                            .cornerRadius(20)
                        Text("회원가입")
                            .foregroundColor(.black)
                            .font(.system(size: 27, weight: .bold))
                    }
                }
            }
        }
        .onAppear {
            requestNotificationPermission()
        }
    }
}

#Preview {
    ContentView()
}
