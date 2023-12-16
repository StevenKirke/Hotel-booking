//
//  RangeServicesButtons.swift
//  HotelBooking
//
//  Created by Steven Kirke on 05.09.2023.
//

import SwiftUI

enum RangeServicesButtons: Int, CaseIterable {
	case facilities
	case included
	case notIncluded
}

extension RangeServicesButtons {

	var title: String {
		switch self {
		case .facilities:
			return "Удобства"
		case .included:
			return "Что включено"
		case .notIncluded:
			return "Что не включено"
		}
	}

	var discription: String {
		switch self {
		case .facilities:
			return "Самое необходимое"
		case .included:
			return "Самое необходимое"
		case .notIncluded:
			return "Самое необходимое"
		}
	}

	var image: Image {
		switch self {
		case .facilities:
			return .emojiHappy
		case .included:
			return .tickSquare
		case .notIncluded:
			return .closeSquare
		}
	}
}
