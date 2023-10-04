//
//  HotelModel.swift
//  HotelBooking
//
//  Created by Steven Kirke on 08.09.2023.
//

import Foundation


struct HotelTitle {
    var id: Int
    var name: String
    var adress: String
    var minimalPrice: String
    var raiting: String
    var priceForIt: String
    var images: [String]
}

struct Hotels: Codable {
    let id: Int
    let name: String
    let adress: String
    let minimalPrice: Int
    let priceForIt: String
    let rating: Int
    let ratingName: String
    let imageUrls: [String]
    let aboutTheHotel: AboutTheHotel

    enum CodingKeys: String, CodingKey {
        case id, name, adress
        case minimalPrice = "minimal_price"
        case priceForIt = "price_for_it"
        case rating
        case ratingName = "rating_name"
        case imageUrls = "image_urls"
        case aboutTheHotel = "about_the_hotel"
    }
}

struct AboutTheHotel: Codable {
    var description: String
    var peculiarities: [String]
}


