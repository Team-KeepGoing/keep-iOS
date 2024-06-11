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
    @State private var StClass: Int = 0
    @State private var StGrade: Int = 0
    @State private var StNum: Int = 0
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
                    
                    Text("\(StName)")
                        .font(.system(size: 30, weight: .bold))
                    
                    Text("\(StGrade)학년 \(StClass)반 \(StNum)번")
                        .font(.system(size: 20, weight: .thin))
                    
                    Text("\(StPhoneNumber)")
                        .font(.system(size: 20, weight: .thin))
                }
            }
        }
        .onAppear {
            if let info = studentInfo {
                print(info)
                self.StName = info["name"] as? String ?? "김철수"
                self.StGrade = info["grade"] as? Int ?? 0
                self.StClass = info["group"] as? Int ?? 0
                self.StNum = info["groupNum"] as? Int ?? 0
                self.StPhoneNumber = info["phoneNumber"] as? String ?? "010-1234-5678"
            }
        }
    }
}

#Preview {
    StudentInfoView(studentInfo: ["name": "김주환", "grade": 2, "group": 2, "groupNum": 8, "phoneNumber": "010-1234-5678"])
}

