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
    let status: String
    let deviceName: String
    let imgUrl: String?
    
    var isAvailable: Bool {
        return status == "AVAILABLE"
    }
    
    var isRented: Bool {
        return status == "RENTED"
    }
    
    var isUnavailable: Bool {
        return status == "UNAVAILABLE"
    }
}

struct LendStatusView: View {
    var device: Device
    
    var body: some View {
        VStack {
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
                    Spacer()
                        .frame(width:20)
                    VStack(alignment: .leading, spacing: 3) {
                        Text(device.deviceName)
                            .font(.system(size: 20, weight: .bold))
                            .foregroundColor(.black)
                        
                        Rectangle()
                            .frame(width: 45, height: 15)
                            .cornerRadius(7)
                            .foregroundColor(device.isRented ? .red : (device.isUnavailable ? .unavcolor : .blue))
                            .overlay(
                                Text(device.isRented ? "사용중" : (device.isUnavailable ? "대여불가" : "대여가능"))
                                    .foregroundColor(.white)
                                    .font(.system(size: 10, weight: .thin))
                            )
                    }
                    
                    Spacer()
                }
                .padding(.leading, 40)
            }
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
        AF.request(Storage().devicelistapiKey, method: .get).responseJSON { response in
            switch response.result {
            case .success(let value):
                if let json = value as? [String: Any], let dataArray = json["data"] as? [[String: Any]] {
                    var fetchedDevices = [Device]()
                    for data in dataArray {
                        if let id = data["id"] as? Int,
                           let status = data["status"] as? String, // status를 String으로 처리
                           let deviceName = data["deviceName"] as? String,
                           let imgUrl = data["imgUrl"] as? String? {
                            let device = Device(id: id, status: status, deviceName: deviceName, imgUrl: imgUrl)
                            fetchedDevices.append(device)
                        }
                    }
                    DispatchQueue.main.async {
                        self.devices = fetchedDevices
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


