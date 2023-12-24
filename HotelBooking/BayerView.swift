//
//  BayerView.swift
//  HotelBooking
//
//  Created by Steven Kirke on 21.12.2023.
//

import SwiftUI

/// Блок показа текстовых полей регистрации туриста
/// - Note: Блок включает в себя информацию о покупателе ``BayerInformationView``
///	  Список блоков полей ввода регистрации ``TouristCard``
///	  блок оплаты с кнопкой оплатить ``AddCardTourist``
struct BayerView: View {

	@ObservedObject var bayerVm: BayerInformationModel = BayerInformationModel(
		contactService: ContactManager(),
		phoneMaskManagers: PhoneMaskManager(),
		emailManagers: EmailValidationManager()
	)

	var body: some View {
		VStack {
			BayerInformationView(action: {})
			ForEach(bayerVm.touristList.indices, id: \.self) { index in
				let isExpandCard = index == 0 ? true : false
				let isShowButtomRemove = index == bayerVm.touristList.count - 1 && index != 0 ? false : true
				TouristCard(
					title: bayerVm.assambleTitle(index: index),
					isShowRemove: isShowButtomRemove,
					isShow: isExpandCard,
					cardTourist: $bayerVm.touristList[index]) { remove() }
			}
			if bayerVm.touristList.count < 6 {
				AddCardTourist(title: "Добавить туриста", action: {
					addTourist(index: bayerVm.touristList.count)
				})
			}
			Button {
				bayerVm.answerInEmptyField()
			} label: {
				Text("Answer Field")
			}

		}
	}

	private func addTourist(index: Int) {
		bayerVm.addTouristInCard(index: index)
	}

	private func remove() {
		bayerVm.removeLastTourist()
	}
}
