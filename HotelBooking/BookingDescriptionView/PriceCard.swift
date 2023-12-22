//
//  PriceCard.swift
//  HotelBooking
//
//  Created by Steven Kirke on 20.12.2023.
//

import SwiftUI

/// Карточка стоимости тура
struct PriceCard: View {
	let price: InfoRoom.Price

	var body: some View {
		VStack(alignment: .leading, spacing: 16) {
			LabelForPrice(title: "Тур", text: price.tourPrice)
			LabelForPrice(title: "Топливный сбор", text: price.fuelCharge)
			LabelForPrice(title: "Сервисный сбор", text: price.serviceCharge)
			LabelForPrice(title: "К оплате", text: price.totalPrice, isPay: true)
		}
		.solidBlackground()
	}
}

struct LabelForPrice: View {

	let title: String
	let text: String

	var isPay: Bool = false

	var body: some View {
		HStack(alignment: .top, spacing: 40) {
			Text(title)
				.modifier(HeightModifier(size: 16, lineHeight: 120, weight: .regular))
				.foregroundColor(.customOmbreGray)
				.frame(maxWidth: .infinity, alignment: .leading)
			Text(text)
				.modifier(HeightModifier(
					size: 16,
					lineHeight: 120,
					weight: .semibold
				))
				.foregroundColor(isPay ? .customBlue : .black)
				.frame(maxWidth: .infinity, alignment: .trailing)
		}
	}
}

#if DEBUG
struct PriceCard_Previews: PreviewProvider {
	static var previews: some View {
		BookingView(isMainView: .constant(false))
	}
}
#endif
