//
//  StudentInfoView.swift
//  Keep
//
//  Created by bibiga on 4/6/24.
//

import SwiftUI

struct StudentInfoView: View {
    
    @State private var StName: String = "김주환"
    @State private var StClass: Int = 2
    @State private var StGrade: Int = 2
    @State private var StNum: Int = 8
    @State private var StPhoneNumber: String = "010-1234-5678"
    
    var body: some View {
        Text("학생정보")
            .font(.system(size: 25, weight: .bold))
            .offset(x: -115)
        Spacer()
            .frame(height:30)
        ZStack {
            Rectangle()
                .frame(width:320,height:510)
                .foregroundColor(.buttoncolor)
                .cornerRadius(15)
            VStack(spacing:10) {
                Image(systemName: "person.circle.fill")
                    .resizable()
                    .scaledToFit()
                    .frame(width:200)
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
}

#Preview {
    StudentInfoView()
}
