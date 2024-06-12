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
    let ScNum = ["1", "2", "3", "4", "5", "6", "7", "8", "9", "10", "11", "12", "13", "14", "15", "16", "17", "18", "19", "20"]
    
    @State private var StSearch: String = ""
    @State private var selectedGrade: Int = 1
    @State private var selectedClass: Int = 1
    @State private var selectedNum: Int = 7
    @State private var responseText: String = ""
    @State private var studentInfo: [String: Any]?
    @State private var navigateToStudentInfo = false
    
    var body: some View {
        NavigationView {
            VStack(alignment: .leading) {
                VStack(alignment:.leading) {
                    Text("학생정보 검색")
                        .font(.system(size: 25, weight: .semibold))
                    Spacer().frame(height: 30)
                    
                    HStack {
                        TextField("이름을 입력해주세요.", text: $StSearch)
                            .frame(width: 280, height: 20)
                        Button {
                            sendRequest()
                        } label: {
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
                        Text("학년")
                            .offset(x: -150, y: -35)
                            .font(.system(size: 15, weight: .thin))
                        Picker("학년 선택", selection: $selectedGrade) {
                            ForEach(ScGrades.indices, id: \.self) { index in
                                Text(self.ScGrades[index]).tag(index + 1)
                            }
                        }
                        .pickerStyle(.inline)
                        .frame(width: 350, height: 120)
                    }
                    
                    ZStack {
                        Text("반")
                            .offset(x: -156, y: -35)
                            .font(.system(size: 15, weight: .thin))
                        Picker("반 선택", selection: $selectedClass) {
                            ForEach(ScClass.indices, id: \.self) { index in
                                Text(self.ScClass[index]).tag(index + 1)
                            }
                        }
                        .pickerStyle(.inline)
                        .frame(width: 350, height: 120)
                    }
                    
                    ZStack {
                        Text("번호")
                            .offset(x: -150, y: -35)
                            .font(.system(size: 15, weight: .thin))
                        Picker("번호 선택", selection: $selectedNum) {
                            ForEach(ScNum.indices, id: \.self) { index in
                                Text(self.ScNum[index]).tag(index + 1)
                            }
                        }
                        .pickerStyle(.inline)
                        .frame(width: 350, height: 120)
                    }
                    
                    Spacer()
                        .frame(height:40)
                    
                    NavigationLink(destination: StudentInfoView(studentInfo: studentInfo), isActive: $navigateToStudentInfo) {
                        Button {
                            sendRequest()
                        } label: {
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
                }
            }
        }
        .navigationBarBackButtonHidden(true)
    }
    
    func sendRequest() {
        let parameters: [String: Any] = [
            "name": StSearch,
            "grade": selectedGrade,
            "group": selectedClass,
            "groupNum": selectedNum
        ]
        
        AF.request(Storage().studentfindapiKey, method: .get, parameters: parameters, encoding: URLEncoding.default)
            .validate()
            .responseJSON { response in
                switch response.result {
                case .success(let value):
                    if let responseDict = value as? [String: Any] {
                        self.studentInfo = responseDict
                        self.navigateToStudentInfo = true
                    } else if let jsonData = try? JSONSerialization.data(withJSONObject: value, options: .prettyPrinted),
                              let jsonString = String(data: jsonData, encoding: .utf8) {
                        self.responseText = jsonString
                    }
                    print("Success: \(value)")
                case .failure(let error):
                    if let data = response.data, let errorResponse = String(data: data, encoding: .utf8) {
                        self.responseText = "Error: \(error.localizedDescription)\n\(errorResponse)"
                    } else {
                        self.responseText = "Error: \(error.localizedDescription)"
                    }
                    print("Error: \(error)")
                }
            }
    }
}

struct SearchDetailView: View {
    var body: some View {
        NavigationView {
            VStack(alignment: .leading) {
                Text("'김주환' 학생 검색결과")
                    .font(.system(size: 28, weight: .semibold))
                
                Spacer()
                    .frame(height:30)
                
                ScrollView {
                    VStack(spacing:20) {
                        Rectangle()
                            .frame(width:330,height: 60)
                            .cornerRadius(15)
                            .foregroundColor(.buttoncolor)
                            .overlay {
                                HStack {
                                    Text("김주환1")
                                        .font(.system(size: 25, weight: .semibold))
                                    Text("2208")
                                        .font(.system(size: 20, weight: .light))
                                    Spacer()
                                        .frame(width:120)
                                    Button {
                                        
                                    } label : {
                                        Image(systemName: "magnifyingglass")
                                            .resizable()
                                            .scaledToFit()
                                            .frame(width:30)
                                            .foregroundColor(.black)
                                    }
                                }
                            }
                        Rectangle()
                            .frame(width:330,height: 60)
                            .cornerRadius(15)
                            .foregroundColor(.buttoncolor)
                            .overlay {
                                HStack {
                                    Text("김주환2")
                                        .font(.system(size: 25, weight: .semibold))
                                    Text("2308")
                                        .font(.system(size: 20, weight: .light))
                                    Spacer()
                                        .frame(width:120)
                                    Button {
                                        
                                    } label : {
                                        Image(systemName: "magnifyingglass")
                                            .resizable()
                                            .scaledToFit()
                                            .frame(width:30)
                                            .foregroundColor(.black)
                                    }
                                }
                            }
                    }
                }
                .frame(height:600)
            }
        }
    }
}

#Preview {
    TeacherHomeView()
}
