//
//  LendDetailView.swift
//  Keep
//
//  Created by bibiga on 4/15/24.
//

import SwiftUI
import Alamofire

struct LendDetailView: View {
    @State private var status: Int = 0

    var body: some View {
        VStack {
            Text("기기 대여")
                .font(.system(size: 28, weight: .semibold))
                .offset(x: -100, y: -90)
            VStack(spacing: 10) {
                Image("macbook")
                    .resizable()
                    .scaledToFit()
                    .frame(width: 200)
                Text("노트북")
                    .font(.system(size: 27, weight: .semibold))

                Spacer()
                    .frame(height: 120)

                Rectangle()
                    .frame(width: 230, height: 45)
                    .cornerRadius(12)
                    .foregroundColor(status == 2 ? .red : .blue)
                    .overlay(
                        Text(status == 2 ? "사용중" : "미사용")
                            .font(.system(size: 19, weight: .medium))
                            .foregroundColor(.white)
                    )
            }
            .padding()
        }
        .onAppear(perform: fetchStatus)
    }

    func fetchStatus() {
        AF.request(Storage().devicelistapiKey).responseJSON { response in
            switch response.result {
            case .success(let value):
                print("Response JSON: \(value)")
                if let json = value as? [String: Any], let data = json["data"] as? [[String: Any]], let firstDevice = data.first, let status = firstDevice["status"] as? Int {
                    DispatchQueue.main.async {
                        self.status = status
                    }
                } else {
                    DispatchQueue.main.async {
                        self.status = 0
                    }
                }
            case .failure(let error):
                DispatchQueue.main.async {
                    self.status = -1
                }
                print("Error: \(error.localizedDescription)")
            }
        }
    }
}

#Preview {
    LendDetailView()
}

