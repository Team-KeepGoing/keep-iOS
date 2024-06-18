//
//  MypageView.swift
//  Keep
//
//  Created by bibiga on 4/8/24.
//

import SwiftUI
import Alamofire
import SDWebImageSwiftUI

struct BorrowedBook: Codable {
    let id: Int
    let bookName: String
    let imageUrl: String?  // 이미지 URL은 옵셔널로 설정합니다.
    let rentDate: String  // 예시에서는 String으로 설정되어 있지만, Date로 설정하는 것이 좋습니다.
    let state: String
}

// JSON 응답 구조체 정의
struct UserInfoResponse: Codable {
    let user: User
    let borrowedDevices: [BorrowedDevice]
    let borrowedBooks: [BorrowedBook]
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
    @Published var borrowedBooks: [BorrowedBook] = []
    
    func fetchUserInfo(token: String) {
        let headers: HTTPHeaders = [
            "Authorization": "Bearer \(token)"
        ]
        
        AF.request(Storage().userinfoapiKey, method: .get, headers: headers).responseData { response in
            switch response.result {
            case .success(let data):
                do {
                    let userInfoResponse = try JSONDecoder().decode(UserInfoResponse.self, from: data)
                    DispatchQueue.main.async {
                        self.userInfo = userInfoResponse.user
                        self.borrowedDevices = userInfoResponse.borrowedDevices
                        self.borrowedBooks = userInfoResponse.borrowedBooks
                    }
                } catch {
                    DispatchQueue.main.async {
                        self.responseData = "JSON 디코딩 실패: \(error.localizedDescription)"
                        print("JSON 디코딩 실패: \(error.localizedDescription)")
                    }
                }
            case .failure(let error):
                DispatchQueue.main.async {
                    self.responseData = "네트워크 요청 실패: \(error.localizedDescription)"
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
                                Text("로딩 중...")
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
                                ForEach(viewModel.borrowedBooks, id: \.id) { book in
                                    if let imageUrl = book.imageUrl, let url = URL(string: imageUrl) {
                                        WebImage(url: url)
                                            .resizable()
                                            .scaledToFit()
                                            .frame(width:90)
                                    } else {
                                        Image("placeholder_image")
                                            .resizable()
                                            .scaledToFit()
                                            .frame(width:90)
                                    }
                                }
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
                                                .frame(width: 80, height: 80)
                                                .clipShape(Circle())
                                                .padding()
                                        } else {
                                            Image("macbook")
                                                .resizable()
                                                .scaledToFit()
                                                .frame(width: 80, height: 80)
                                                .clipShape(Circle())
                                                .padding()
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
