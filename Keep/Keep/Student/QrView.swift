//
//  QrView.swift
//  Keep
//
//  Created by bibiga on 4/8/24.
//

import SwiftUI

struct QrView: View {
    var body: some View {
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
    }
}

#Preview {
    QrView()
}
