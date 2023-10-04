//
//  Images.swift
//  HotelBooking
//
//  Created by Steven Kirke on 04.09.2023.
//

import SwiftUI


extension Image {
    
    enum HotelIcons: String {
        case closeSquare
        case emojiHappy
        case tickSquare
    }
    
    enum PaidIcons: String {
        case partyPopper
    }
    
    enum MockIcons: String {
        case hotelImage
        case nomerImage
    }
    

    init(_ name: Image.HotelIcons) {
        self.init(name.path)
    }
    
    init(_ name: Image.PaidIcons) {
        self.init(name.path)
    }
    
    init(_ name: Image.MockIcons) {
        self.init(name.path)
    }
    
    
    static let closeSquare = Image(HotelIcons.closeSquare)
    static let emojiHappy = Image(HotelIcons.emojiHappy)
    static let tickSquare = Image(HotelIcons.tickSquare)
    
    static let partyPopper = Image(PaidIcons.partyPopper)
    
    static let hotelImage = Image(MockIcons.hotelImage)
    static let nomerImage = Image(MockIcons.nomerImage)

}

extension Image.HotelIcons {
    var path: String {
        "Images/Icons/\(rawValue)"
    }
}

extension Image.PaidIcons {
    var path: String {
        "Images/Icons/\(rawValue)"
    }
}

extension Image.MockIcons {
    var path: String {
        "Images/MockImages/\(rawValue)"
    }
}

