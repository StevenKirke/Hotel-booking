//
//  CustomTapBar.swift
//  HotelBooking
//
//  Created by Steven Kirke on 05.09.2023.
//

import SwiftUI

struct CustomTapBar: View {

	var text: String = ""
	var action: () -> Void

	var body: some View {
		HStack(alignment: .top, spacing: 0) {
			Button(action: action) {
				Text(text)
					.modifier(HeightModifier(size: 16, lineHeight: 110, weight: .medium))
					.tracking(0.1)
					.foregroundColor(.white)
					.frame(height: 48)
					.frame(maxWidth: .infinity)
					.background(Color.customBlue)
					.cornerRadius(15)
			}
			.padding(.horizontal, 16)
		}
		.padding(.top, 13)
		.frame(maxWidth: .infinity, maxHeight: 88, alignment: .top)
		.background(Color.white)
		.overlay(
			Rectangle()
				.frame(width: nil, height: 1, alignment: .top)
				.foregroundColor(Color.customRed), alignment: .top)
	}
}

#if DEBUG
struct CustomTapBar_Previews: PreviewProvider {
	static var previews: some View {
		CustomTapBar(text: "Text button", action: {})
	}
}
#endif
