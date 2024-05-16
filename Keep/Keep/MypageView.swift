//
//  MypageView.swift
//  Keep
//
//  Created by bibiga on 4/8/24.
//

import SwiftUI

struct MypageView: View {
    var body: some View {
        VStack(alignment: .leading) {
            Text("마이페이지")
                .font(.system(size: 28, weight: .semibold))
            HStack {
                Image(systemName: "person.circle.fill")
                    .resizable()
                    .scaledToFit()
                    .frame(width:112)
                VStack(alignment: .leading, spacing:10) {
                    Text("김주환")
                        .font(.system(size: 24, weight: .semibold))
                    Text("2학년 2반 8번")
                        .font(.system(size: 18, weight: .light))
                    Text("010-3852-4644")
                        .font(.system(size: 18, weight: .light))
                }
            }
        }
    }
}

#Preview {
    MypageView()
}
