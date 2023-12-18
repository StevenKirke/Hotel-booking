//
//  CustomTapBar.swift
//  HotelBooking
//
//  Created by Steven Kirke on 05.09.2023.
//

import SwiftUI

///  'CustomTapBar' Преназнаен для отображении кнопки в нижней части экрана
/// - Parameters:
/// 	- label: String, для передает название кнопки
/// 	- action: Функция для навигации
/// - Returns: Возвращает блок навигации с текстом и кнопкой для перехода на следующий экрна
struct CustomTapBar: View {

	var label: String = ""
	var action: () -> Void

	var body: some View {
		HStack(alignment: .top, spacing: 0) {
			Button(action: action) {
				Text(label)
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
				.foregroundColor(Color.grayE8E9EC), alignment: .top)
	}
}

#if DEBUG
struct CustomTapBar_Previews: PreviewProvider {
	static var previews: some View {
		CustomTapBar(label: "Text button", action: {})
	}
}
#endif
