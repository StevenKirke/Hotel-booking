//
//  Urls.swift
//  HotelBooking
//
//  Created by Steven Kirke on 08.09.2023.
//

import Foundation

enum URLs {
	case hotel
	case rooms
	case paid

	var url: String {
		switch self {
		case .hotel:
			return "https://run.mocky.io/v3/d144777c-a67f-4e35-867a-cacc3b827473"
		case .rooms:
			return "https://run.mocky.io/v3/8b532701-709e-4194-a41c-1a903af00195"
		case .paid:
			return "https://run.mocky.io/v3/63866c74-d593-432c-af8e-f279d1a8d2ff"
		}
	}
}
