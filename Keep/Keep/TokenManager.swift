//
//  TokenManager.swift
//  Keep
//
//  Created by bibiga on 5/23/24.
//

import Foundation
import SwiftUI

class TokenManager: ObservableObject {
    static let shared = TokenManager()
    private let userDefaults = UserDefaults.standard

    @Published var token: String? {
        didSet {
            userDefaults.set(token, forKey: "token")
        }
    }

    private init() {
        self.token = userDefaults.string(forKey: "token")
    }
}
