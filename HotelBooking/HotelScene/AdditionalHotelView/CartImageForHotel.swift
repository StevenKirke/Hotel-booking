//
//  CartImageForHotel.swift
//  HotelBooking
//
//  Created by Steven Kirke on 17.12.2023.
//

import SwiftUI

struct CartImageForHotel: View {

	@Binding var currentIndex: Int

	var image: String = ""
	let index: Int

	private let width = UIScreen.main.bounds.width - 32
	private var height: CGFloat {
		CGFloat(Int(width * (1 - 25 / 100)))
	}

	var body: some View {
		CustomImage(image: image)
			.frame(width: width, height: height)
			.id("\(index)")
			.mask({
				RoundedRectangle(cornerRadius: 15)
			})
	}
}
