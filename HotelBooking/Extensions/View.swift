//
//  View.swift
//  HotelBooking
//
//  Created by Steven Kirke on 11.09.2023.
//

import SwiftUI

extension View {
	func vLeading() -> some View {
		self.frame(maxWidth: .infinity, alignment: .leading)
	}

	func vLeadingAndBack(_ isColor: Bool) -> some View {
		self
			.padding(.horizontal, 16)
			.frame(maxWidth: .infinity, alignment: .leading)
			.frame(height: 52)
			.background(isColor ? Color.ColorF6F6F9 : Color.customRed15)
			.cornerRadius(10)
	}

	func solidBlackground() -> some View {
		self
			.padding(.horizontal, 16)
			.frame(maxWidth: .infinity, alignment: .leading)
			.padding(.vertical, 16)
			.background(Color.white)
			.cornerRadius(15)
	}
}
