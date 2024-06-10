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
    var lendDate: String? // 현재 예시 JSON에 lendDate가 없으므로 사용되지 않음
    
    var body: some View {
        Rectangle()
            .frame(width: 340, height: 60)
            .foregroundColor(.buttoncolor)
            .cornerRadius(15)
            .overlay(
                HStack(spacing: 120) {
                    Text(deviceName)
                        .font(.system(size: 22, weight: .semibold))
                    if let lendDate = lendDate {
                        Text(lendDate)
                    } else {
                        Text("날짜 없음")
                    }
                }
            )
    }
}

struct LendlistView: View {
    @State private var lendItems: [(String, String?)] = []
    @State private var errorMessage: String?

    @ObservedObject private var tokenManager = TokenManager.shared
    
    var body: some View {
        VStack {
            Text("나의 대여 목록")
                .font(.system(size: 28, weight: .bold))
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
                lendItems = lendResponse.data.map { ($0.deviceName, nil) }
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

    enum CodingKeys: String, CodingKey {
        case httpStatus
        case message = "massage" // 'message' 키도 처리하도록 수정
        case data
    }
}

struct LendDevice: Decodable {
    let imgUrl: String
    let id: Int
    let status: Bool
    let deviceName: String
}

#Preview {
    LendlistView()
}
