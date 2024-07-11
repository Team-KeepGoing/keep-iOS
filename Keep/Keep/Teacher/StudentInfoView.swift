//
//  StudentInfoView.swift
//  Keep
//
//  Created by bibiga on 4/6/24.
//

import SwiftUI
import SDWebImageSwiftUI

struct StudentInfoView: View {
    var studentInfo: [String: Any]?
    
    @State private var StName: String = ""
    @State private var StGrade: String = ""
    @State private var StClass: String = ""
    @State private var StNum: String = ""
    @State private var StPhoneNumber: String = ""
    @State private var StImageUrl: String = ""
    
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
                    if let url = URL(string: StImageUrl) {
                        WebImage(url: url)
                            .resizable()
                            .frame(width: 200, height: 200)
                            .cornerRadius(100)
                    } else {
                        Image(systemName: "person.circle.fill")
                            .resizable()
                            .scaledToFit()
                            .frame(width: 200, height: 200)
                            .padding()
                    }
                    Spacer()
                        .frame(height:10)
                    
                    Text(StName)
                        .font(.system(size: 30, weight: .bold))
                    
                    Text("\(StGrade)학년 \(StClass)반 \(StNum)번")
                        .font(.system(size: 20, weight: .thin))
                    
                    Text(StPhoneNumber)
                        .font(.system(size: 20, weight: .thin))
                }
            }
        }
        .onAppear {
            if let info = studentInfo {
                self.StName = info["studentName"] as? String ?? "학생 이름 없음"
                if let studentId = info["studentId"] as? String, studentId.count == 4 {
                    let grade = String(studentId.prefix(1))
                    let cls = String(studentId.dropFirst().prefix(1))
                    if let numInt = Int(studentId.suffix(2)) {
                        self.StNum = String(numInt)
                    } else {
                        self.StNum = "번호 정보 없음"
                    }
                    
                    self.StGrade = grade
                    self.StClass = cls
                } else {
                    self.StGrade = "학년 정보 없음"
                    self.StClass = "반 정보 없음"
                    self.StNum = "번호 정보 없음"
                }
                self.StPhoneNumber = info["phoneNum"] as? String ?? "전화번호 없음"
                self.StImageUrl = info["imgUrl"] as? String ?? ""
            }
        }
    }
}

#Preview {
    StudentInfoView(studentInfo: ["studentName": "김주환", "studentId": "2307", "phoneNum": "010-7777-7777", "imgUrl": "https://keepgoingbucket.s3.ap-northeast-2.amazonaws.com/picture/김주환.jpeg"])
}

