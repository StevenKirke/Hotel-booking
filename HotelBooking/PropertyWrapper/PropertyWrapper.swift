//
//  PropertyWrapper.swift
//  HotelBooking
//
//  Created by Steven Kirke on 02.10.2023.
//

import SwiftUI

@propertyWrapper
struct DateFormatted {

	private var birthDate: String

	init(wrappedValue: String) {
		birthDate = wrappedValue
	}

	var wrappedValue: String {
		get {
			birthDate
		} set(value) {
			let divider: Character = "."
			birthDate = value

			if value.count == 3 {
				let startIndex = value.startIndex
				let thirdPosition = value.index(startIndex, offsetBy: 2)
				let thirdPositionChar = value[thirdPosition]
				if thirdPositionChar != divider {
					birthDate.insert(divider, at: thirdPosition)
				}
			}

			if value.count == 6 {
				let startIndex = value.startIndex
				let sixthPosition = value.index(startIndex, offsetBy: 5)
				let sixthPositionChar = value[sixthPosition]
				if sixthPositionChar != divider {
					birthDate.insert(divider, at: sixthPosition)
				}
			}
			if value.last == divider {
				birthDate.removeLast()
			}
			birthDate = String(birthDate.prefix(10))
		}
	}
}
