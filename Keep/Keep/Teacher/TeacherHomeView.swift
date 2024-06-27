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
    @State private var selectedGrade: String = "1"
    @State private var selectedClass: String = "1"
    @State private var selectedNum: String = "1"
    @State private var studentInfo: [String: Any]?
    @State private var navigateToStudentInfo = false
    @State private var multipleStudents: [[String: Any]] = []
    
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
                    ZStack {
                        Picker("학년 선택", selection: $selectedGrade) {
                            ForEach(ScGrades, id: \.self) { grade in
                                Text(grade).tag(grade)
                            }
                        }
                        .pickerStyle(.inline)
                        .frame(width: 350, height: 120)
                        Text("학년")
                            .font(.system(size: 18, weight: .semibold))
                            .padding(.leading,70)
                    }
                    
                    ZStack {
                        Picker("반 선택", selection: $selectedClass) {
                            ForEach(ScClass, id: \.self) { cls in
                                Text(cls).tag(cls)
                            }
                        }
                        .pickerStyle(.inline)
                        .frame(width: 350, height: 120)
                        Text("반")
                            .font(.system(size: 18, weight: .semibold))
                            .padding(.leading,60)
                    }
                    
                    ZStack {
                        Picker("번호 선택", selection: $selectedNum) {
                            ForEach(ScNum, id: \.self) { num in
                                Text(num).tag(num)
                            }
                        }
                        .pickerStyle(.inline)
                        .frame(width: 350, height: 120)
                        Text("번")
                            .font(.system(size: 18, weight: .semibold))
                            .padding(.leading,60)
                    }
                    
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
                
                NavigationLink(destination: StudentInfoView(studentInfo: studentInfo ?? [:]), isActive: $navigateToStudentInfo) {
                    EmptyView()
                }
                NavigationLink(destination: SearchDetailView(students: multipleStudents, studentName: StSearch), isActive: .constant(!multipleStudents.isEmpty)) {
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
                    if let responseDict = value as? [String: Any], let dataArray = responseDict["data"] as? [[String: Any]] {
                        DispatchQueue.main.async {
                            if dataArray.count == 1 {
                                self.studentInfo = dataArray.first
                                self.navigateToStudentInfo = true
                                self.multipleStudents = []
                            } else {
                                self.studentInfo = nil
                                self.navigateToStudentInfo = false
                                self.multipleStudents = dataArray
                            }
                        }
                    } else {
                        DispatchQueue.main.async {
                            self.studentInfo = nil
                            self.navigateToStudentInfo = false
                            self.multipleStudents = []
                        }
                    }
                case .failure(let error):
                    DispatchQueue.main.async {
                        self.studentInfo = nil
                        self.navigateToStudentInfo = false
                        self.multipleStudents = []
                    }
                    print("Error: \(error.localizedDescription)")
                }
            }
    }
    
    // 학번으로 검색하는 함수
    func IdsendRequest() {
        guard let grade = Int(selectedGrade), let cls = Int(selectedClass), let num = Int(selectedNum) else {
            print("Invalid selectedGrade, selectedClass, or selectedNum")
            return
        }
        
        let studentId = "\(grade)\(cls)\(String(format: "%02d", num))"
        
        let parameters: [String: Any] = [
            "studentId": studentId
        ]
        
        AF.request(Storage().studentfindidapiKey, method: .post, parameters: parameters, encoding: JSONEncoding.default)
            .validate()
            .responseJSON { response in
                switch response.result {
                case .success(let value):
                    if let responseDict = value as? [String: Any], let responseData = responseDict["data"] as? [String: Any] {
                        DispatchQueue.main.async {
                            self.studentInfo = responseData
                            self.navigateToStudentInfo = true
                            self.multipleStudents = []
                        }
                    } else {
                        DispatchQueue.main.async {
                            self.studentInfo = nil
                            self.navigateToStudentInfo = false
                            self.multipleStudents = []
                        }
                    }
                case .failure(let error):
                    DispatchQueue.main.async {
                        self.studentInfo = nil
                        self.navigateToStudentInfo = false
                        self.multipleStudents = []
                    }
                    print("Error: \(error.localizedDescription)")
                }
            }
    }
}

#Preview {
    TeacherHomeView()
}

