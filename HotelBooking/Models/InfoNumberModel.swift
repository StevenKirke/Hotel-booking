//
//  InfoNumberModel.swift
//  HotelBooking
//
//  Created by Steven Kirke on 12.09.2023.
//

import Foundation



struct InfoMumber: Codable {
    var id: Int
    var hotelName: String
    var hotelAdress: String
    var horating: Int
    var ratingName: String
    var departure: String
    var arrivalCountry: String
    var tourDateStart: String
    var tourDateStop: String
    var numberOfNights: Int
    var room, nutrition: String
    var tourPrice: Int
    var fuelCharge: Int
    var serviceCharge: Int

    enum CodingKeys: String, CodingKey {
        case id
        case hotelName = "hotel_name"
        case hotelAdress = "hotel_adress"
        case horating
        case ratingName = "rating_name"
        case departure
        case arrivalCountry = "arrival_country"
        case tourDateStart = "tour_date_start"
        case tourDateStop = "tour_date_stop"
        case numberOfNights = "number_of_nights"
        case room, nutrition
        case tourPrice = "tour_price"
        case fuelCharge = "fuel_charge"
        case serviceCharge = "service_charge"
    }
}
