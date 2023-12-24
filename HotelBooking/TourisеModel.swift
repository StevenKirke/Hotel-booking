//
//  TourisеModel.swift
//  HotelBooking
//
//  Created by Steven Kirke on 12.09.2023.
//

import Foundation
// swiftlint:disable nesting
enum BuyerInformation {

	struct TouristCard {
		var phone: String
		var eMail: String
		var tuorists: [FieldsTouristCard]
	}

	struct FieldsTouristCard {
		var firstName: FieldSave
		var lastName: FieldSave
		var dateBirth: FieldSave
		var citizenShip: FieldSave
		var numberPassport: FieldSave
		var validityPeriodPassport: FieldSave
	}

	struct FieldSave {
		var text: String
		var placeholder: String
		var isEmpty: Bool {
			!text.isEmpty ? true : false
		}
	}

	struct DispayModelBuyer {
		var contact: [Contact]
	}

	struct Contact {
		let name: String
		let number: String
		let mask: String
	}
}
// swiftlint:enable nesting
