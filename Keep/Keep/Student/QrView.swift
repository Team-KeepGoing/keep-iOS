//
//  QrView.swift
//  Keep
//
//  Created by bibiga on 4/8/24.
//

import SwiftUI
import CoreImage.CIFilterBuiltins

struct QrView: View {
    
    @State private var qrCodeImage: Image?
    
    var body: some View {
        VStack {
            VStack(alignment: .leading) {
                Text("QR 대여")
                    .font(.system(size: 28, weight: .semibold))
                Spacer()
                    .frame(height:30)
                VStack(alignment: .leading) {
                    Text("도서관에 배치 되어 있는")
                    Text("QR코드 인식기에")
                    Text("QR을 인식해주세요!")
                }
                .font(.system(size: 22, weight: .thin))
            }
            .padding(.trailing, 70)
            
            Spacer()
                .frame(height:50)
            
            VStack {
                if let qrCodeImage = qrCodeImage {
                    qrCodeImage
                        .resizable()
                        .interpolation(.none)
                        .scaledToFit()
                        .frame(width: 200, height: 200)
                } else {
                    Text("QR 코드가 생성되지 않았습니다.")
                }
                
                Button("QR 코드 생성") {
                    if let email = UserDefaults.standard.string(forKey: "email") {
                        generateQRCode(from: email)
                    } else {
                        print("이메일이 저장되어 있지 않습니다.")
                    }
                }
                .padding()
            }
            Spacer()
                .frame(height: 100)
            
        }
    }
    
    func generateQRCode(from string: String) {
        let filter = CIFilter.qrCodeGenerator() // QR 코드 생성 필터 생성
        let data = Data(string.utf8) // 입력된 문자열을 데이터로 변환
        filter.setValue(data, forKey: "inputMessage") // 필터에 데이터를 설정
        
        guard let ciImage = filter.outputImage else { return } // 필터에서 출력된 CIImage 가져오기
        
        let context = CIContext() // CIContext 생성
        guard let cgImage = context.createCGImage(ciImage, from: ciImage.extent) else { return } // CIImage를 CGImage로 변환
        
        let uiImage = UIImage(cgImage: cgImage) // CGImage로부터 UIImage 생성
        qrCodeImage = Image(uiImage: uiImage) // UIImage를 SwiftUI의 Image로 변환하여 저장
    }
}

#Preview {
    QrView()
}
