//
//  RoomModel.swift
//  HotelBooking
//
//  Created by Steven Kirke on 10.09.2023.
//

import Foundation

// swiftlint:disable nesting
enum RoomModel {

	struct Responce {
		var responceResult: Result<[Rooms], Error>
	}

	struct Rooms: Codable {
		let rooms: [Room]
	}

	struct Room: Codable {
		let id: Int
		let name: String
		let price: Int
		let pricePer: String
		let peculiarities: [String]
		let imageUrls: [String]

		enum CodingKeys: String, CodingKey {
			case id, name, price
			case pricePer = "price_per"
			case peculiarities
			case imageUrls = "image_urls"
		}
	}

	struct DisplayModelRoom {
		let id: Int
		let name: String
		let price: String
		let pricePer: String
		let peculiarities: [String]
		let images: [String]
	}
}
