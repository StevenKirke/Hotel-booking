//
//  HotelModel.swift
//  HotelBooking
//
//  Created by Steven Kirke on 08.09.2023.
//

import Foundation

// swiftlint:disable nesting
enum HotelModelEnum {
	///  Структура получаемых данных из сетевого запроса или Mock файла
	struct Responce {
		var responceResult: Result<HotelModel, Error>

		struct HotelModel: Codable {
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
	}
	///  Структура для отображение данныхх во View
	struct DisplayModelHotel {
		var id: Int
		var name: String
		var adress: String
		var cropAdress: String
		var minimalPrice: String
		var raiting: String
		var priceForIt: String
		var imageURL: [String]
		let aboutTheHotel: DisplayAboutHotel

		struct DisplayAboutHotel {
			var description: String
			var peculiarities: [String]
		}
	}
}
// swiftlint:enable nesting

struct HotelModel: Codable {
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

struct HotelTitle {
	var id: Int
	var name: String
	var adress: String
	var minimalPrice: String
	var raiting: String
	var priceForIt: String
	var images: [String]
}

struct AboutTheHotel: Codable {
    var description: String
    var peculiarities: [String]
}

struct DisplayModelHotel {
	var id: Int
	var name: String
	var adress: String
	var minimalPrice: String
	var raiting: String
	var priceForIt: String
	var imageURL: [String]
	let aboutTheHotel: DisplayAboutHotel

	struct DisplayAboutHotel {
		var description: String
		var peculiarities: [String]
	}
}
