//
//  BooklistView.swift
//  Keep
//
//  Created by bibiga on 4/8/24.
//

import SwiftUI

struct BooklistView: View {
    var body: some View {
        VStack {
            Text("나의 대출 목록")
                .font(.system(size: 28, weight: .bold))
                .padding(.trailing,170)
            Rectangle()
                .frame(height:1)
                .foregroundColor(.gray)
            ScrollView {
                VStack {
                    HStack(spacing:30) {
                        Image("book1")
                            .resizable()
                            .scaledToFit()
                            .frame(width:120)
                        VStack(alignment: .leading, spacing: 20) {
                            VStack(alignment: .leading, spacing: 3) {
                                Text("인간실격")
                                    .font(.system(size: 20,weight:.semibold))
                                Text("디자이 오사무")
                                    .font(.system(size: 12))
                            }
                            VStack(alignment: .leading, spacing: 3) {
                                Text("대출일")
                                    .font(.system(size: 12))
                                Text("2024.03.28")
                                    .font(.system(size: 12))
                                    .foregroundColor(.blue)
                            }
                            VStack(alignment: .leading, spacing: 3) {
                                Text("반납 예정일")
                                    .font(.system(size: 12))
                                Text("2024.04.11")
                                    .font(.system(size: 12))
                                    .foregroundColor(.red)
                            }
                        }
                    }
                    .padding()
                    Rectangle()
                        .frame(width:500,height:1)
                        .foregroundColor(.gray)
                    HStack(spacing:30) {
                        Image("book1")
                            .resizable()
                            .scaledToFit()
                            .frame(width:120)
                        VStack(alignment: .leading, spacing: 20) {
                            VStack(alignment: .leading, spacing: 3) {
                                Text("인간실격")
                                    .font(.system(size: 20,weight:.semibold))
                                Text("디자이 오사무")
                                    .font(.system(size: 12))
                            }
                            VStack(alignment: .leading, spacing: 3) {
                                Text("대출일")
                                    .font(.system(size: 12))
                                Text("2024.03.28")
                                    .font(.system(size: 12))
                                    .foregroundColor(.blue)
                            }
                            VStack(alignment: .leading, spacing: 3) {
                                Text("반납 예정일")
                                    .font(.system(size: 12))
                                Text("2024.04.11")
                                    .font(.system(size: 12))
                                    .foregroundColor(.red)
                            }
                        }
                    }
                    .padding()
                    Rectangle()
                        .frame(width:500,height:1)
                        .foregroundColor(.gray)
                    HStack(spacing:30) {
                        Image("book1")
                            .resizable()
                            .scaledToFit()
                            .frame(width:120)
                        VStack(alignment: .leading, spacing: 20) {
                            VStack(alignment: .leading, spacing: 3) {
                                Text("인간실격")
                                    .font(.system(size: 20,weight:.semibold))
                                Text("디자이 오사무")
                                    .font(.system(size: 12))
                            }
                            VStack(alignment: .leading, spacing: 3) {
                                Text("대출일")
                                    .font(.system(size: 12))
                                Text("2024.03.28")
                                    .font(.system(size: 12))
                                    .foregroundColor(.blue)
                            }
                            VStack(alignment: .leading, spacing: 3) {
                                Text("반납 예정일")
                                    .font(.system(size: 12))
                                Text("2024.04.11")
                                    .font(.system(size: 12))
                                    .foregroundColor(.red)
                            }
                        }
                    }
                    .padding()
                }
                .padding(.trailing,100)
            }
            .frame(height:600)
        }
    }
}

#Preview {
    BooklistView()
}
