//
//  TeacherHomeView.swift
//  Keep
//
//  Created by bibiga on 4/4/24.
//

import SwiftUI
import Alamofire

struct TeacherHomeView: View {
    let ScGrades = ["1", "2", "3"]
    let ScClass = ["1", "2", "3", "4"]
    let ScNum = Array(1...20).map { String($0) }
    
    @State private var StSearch: String = ""
    @State private var selectedGrade: Int = 1
    @State private var selectedClass: Int = 1
    @State private var selectedNum: Int = 7
    @State private var studentInfo: [String: Any]?
    @State private var navigateToStudentInfo = false
    
    var body: some View {
        NavigationView {
            VStack(alignment: .leading) {
                VStack(alignment: .leading) {
                    Text("학생정보 검색")
                        .font(.system(size: 25, weight: .semibold))
                    Spacer().frame(height: 30)
                    
                    HStack {
                        TextField("이름을 입력해주세요.", text: $StSearch)
                            .frame(width: 280, height: 20)
                        Button(action: {
                            NamesendRequest()
                        }) {
                            Image(systemName: "magnifyingglass")
                                .resizable()
                                .scaledToFit()
                                .foregroundColor(.black)
                                .frame(width: 30)
                        }
                    }
                    
                    Rectangle().frame(width: 325, height: 2)
                    Spacer().frame(height: 50)
                    
                    Text("학번으로 검색")
                        .font(.system(size: 25, weight: .semibold))
                }
                .padding(.leading, 10)
                
                VStack {
                    Picker("학년 선택", selection: $selectedGrade) {
                        ForEach(ScGrades, id: \.self) { grade in
                            Text(grade).tag(Int(grade) ?? 1)
                        }
                    }
                    .pickerStyle(.inline)
                    .frame(width: 350, height: 120)
                    
                    Picker("반 선택", selection: $selectedClass) {
                        ForEach(ScClass, id: \.self) { cls in
                            Text(cls).tag(Int(cls) ?? 1)
                        }
                    }
                    .pickerStyle(.inline)
                    .frame(width: 350, height: 120)
                    
                    Picker("번호 선택", selection: $selectedNum) {
                        ForEach(ScNum, id: \.self) { num in
                            Text(num).tag(Int(num) ?? 1)
                        }
                    }
                    .pickerStyle(.inline)
                    .frame(width: 350, height: 120)
                    
                    Spacer().frame(height: 40)
                    
                    Button(action: {
                        IdsendRequest()
                    }) {
                        Rectangle()
                            .foregroundColor(.selbutton)
                            .frame(width: 110, height: 40)
                            .cornerRadius(20)
                            .overlay(
                                Text("검색")
                                    .foregroundColor(.white)
                                    .bold()
                            )
                    }
                }
                
                NavigationLink(destination: StudentInfoView(studentInfo: studentInfo), isActive: $navigateToStudentInfo) {
                    EmptyView()
                }
            }
        }
        .navigationBarBackButtonHidden(true)
    }
    
    // 이름으로 검색하는 함수
    func NamesendRequest() {
        let parameters: [String: Any] = [
            "studentName": StSearch
        ]
        
        AF.request(Storage().studentfindnameapiKey, method: .post, parameters: parameters, encoding: JSONEncoding.default)
            .validate()
            .responseJSON { response in
                switch response.result {
                case .success(let value):
                    if let responseDict = value as? [String: Any], let data = responseDict["data"] as? [String: Any] {
                        DispatchQueue.main.async {
                            self.studentInfo = data
                            self.navigateToStudentInfo = true // 화면 전환을 위해 true로 설정
                        }
                    } else {
                        DispatchQueue.main.async {
                            self.studentInfo = nil
                            self.navigateToStudentInfo = false
                        }
                    }
                case .failure(let error):
                    DispatchQueue.main.async {
                        self.studentInfo = nil
                        self.navigateToStudentInfo = false
                    }
                    print("Error: \(error.localizedDescription)")
                }
            }
    }
    
    // 학번으로 검색하는 함수
    func IdsendRequest() {
        let studentId = String(format: "%d%d%02d", selectedGrade, selectedClass, selectedNum)
        
        let parameters: [String: Any] = [
            "studentId": studentId
        ]
        
        AF.request(Storage().studentfindidapiKey, method: .post, parameters: parameters, encoding: JSONEncoding.default)
            .validate()
            .responseJSON { response in
                switch response.result {
                case .success(let value):
                    if let responseDict = value as? [String: Any], let data = responseDict["data"] as? [String: Any] {
                        DispatchQueue.main.async {
                            self.studentInfo = data
                            self.navigateToStudentInfo = true // 화면 전환을 위해 true로 설정
                        }
                    } else {
                        DispatchQueue.main.async {
                            self.studentInfo = nil
                            self.navigateToStudentInfo = false
                        }
                    }
                case .failure(let error):
                    DispatchQueue.main.async {
                        self.studentInfo = nil
                        self.navigateToStudentInfo = false
                    }
                    print("Error: \(error.localizedDescription)")
                }
            }
    }
}

#Preview {
    TeacherHomeView()
}

