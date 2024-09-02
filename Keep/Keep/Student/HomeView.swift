//
//  HomeView.swift
//  Keep
//
//  Created by bibiga on 4/4/24.
//
import SwiftUI
import Alamofire
import SDWebImageSwiftUI

struct BorrowedBookModel: Identifiable {
    let id: Int
    let bookName: String
    let imageUrl: String?
    let rentDate: String
    let state: String
}

struct DeviceModel: Identifiable, Codable {
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

struct LendStatusViewModel: View {
    var device: DeviceModel
    
    var body: some View {
        NavigationLink(destination: LendDetailView(deviceName: device.deviceName, imgUrl: device.imgUrl, status: device.status)) {
            HStack {
                if let imgUrl = device.imgUrl, let url = URL(string: imgUrl) {
                    WebImage(url: url)
                        .resizable()
                        .frame(width: 64, height: 64)
                        .cornerRadius(50)
                } else {
                    Image("placeholder")
                        .resizable()
                        .frame(width: 64, height: 64)
                        .cornerRadius(50)
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
            .padding(.leading, 100)
        }
    }
}

struct HomeView: View {
    @State private var borrowedBooks: [BorrowedBookModel] = []
    @State private var devices: [DeviceModel] = []
    @State private var errorMessage: String?
    @State private var showLateWarning = false
    
    var body: some View {
        NavigationView {
            VStack {
                ZStack {
                    Rectangle()
                        .foregroundColor(.buttoncolor)
                        .frame(height: 800)
                        .offset(y: -60)
                    
                    Image("Logo")
                        .resizable()
                        .scaledToFit()
                        .frame(width: 116,height:57)
                        .offset(x: -110, y: -300)
                    
                    
                    VStack(spacing: 0) {
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
                                            VStack(alignment: .leading, spacing: 8) {
                                                ForEach(borrowedBooks) { book in
                                                    Text(book.bookName)
                                                        .font(.system(size: 15, weight: .thin))
                                                }
                                            }
                                        }
                                        .frame(height: 40)
                                    }
                                    .offset(x: -80, y: 10)
                                    
                                }
                            )
                        
                        Rectangle()
                            .frame(width: 350, height: 370)
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
                                    .offset(y:15)
                                    
                                    ScrollView {
                                        VStack(spacing: 10) {
                                            ForEach(devices) { device in
                                                LendStatusViewModel(device: device)
                                            }
                                        }
                                        .padding()
                                        .offset(x: -90,y:10)
                                    }
                                    .frame(height: 300)
                                }
                            )
                    }
                    .padding(80)
                    .offset(y:20)
                }
                .onAppear {
                    fetchData()
                    checkLateReturns()
                    showLateWarning = true
                }
            }
            .alert(isPresented: $showLateWarning) {
                Alert(
                    title: Text("경고"),
                    message: Text("반납이 지연된 책이 있습니다."),
                    dismissButton: .default(Text("확인"))
                )
            }
        }
    }
    
    func fetchData() {
        guard let token = TokenManager.shared.token else {
            self.errorMessage = "토큰이 없습니다."
            return
        }
        
        AF.request(Storage().devicelistapiKey, method: .get).responseJSON { response in
            switch response.result {
            case .success(let value):
                print("Device List API Response: \(value)")
                if let json = value as? [String: Any], let dataArray = json["data"] as? [[String: Any]] {
                    var fetchedDevices: [DeviceModel] = []
                    for data in dataArray {
                        if let id = data["id"] as? Int,
                           let status = data["status"] as? String,
                           let deviceName = data["deviceName"] as? String,
                           let imgUrl = data["imgUrl"] as? String? {
                            let device = DeviceModel(id: id, status: status, deviceName: deviceName, imgUrl: imgUrl)
                            fetchedDevices.append(device)
                        }
                    }
                    devices = fetchedDevices
                }
            case .failure(let error):
                print("Device List API Error: \(error.localizedDescription)")
                self.errorMessage = "Device List API Error: \(error.localizedDescription)"
            }
        }
        
        AF.request(Storage().userinfoapiKey, method: .get, headers: ["Authorization": "Bearer \(token)"]).responseData { response in
            switch response.result {
            case .success(let data):
                print("User Info API Response: \(String(data: data, encoding: .utf8) ?? "")")
                do {
                    let userInfoResponse = try JSONDecoder().decode(UserInfoResponse.self, from: data)
                    DispatchQueue.main.async {
                        self.borrowedBooks = userInfoResponse.borrowedBooks.map {
                            BorrowedBookModel(id: $0.id, bookName: $0.bookName, imageUrl: $0.imageUrl, rentDate: $0.rentDate, state: $0.state)
                        }
                    }
                } catch {
                    print("JSON decoding error: \(error.localizedDescription)")
                    self.errorMessage = "JSON decoding error: \(error.localizedDescription)"
                }
            case .failure(let error):
                print("User Info API Error: \(error.localizedDescription)")
                self.errorMessage = "User Info API Error: \(error.localizedDescription)"
            }
        }
    }
    func checkLateReturns() {
        if borrowedBooks.contains(where: { $0.state == "Late" }) {
            showLateWarning = true
        }
    }
}

#Preview {
    HomeView()
}
