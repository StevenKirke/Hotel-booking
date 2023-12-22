//
//  TourisеModel.swift
//  HotelBooking
//
//  Created by Steven Kirke on 12.09.2023.
//

import Foundation

enum BuyerInformation {

	struct DispayModelBuyer {
		var contact: [Contact]
	}

	struct Contact {
		let name: String
		let number: String
		let mask: String
	}
}

struct TouristData: Codable {
	var eMail: String
	var numberPhone: String
	var tourists: [Tourist]

	enum CodingKeys: String, CodingKey {
		case eMail = "e_mail"
		case numberPhone = "number_phone"
		case tourists
	}
}

struct Tourist: Codable {
	var touristNumber: String
	var isShow: Bool
	var fields: [Field]

	enum CodingKeys: String, CodingKey {
		case touristNumber = "tourist_number"
		case isShow = "is_show"
		case fields
	}
}

struct Field: Codable {
	var name: String
	var meaning: String
	var isEmpty: Bool
	var pleaceHolder: String

	enum CodingKeys: String, CodingKey {
		case name, meaning
		case isEmpty = "is_empty"
		case pleaceHolder = "pleace_holder"
	}
}
