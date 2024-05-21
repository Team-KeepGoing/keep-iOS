//
//  LendView.swift
//  Keep
//
//  Created by bibiga on 4/8/24.
//

import SwiftUI
import Alamofire
import SDWebImageSwiftUI

struct DeviceData: Codable {
    let httpStatus: String
    let message: String
    let data: [Device]
}

struct Device: Codable, Identifiable {
    let id: Int
    let status: Int
    let deviceName: String
    let imgUrl: String?
}

struct LendStatusView: View {
    var device: Device
    
    var body: some View {
        NavigationLink(destination: LendDetailView()) {
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
            }
            .padding(.trailing, 100)
        }
    }
}

struct LendView: View {
    @State private var devices: [Device] = []
    @State private var errorMessage: String?
    
    var body: some View {
        NavigationView {
            VStack {
                Text("기기 대여")
                    .font(.system(size: 28, weight: .bold))
                    .padding(.trailing, 200)
                ScrollView {
                    VStack(alignment: .leading, spacing: 10) {
                        ForEach(devices) { device in
                            LendStatusView(device: device)
                        }
                    }
                    .padding(.trailing, 100)
                }
                .frame(height: 600)
            }
            .navigationBarTitle("")
            .navigationBarHidden(true)
            .onAppear {
                fetchData()
            }
        }
    }
    
    func fetchData() {
        AF.request("http://3.34.2.12:8080/device/list", method: .get).responseJSON { response in
            switch response.result {
            case .success(let value):
                if let json = value as? [String: Any] {
                    // JSON 데이터를 처리합니다.
                    if let dataArray = json["data"] as? [[String: Any]] {
                        // JSON 데이터를 직접 다룹니다.
                        for data in dataArray {
                            if let id = data["id"] as? Int,
                               let status = data["status"] as? Int,
                               let deviceName = data["deviceName"] as? String,
                               let imgUrl = data["imgUrl"] as? String? {
                                // 여기에서 데이터를 처리합니다.
                                let device = Device(id: id, status: status, deviceName: deviceName, imgUrl: imgUrl)
                                devices.append(device)
                            }
                        }
                    }
                }
            case .failure(let error):
                print("Network request failed: \(error.localizedDescription)")
                self.errorMessage = "Network request failed: \(error.localizedDescription)"
            }
        }
    }
}

#Preview {
    LendView()
}

