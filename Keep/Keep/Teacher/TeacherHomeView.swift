//
//  TeacherHomeView.swift
//  Keep
//
//  Created by bibiga on 4/4/24.
//

import SwiftUI

struct TeacherHomeView: View {
    let ScGrades = ["1","2","3"]
    let ScClass = ["1","2","3","4"]
    let ScNum = ["1","2","3","4","5","6","7","8","9","10","11","12","13","14","15","16","17","18","19","20"]
    
    @State private var StSearch: String = ""
    @State private var selectedGrade: Int = 1
    @State private var selectedClass: Int = 1
    @State private var selectedNum: Int = 7
    
    var body: some View {
        VStack(alignment:.leading) {
            Text("학생정보 검색")
                .font(.system(size: 25, weight: .semibold))
            Spacer()
                .frame(height:30)
            HStack {
                TextField("이름을 입력해주세요.", text: $StSearch)
                    .frame(width: 280,height:20)
                Button {
                    
                } label: {
                    Image(systemName: "magnifyingglass")
                        .resizable()
                        .scaledToFit()
                        .foregroundColor(.black)
                        .frame(width:30)
                }
            }
            Rectangle()
                .frame(width:325,height:2)
            Spacer()
                .frame(height:50)
            Text("학번으로 검색")
                .font(.system(size: 25, weight: .semibold))
        }
        ZStack {
            Text("학년")
                .offset(x: -150, y: -35)
                .font(.system(size: 15,weight: .thin))
            VStack {
                Picker("학년 선택", selection: $selectedGrade) {
                    ForEach(ScGrades.indices, id: \.self) { index in
                        Text(self.ScGrades[index]).tag(index)
                    }
                }
                .pickerStyle(.inline)
                .frame(width:350, height: 120)
            }
        }
        ZStack {
            Text("반")
                .offset(x: -156, y: -35)
                .font(.system(size: 15,weight: .thin))
            VStack {
                Picker("학년 선택", selection: $selectedClass) {
                    ForEach(ScClass.indices, id: \.self) { index in
                        Text(self.ScClass[index]).tag(index)
                    }
                }
                .pickerStyle(.inline)
                .frame(width:350, height: 120)
            }
        }
        ZStack {
            Text("번호")
                .offset(x: -150, y: -35)
                .font(.system(size: 15,weight: .thin))
            VStack {
                Picker("학년 선택", selection: $selectedNum) {
                    ForEach(ScNum.indices, id: \.self) { index in
                        Text(self.ScNum[index]).tag(index)
                    }
                }
                .pickerStyle(.inline)
                .frame(width:350, height: 120)
            }
        }
        Button {
            
        } label: {
            Rectangle()
                .foregroundColor(.selbutton)
                .frame(width:110,height:40)
                .cornerRadius(20)
                .overlay(
                    Text("검색")
                        .foregroundColor(.white)
                        .bold()
                )
        }
    }
}

#Preview {
    TeacherHomeView()
}
