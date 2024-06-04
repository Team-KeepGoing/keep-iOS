//
//  HomeView.swift
//  Keep
//
//  Created by bibiga on 4/4/24.
//

import SwiftUI
import Alamofire
import SDWebImageSwiftUI

struct DeviceModel: Identifiable, Codable {
    let id: Int
    let status: Int
    let deviceName: String
    let imgUrl: String?
}

struct LendStatusViewModel: View {
    var device: DeviceModel
    
    var body: some View {
        NavigationLink(destination: LendDetailView(deviceName: device.deviceName, imgUrl: device.imgUrl, status: device.status)) {
            HStack {
                if let imgUrl = device.imgUrl, let url = URL(string: imgUrl) {
                    WebImage(url: url)
                        .resizable()
                        .frame(width: 64, height: 64)
                        .cornerRadius(8)
                } else {
                    Image("placeholder")
                        .resizable()
                        .frame(width: 64, height: 64)
                        .cornerRadius(8)
                }
                VStack(alignment: .leading, spacing: 3) {
                    Text(device.deviceName)
                        .font(.system(size: 20, weight: .bold))
                        .foregroundColor(.black)
                    
                    Rectangle()
                        .frame(width: 45, height: 15)
                        .cornerRadius(7)
                        .foregroundColor(device.status == 2 ? .red : .blue)
                        .overlay(
                            Text(device.status == 2 ? "사용중" : "미사용")
                                .foregroundColor(.white)
                                .font(.system(size: 10, weight: .thin))
                        )
                }
                
                Spacer()
            }
            .padding(.horizontal,80)
        }
    }
}


struct HomeView: View {
    @State private var devices: [DeviceModel] = []
    @State private var errorMessage: String?
    
    var body: some View {
        NavigationView {
            ZStack {
                Rectangle()
                    .foregroundColor(.buttoncolor)
                    .frame(height: 800)
                    .offset(y: -60)
                
                Image("Character")
                    .resizable()
                    .scaledToFit()
                    .frame(width: 44)
                    .offset(x: -150, y: -350)
                
                ScrollView {
                    Rectangle()
                        .frame(width: 350, height: 200)
                        .foregroundColor(.white)
                        .cornerRadius(15)
                        .padding()
                        .overlay(
                            VStack {
                                HStack {
                                    Image(systemName: "qrcode")
                                        .resizable()
                                        .scaledToFit()
                                        .frame(width: 23)
                                        .padding(5)
                                    Text("도서 대출")
                                        .font(.system(size: 23, weight: .bold))
                                    Spacer()
                                        .frame(width: 150)
                                    NavigationLink(destination: QrView()) {
                                        Image(systemName: "arrow.right")
                                            .resizable()
                                            .scaledToFit()
                                            .foregroundColor(.black)
                                            .frame(width: 20)
                                    }
                                }
                                
                                NavigationLink(destination: BooklistView()) {
                                    Rectangle()
                                        .foregroundColor(.buttoncolor)
                                        .frame(width: 125, height: 35)
                                        .cornerRadius(10)
                                        .overlay(
                                            Text("나의 대출 목록")
                                                .foregroundColor(.black)
                                                .font(.system(size: 17, weight: .semibold))
                                        )
                                }
                                .padding(.leading, 180)
                                
                                VStack(alignment: .leading) {
                                    Text("회원님이 대출중인 책")
                                        .bold()
                                    ScrollView {
                                        VStack(alignment: .leading,spacing: 8) {
                                            Text("미래의 사랑 이야기")
                                                .font(.system(size: 15, weight: .thin))
                                            Text("화를 극복해내는 방법")
                                                .font(.system(size: 15, weight: .thin))
                                        }
                                    }
                                    .frame(height:40)
                                }
                                .offset(x: -80, y: 10)
                                
                            }
                        )
                    
                    Rectangle()
                        .frame(width: 350, height: 420)
                        .foregroundColor(.white)
                        .cornerRadius(15)
                        .overlay(
                            VStack {
                                HStack {
                                    Image(systemName: "printer")
                                        .resizable()
                                        .scaledToFit()
                                        .frame(width: 23)
                                        .padding(5)
                                    Text("기기 대여")
                                        .font(.system(size: 23, weight: .bold))
                                    Spacer()
                                        .frame(width: 150)
                                    
                                    NavigationLink(destination: LendView()) {
                                        Image(systemName: "arrow.right")
                                            .resizable()
                                            .scaledToFit()
                                            .foregroundColor(.black)
                                            .frame(width: 20)
                                    }
                                }
                                
                                ScrollView {
                                    VStack(spacing: 10) {
                                        ForEach(devices) { device in
                                            LendStatusViewModel(device: device)
                                        }
                                    }
                                    .padding()
                                    .offset(x: -90)
                                }
                                .frame(height: 300)
                            }
                        )
                }
                .padding(80)
            }
            .onAppear {
                fetchData()
            }
        }
    }
    
    func fetchData() {
        AF.request(Storage().devicelistapiKey, method: .get).responseJSON { response in
            switch response.result {
            case .success(let value):
                if let json = value as? [String: Any], let dataArray = json["data"] as? [[String: Any]] {
                    var fetchedDevices: [DeviceModel] = []
                    for data in dataArray {
                        if let id = data["id"] as? Int,
                           let status = data["status"] as? Int,
                           let deviceName = data["deviceName"] as? String,
                           let imgUrl = data["imgUrl"] as? String? {
                            let device = DeviceModel(id: id, status: status, deviceName: deviceName, imgUrl: imgUrl)
                            fetchedDevices.append(device)
                        }
                    }
                    devices = fetchedDevices
                }
            case .failure(let error):
                print("네트워크 요청 실패: \(error.localizedDescription)")
                self.errorMessage = "네트워크 요청 실패: \(error.localizedDescription)"
            }
        }
    }
}

// 미리보기
#Preview {
    HomeView()
}

