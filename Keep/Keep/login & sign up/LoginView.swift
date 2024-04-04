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
        Image("Logo")
            .resizable()
            .scaledToFit()
            .frame(width:120)
        VStack(alignment: .leading) {
            Text("이메일")
                .bold()
            Rectangle()
                .frame(width: 300, height: 45)
                .cornerRadius(10)
                .foregroundColor(.buttoncolor)
            Text("비밀번호")
                .bold()
            Rectangle()
                .frame(width: 300, height: 45)
                .cornerRadius(10)
                .foregroundColor(.buttoncolor)
        }
        .padding(50)
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
    LoginView()
}
