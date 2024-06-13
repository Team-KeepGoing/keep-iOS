//
//  StudentInfoView.swift
//  Keep
//
//  Created by bibiga on 4/6/24.
//

import SwiftUI

struct StudentInfoView: View {
    var studentInfo: [String: Any]?
    
    @State private var StName: String = ""
    @State private var StId: String = ""
    @State private var StPhoneNumber: String = ""
    
    var body: some View {
        VStack {
            Text("학생정보")
                .font(.system(size: 25, weight: .bold))
                .offset(x: -115)
            Spacer().frame(height: 30)
            
            ZStack {
                Rectangle()
                    .frame(width: 320, height: 510)
                    .foregroundColor(.buttoncolor)
                    .cornerRadius(15)
                
                VStack(spacing: 10) {
                    Image(systemName: "person.circle.fill")
                        .resizable()
                        .scaledToFit()
                        .frame(width: 200)
                        .padding()
                    
                    Text(StName)
                        .font(.system(size: 30, weight: .bold))
                    
                    Text(StId)
                        .font(.system(size: 20, weight: .thin))
                    
                    Text(StPhoneNumber)
                        .font(.system(size: 20, weight: .thin))
                }
            }
        }
        .onAppear {
            if let info = studentInfo {
                self.StName = info["studentName"] as? String ?? "학생 이름 없음"
                self.StId = info["studentId"] as? String ?? "0"
                self.StPhoneNumber = info["phoneNum"] as? String ?? "전화번호 없음"
            }
        }
    }
}

#Preview {
    StudentInfoView(studentInfo: ["studentName": "김주환", "studentId": 2307, "phoneNum": "010-7777-7777"])
}

