//
//  Urls.swift
//  HotelBooking
//
//  Created by Steven Kirke on 08.09.2023.
//

import Foundation

enum URLs {
	case hotel
	case nomer
	case paid

	var url: String {
		switch self {
		case .hotel:
			return "https://run.mocky.io/v3/35e0d18e-2521-4f1b-a575-f0fe366f66e3"
		case .nomer:
			return "https://run.mocky.io/v3/f9a38183-6f95-43aa-853a-9c83cbb05ecd"
		case .paid:
			return "https://run.mocky.io/v3/e8868481-743f-4eb2-a0d7-2bc4012275c8"
		}
	}
}
