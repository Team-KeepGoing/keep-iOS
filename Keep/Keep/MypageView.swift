//
//  MypageView.swift
//  Keep
//
//  Created by bibiga on 4/8/24.
//

import SwiftUI
import Alamofire
import SDWebImageSwiftUI

// JSON 응답 구조체 정의
struct UserInfoResponse: Codable {
    let user: User
    let borrowedDevices: [BorrowedDevice]
}

struct User: Codable {
    let id: Int
    let email: String
    let password: String
    let name: String
    let teacher: Bool
}

struct BorrowedDevice: Codable {
    let id: Int
    let deviceName: String
    let imgUrl: String
    let status: String
}

// ViewModel 정의
class UserInfoViewModel: ObservableObject {
    @Published var responseData: String = "Loading..."
    @Published var userInfo: User?
    @Published var borrowedDevices: [BorrowedDevice] = []
    
    func fetchUserInfo(token: String) {
        let headers: HTTPHeaders = [
            "Authorization": "Bearer \(token)"
        ]
        
        AF.request(Storage().userinfoapiKey, method: .get, headers: headers).responseData { response in
            switch response.result {
            case .success(let data):
                print("응답 데이터: \(String(data: data, encoding: .utf8) ?? "nil")")
                do {
                    let userInfoResponse = try JSONDecoder().decode(UserInfoResponse.self, from: data)
                    DispatchQueue.main.async {
                        self.userInfo = userInfoResponse.user
                        self.borrowedDevices = userInfoResponse.borrowedDevices
                    }
                } catch {
                    DispatchQueue.main.async {
                        self.responseData = "Failed to decode JSON: \(error.localizedDescription)"
                        print("JSON 디코딩 실패: \(error.localizedDescription)")
                    }
                }
            case .failure(let error):
                DispatchQueue.main.async {
                    self.responseData = "Error: \(error.localizedDescription)"
                    print("네트워크 요청 실패: \(error.localizedDescription)")
                }
            }
        }
    }
}

// View 정의
struct MypageView: View {
    @EnvironmentObject var tokenManager: TokenManager
    @StateObject private var viewModel = UserInfoViewModel()
    
    var body: some View {
        NavigationView {
            VStack {
                VStack(alignment: .leading) {
                    Text("마이페이지")
                        .font(.system(size: 28, weight: .semibold))
                    HStack {
                        Image(systemName: "person.circle.fill")
                            .resizable()
                            .scaledToFit()
                            .frame(width: 112)
                        Spacer()
                            .frame(width: 20)
                        VStack(alignment: .leading, spacing: 10) {
                            if let userInfo = viewModel.userInfo {
                                Text(userInfo.name)
                                    .font(.system(size: 24, weight: .semibold))
                                    .frame(maxWidth: 100, alignment: .leading)
                                Text(userInfo.email)
                                    .font(.system(size: 18, weight: .light))
                                    .frame(maxWidth: 200, alignment: .leading)
                            } else {
                                Text("Loading...")
                                    .font(.system(size: 24, weight: .semibold))
                                    .font(.system(size: 18, weight: .light))
                            }
                        }
                    }
                }
                .offset(x: 10)
                
                ZStack {
                    Rectangle()
                        .cornerRadius(8)
                        .foregroundColor(.buttoncolor)
                        .frame(height: 250)
                    VStack {
                        Text("회원님이 대출중인 책")
                            .font(.system(size: 15, weight: .semibold))
                            .padding(.trailing, 190)
                        ScrollView(.horizontal) {
                            HStack {
                                Image("book1")
                                    .resizable()
                                    .scaledToFit()
                                    .frame(width: 100)
                                    .padding(.bottom, 30)
                                Image("book1")
                                    .resizable()
                                    .scaledToFit()
                                    .frame(width: 100)
                                    .padding(.bottom, 30)
                                Image("book1")
                                    .resizable()
                                    .scaledToFit()
                                    .frame(width: 100)
                                    .padding(.bottom, 30)
                                Image("book1")
                                    .resizable()
                                    .scaledToFit()
                                    .frame(width: 100)
                                    .padding(.bottom, 30)
                            }
                        }
                        .frame(height: 170)
                        NavigationLink(destination: BooklistView()) {
                            Text("나의 대출 목록 확인")
                                .font(.system(size: 13, weight: .medium))
                                .padding(.leading, 220)
                        }
                    }
                    .padding()
                }
                .padding()
                
                ZStack {
                    Rectangle()
                        .cornerRadius(8)
                        .foregroundColor(.buttoncolor)
                        .frame(height: 180)
                    VStack {
                        Text("회원님이 대여중인 기자재")
                            .font(.system(size: 15, weight: .semibold))
                            .padding(.trailing, 170)
                        HStack {
                            ScrollView(.horizontal) {
                                HStack {
                                    ForEach(viewModel.borrowedDevices, id: \.id) { device in
                                        if let url = URL(string: device.imgUrl) {
                                            WebImage(url: url)
                                                .resizable()
                                                .scaledToFit()
                                                .cornerRadius(50)
                                                .frame(width: 100, height: 100)
                                                .clipped()
                                        } else {
                                            Image("macbook")
                                                .resizable()
                                                .scaledToFit()
                                                .cornerRadius(50)
                                                .frame(width: 100, height: 100)
                                                .clipped()
                                        }
                                    }
                                }
                            }
                            .frame(height: 100)
                        }
                        NavigationLink(destination: LendlistView()) {
                            Text("나의 기자재 대여 목록 확인")
                                .font(.system(size: 13, weight: .medium))
                                .padding(.leading, 175)
                        }
                    }
                }
                .padding()
            }
            .onAppear {
                if let token = tokenManager.token {
                    viewModel.fetchUserInfo(token: token)
                }
            }
        }
    }
}


#Preview {
    MypageView().environmentObject(TokenManager.shared)
}
