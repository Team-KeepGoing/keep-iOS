//
//  ColorExtension.swift
//  Keep
//
//  Created by bibiga on 3/14/24.
//

import SwiftUI

extension Color {
  init(hex: String) {
    let scanner = Scanner(string: hex)
    _ = scanner.scanString("#")
    
    var rgb: UInt64 = 0
    scanner.scanHexInt64(&rgb)
    
    let r = Double((rgb >> 16) & 0xFF) / 255.0
    let g = Double((rgb >>  8) & 0xFF) / 255.0
    let b = Double((rgb >>  0) & 0xFF) / 255.0
    self.init(red: r, green: g, blue: b)
  }
}

extension Color {
    static let keepcolor = Color(hex: "25357E")
    static let buttoncolor = Color(hex: "F2F3F5")
    static let selbutton = Color(hex: "181F29")
    static let lendbutton = Color(hex: "3182F7")
    static let unavcolor = Color(hex: "4D5967")
}
