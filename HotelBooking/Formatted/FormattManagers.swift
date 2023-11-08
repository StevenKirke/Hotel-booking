//
//  FormattManagers.swift
//  HotelBooking
//
//  Created by Steven Kirke on 31.10.2023.
//

import Foundation


struct PhoneMumberFormatted {

	var phoneNumber: String

	mutating func formatPhoneMumberDateString() {
		if phoneNumber.count <= 18 {
			let removeNonNuneric = phoneNumber.removeNonNum()
			let convert = removeNonNuneric.formatMaskPhone(.mobile)
			let crop = String(convert.prefix(18))
			phoneNumber = crop
		}
		if phoneNumber.count > 18 {
			phoneNumber.removeLast()
		}
	}
}
