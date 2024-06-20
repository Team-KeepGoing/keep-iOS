//
//  LendlistView.swift
//  Keep
//
//  Created by bibiga on 4/8/24.
//

import SwiftUI
import Alamofire

struct LendItemView: View {
    var deviceName: String
    var lendDate: String?
    
    var body: some View {
        VStack {
            Rectangle()
                .frame(width: 340, height: 60)
                .foregroundColor(.buttoncolor)
                .cornerRadius(15)
                .overlay(
                    VStack(alignment: .leading) {
                        HStack {
                            Text(deviceName)
                                .font(.system(size: 22, weight: .semibold))
                                .padding(.leading, 10)
                            
                            Spacer()
                            
                            if let lendDate = lendDate {
                                Text(formatDate(lendDate))
                                    .padding(.horizontal, 10)
                            } else {
                                Text("날짜 없음")
                                    .padding(.horizontal, 10)
                            }
                        }
                        .padding(.horizontal, 10)
                    }
                )
        }
    }
    
    func formatDate(_ dateString: String) -> String {
        // 예시: "2024-06-14T15:11:02.418662" 형식에서 앞에서 10글자를 추출하여 "yyyy-MM-dd" 형식으로 변환
        let dateSubstring = String(dateString.prefix(10))
        
        return dateSubstring
    }
}





struct LendlistView: View {
    @State private var lendItems: [(String, String?)] = []
    @State private var errorMessage: String?
    
    @ObservedObject private var tokenManager = TokenManager.shared
    
    var body: some View {
        VStack {
            Text("나의 대여 목록")
                .font(.system(size: 28, weight: .semibold))
                .padding(.trailing, 170)
            
            Rectangle()
                .frame(height: 1)
                .foregroundColor(.gray)
            
            ScrollView {
                VStack(spacing: 15) {
                    ForEach(lendItems, id: \.0) { item in
                        LendItemView(deviceName: item.0, lendDate: item.1)
                    }
                }
            }
            .padding()
            .frame(height: 600)
        }
        .onAppear {
            fetchLendItems()
        }
    }
    
    func fetchLendItems() {
        guard let token = tokenManager.token else {
            errorMessage = "토큰이 없습니다."
            return
        }
        
        let headers: HTTPHeaders = [
            "Authorization": "Bearer \(token)"
        ]
        
        AF.request(Storage().mydevicelendlistapiKey, headers: headers).responseDecodable(of: LendResponse.self) { response in
            switch response.result {
            case .success(let lendResponse):
                lendItems = lendResponse.data.map { ($0.deviceName, $0.rentDate) }
            case .failure(let error):
                if let data = response.data, let utf8Text = String(data: data, encoding: .utf8) {
                    print("응답 데이터: \(utf8Text)") // 실패 시 응답 데이터 출력
                }
                errorMessage = "네트워크 요청 실패: \(error.localizedDescription)"
                print("네트워크 요청 실패: \(error.localizedDescription)")
            }
        }
    }
}

struct LendResponse: Decodable {
    let httpStatus: String
    let message: String
    let data: [LendDevice]
}

struct LendDevice: Decodable {
    let imgUrl: String
    let id: Int
    let status: String
    let deviceName: String
    let rentDate: String
}

#Preview {
    LendlistView()
}

