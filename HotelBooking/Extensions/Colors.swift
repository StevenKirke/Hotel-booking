//
//  Colors.swift
//  HotelBooking
//
//  Created by Steven Kirke on 04.09.2023.
//

import SwiftUI

extension Color {
    enum Name: String {
        case c_000000_90
        case c_000000_22
        case c_000000_17
        case c_000000_10
        case c_000000_5
        case c_0D72FF
        case c_0D72FF_10
        case c_2C3035
        case c_828796
        case c_828796_15
        case c_A9ABB7
        case c_D8D8D8
        case c_E8E9EC
        case c_F6F6F9
        case c_FBFBFC
        case c_FFA800
        case c_FFC700_20
        case c_EB5757_15
        case c_14142B
    }
    
    init(_ name: Color.Name) {
        self.init(name.path)
    }
    
    static let c_000000_90 = Color(Name.c_000000_90)
    static let c_000000_22 = Color(Name.c_000000_22)
    static let c_000000_17 = Color(Name.c_000000_17)
    static let c_000000_10 = Color(Name.c_000000_10)
    static let c_000000_5 = Color(Name.c_000000_5)
    
    static let c_0D72FF = Color(Name.c_0D72FF)
    static let c_0D72FF_10 = Color(Name.c_0D72FF_10)
    
    static let c_2C3035 = Color(Name.c_2C3035)
    static let c_A9ABB7 = Color(Name.c_A9ABB7)
    static let c_D8D8D8 = Color(Name.c_D8D8D8)
    static let c_E8E9EC = Color(Name.c_E8E9EC)
    static let c_F6F6F9 = Color(Name.c_F6F6F9)
    static let c_FBFBFC = Color(Name.c_FBFBFC)
    
    static let c_828796 = Color(Name.c_828796)
    static let c_828796_15 = Color(Name.c_828796_15)
    
    static let c_FFA800 = Color(Name.c_FFA800)
    static let c_FFC700_20 = Color(Name.c_FFC700_20)
    
    static let c_EB5757_15 = Color(Name.c_EB5757_15)
    
    static let c_14142B = Color(Name.c_14142B)
    
}

extension Color.Name {
    var path: String {
        "Colors/\(rawValue)"
    }
}
