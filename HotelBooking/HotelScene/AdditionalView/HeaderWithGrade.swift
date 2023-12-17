//
//  HeaderWithGrade.swift
//  HotelBooking
//
//  Created by Steven Kirke on 17.12.2023.
//

import SwiftUI

/// Крточка названия отеля с адресом и ценой
/// - Parameters:
/// 	- hotel: 'HotelModelEnum.DisplayModelHotel'
/// 	- action: Функция для увеличения текущего рейтинга отеля
/// - Note: Возврашает блок 'View' с описанием и ценой отеля и кнопкой оценки
/// 		Дейсвие кнопки заблокировано!
struct HeaderWithGrade: View {

	var hotel: HeaderDisplayModel
	var action: () -> Void

	var body: some View {
		VStack(alignment: .leading, spacing: 8) {
			GradeElement(raiting: hotel.raiting)
			Text(hotel.name)
				.modifier(HeightModifier(size: 22, lineHeight: 120, weight: .medium))
				.lineLimit(2)
				.foregroundColor(.black)
			Button(action: action) {
				Text(hotel.adress)
					.modifier(HeightModifier(size: 14, lineHeight: 120, weight: .medium))
					.lineLimit(1)
					.foregroundColor(.customBlue)
			}
			.disabled(true)
			HStack(alignment: .firstTextBaseline, spacing: 8) {
				Text(hotel.minimalPrice)
					.modifier(HeightModifier(size: 30, lineHeight: 120, weight: .semibold))
					.foregroundColor(.black)
				Text(hotel.priceForIt)
					.modifier(HeightModifier(size: 16, lineHeight: 120, weight: .regular))
					.foregroundColor(.customOmbreGray)
			}
			.padding(.top, 8)
		}
		.frame(maxWidth: .infinity, alignment: .leading)
		.padding(.horizontal, 16)
	}
}
