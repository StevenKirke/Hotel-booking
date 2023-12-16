//
//  LittleButtom.swift
//  HotelBooking
//
//  Created by Steven Kirke on 08.11.2023.
//

import SwiftUI

struct LittleButtom: View {

	let image: String
	var action: () -> Void

	var body: some View {
		Button(action: action) {
			Image(systemName: image)
		}
		.font(Font.system(size: 16))
		.frame(width: 32, height: 32)
		.foregroundColor(.white)
		.background(Color.customBlue)
		.cornerRadius(6)
	}
}

#if DEBUG
struct LittleButtom_Previews: PreviewProvider {
	static var previews: some View {
		LittleButtom(image: "plus", action: {})
	}
}
#endif
