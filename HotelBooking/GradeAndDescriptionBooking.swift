//
//  GradeAndDescriptionBooking.swift
//  HotelBooking
//
//  Created by Steven Kirke on 20.12.2023.
//

import SwiftUI

/// Карточка кнопки рейтинга, названия, адреса и информацией о бронировании
struct GradeAndDescriptionBooking: View {

	var modelBiooking: InfoRoom.DisplayModelBooking

	var body: some View {
		VStack(spacing: 8) {
			HeaderBooking(info: modelBiooking, action: {})
			DescriptionBooking(info: modelBiooking)
		}
	}
}

/// Блок рейтинга комнаты, с названием и адресом
struct HeaderBooking: View {

	var info: InfoRoom.DisplayModelBooking
	var action: () -> Void

	var body: some View {
		VStack(alignment: .leading, spacing: 8) {
			GradeElement(raiting: info.rating)
			Text(info.hotelName)
				.modifier(HeightModifier(size: 22, lineHeight: 120, weight: .medium))
				.lineLimit(2)
				.foregroundColor(.black)
			Button(action: action) {
				Text(info.hotelAdress)
					.modifier(HeightModifier(size: 14, lineHeight: 120, weight: .medium))
					.lineLimit(1)
					.foregroundColor(.customBlue)
			}
			.disabled(true)
		}
		.solidBlackground()
	}
}
