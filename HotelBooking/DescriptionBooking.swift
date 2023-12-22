//
//  DescriptionBooking.swift
//  HotelBooking
//
//  Created by Steven Kirke on 20.12.2023.
//

import SwiftUI

/// Карточка информации о бронированни
struct DescriptionBooking: View {
	let info: InfoRoom.DisplayModelBooking

	var body: some View {
		VStack(alignment: .leading, spacing: 16) {
			LabelForInfo(title: "Вылет из", text: info.departure)
			LabelForInfo(title: "Страна, город", text: info.arrivalCountry)
			LabelForInfo(title: "Даты", text: info.datas)
			LabelForInfo(title: "Кол-во ночей", text: info.numberOfNights)
			LabelForInfo(title: "Отель", text: info.hotelName)
			LabelForInfo(title: "Номер", text: info.room)
			LabelForInfo(title: "Питание", text: info.nutrition)
		}
		.solidBlackground()
	}
}

private struct LabelForInfo: View {

	let title: String
	let text: String

	var body: some View {
		HStack(alignment: .top, spacing: 40) {
			Text(title)
				.modifier(HeightModifier(size: 16, lineHeight: 120, weight: .regular))
				.foregroundColor(.customOmbreGray)
				.fixedSize()
				.frame(width: 100, alignment: .leading)
			Text(text)
				.modifier(HeightModifier(size: 16, lineHeight: 120, weight: .regular))
				.foregroundColor(.black)
		}
	}
}
