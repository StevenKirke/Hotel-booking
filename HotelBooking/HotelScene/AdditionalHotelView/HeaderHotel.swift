//
//  CardHotel.swift
//  HotelBooking
//
//  Created by Steven Kirke on 05.09.2023.
//

import SwiftUI

typealias HeaderDisplayModel = HotelModelEnum.DisplayModelHotel

/// Кaрточка отеля с каруселью картинок и описанием отеля
/// - Parameters:
/// 	- headerHotel: 'HotelModelEnum.DisplayModelHotel'
struct HeaderHotel: View {

	@State var headerHotel: HeaderDisplayModel

	var body: some View {
		VStack(spacing: 16) {
			CarouselImages(images: headerHotel.imageURL)
			HeaderWithGrade(hotel: headerHotel, action: {})
		}
		.padding(.vertical, 16)
		.background(
			RoundedCornersShape(corners: [.bottomLeft, .bottomRight], radius: 12)
				.fill(Color.white)
		)
	}
}

#if DEBUG
struct CardHotel_Previews: PreviewProvider {
	static var previews: some View {
		HotelView()
	}
}
#endif
