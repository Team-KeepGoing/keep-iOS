//
//  testView.swift
//  Keep
//
//  Created by bibiga on 5/14/24.
//

import SwiftUI
import Alamofire

struct testView: View {
    @State private var responseData = ""
    
    var body: some View {
        VStack {
            Text(responseData)
                .padding()
            
            Button("Fetch Data") {
                fetchData()
            }
        }
    }
    
    func fetchData() {
        AF.request("http://3.34.2.12:8080/device/list", method: .get).responseJSON { response in
            switch response.result {
            case .success(let value):
                if let data = try? JSONSerialization.data(withJSONObject: value, options: .prettyPrinted),
                   let jsonString = String(data: data, encoding: .utf8) {
                    self.responseData = jsonString
                    print(responseData)
                } else {
                    self.responseData = "Invalid JSON response"
                }
            case .failure(let error):
                self.responseData = "Error: \(error.localizedDescription)"
            }
        }
    }
}

#Preview {
    testView()
}
