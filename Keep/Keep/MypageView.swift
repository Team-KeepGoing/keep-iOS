//
//  MypageView.swift
//  Keep
//
//  Created by bibiga on 4/8/24.
//

import SwiftUI
import Alamofire


struct UserInfo: Codable {
    let email: String
    let name: String
}

class UserInfoViewModel: ObservableObject {
    @Published var responseData: String = "Loading..."
    @Published var userInfo: UserInfo?
    
    func fetchUserInfo(token: String) {
        let headers: HTTPHeaders = [
            "Authorization": "Bearer \(token)"
        ]
        
        AF.request(Storage().userinfoapiKey, method: .get, headers: headers).responseData { response in
            switch response.result {
            case .success(let data):
                do {
                    let userInfo = try JSONDecoder().decode(UserInfo.self, from: data)
                    DispatchQueue.main.async {
                        self.userInfo = userInfo
                    }
                } catch {
                    DispatchQueue.main.async {
                        self.responseData = "Failed to decode JSON: \(error.localizedDescription)"
                    }
                }
            case .failure(let error):
                DispatchQueue.main.async {
                    self.responseData = "Error: \(error.localizedDescription)"
                }
            }
        }
    }
}

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
                            .frame(width:112)
                        Spacer()
                            .frame(width:20)
                        VStack(alignment: .leading, spacing:10) {
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
                .offset(x:10)
                Spacer()
                    .frame(height: 30)
                ZStack {
                    Rectangle()
                        .cornerRadius(8)
                        .foregroundColor(.buttoncolor)
                        .frame(height: 250)
                    VStack {
                        Text("회원님이 대출중인 책")
                            .font(.system(size: 15, weight: .semibold))
                            .padding(.trailing, 170)
                        ScrollView(.horizontal) {
                            HStack {
                                Image("book1")
                                    .resizable()
                                    .scaledToFit()
                                    .frame(width:100)
                                    .padding(.bottom, 30)
                                Image("book1")
                                    .resizable()
                                    .scaledToFit()
                                    .frame(width:100)
                                    .padding(.bottom, 30)
                                Image("book1")
                                    .resizable()
                                    .scaledToFit()
                                    .frame(width:100)
                                    .padding(.bottom, 30)
                                Image("book1")
                                    .resizable()
                                    .scaledToFit()
                                    .frame(width:100)
                                    .padding(.bottom, 30)
                            }
                        }
                        .frame(height: 170)
                        NavigationLink(destination: BooklistView()) {
                            Text("나의 대출 목록 확인")
                                .font(.system(size: 13, weight: .medium))
                                .padding(.leading,220)
                        }
                    }
                    .padding()
                }
                .padding()
                
                
                ZStack {
                    Rectangle()
                        .cornerRadius(8)
                        .foregroundColor(.buttoncolor)
                        .frame(height: 170)
                    VStack {
                        Text("회원님이 대여중인 기자재")
                            .font(.system(size: 15, weight: .semibold))
                            .padding(.trailing, 150)
                        HStack{
                            ScrollView{
                                
                            }
                            .frame(height: 80)
                        }
                        NavigationLink(destination: LendlistView()) {
                            Text("나의 기자재 대여 목록 확인")
                                .font(.system(size: 13, weight: .medium))
                                .padding(.leading,175)
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
