//
//  BookingModel.swift
//  HotelBooking
//
//  Created by Steven Kirke on 12.09.2023.
//

import Foundation

// swiftlint:disable nesting
enum InfoRoom {
	struct Responce {
		var responceResult: Result<RoomDescription, Error>
	}

	struct RoomDescription: Codable {
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

	struct DisplayModelBooking {
		var id: Int
		var hotelName: String
		var hotelAdress: String
		var rating: String
		var datas: String
		var departure: String
		var arrivalCountry: String
		var tourDates: String
		var numberOfNights: String
		var room: String
		var nutrition: String
		var pay: String
		var price: Price
	}

	struct Price {
		var tourPrice: String
		var fuelCharge: String
		var serviceCharge: String
		var totalPrice: String
	}
}
// swiftlint:enable nesting
