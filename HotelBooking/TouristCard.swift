//
//  CardTourist.swift
//  HotelBooking
//
//  Created by Steven Kirke on 11.09.2023.
//

import SwiftUI

struct TouristCard: View {
	let title: String
	var isShowRemove: Bool = false

	@State var isShow: Bool = false
	@State var isEmpty: Bool = false
	@Binding var cardTourist: BuyerInformation.FieldsTouristCard
	@FocusState private var focus: NameFields?

	var remove: () -> Void

	var body: some View {
		VStack(spacing: 0) {
			ShowCardTourist(
				isShow: $isShow,
				title: title,
				isShowRemove: isShowRemove,
				action: { showCart() },
				remove: remove
			)
			.padding(.bottom, isShow ? 17 : 0)

			if self.isShow {
				VStack(spacing: 8) {
					TextFieldForTouristWithPlaceholder(
						placeHolder: cardTourist.firstName.placeholder,
						currentField: .firstName,
						type: .default,
						isEmpty: isEmpty,
						textField: $cardTourist.firstName.text,
						focus: $focus
					)
					TextFieldForTouristWithPlaceholder(
						placeHolder: cardTourist.lastName.placeholder,
						currentField: .lastName,
						type: .default,
						isEmpty: isEmpty,
						textField: $cardTourist.lastName.text,
						focus: $focus
					)
					TextFieldForTourist(
						placeHolder: cardTourist.dateBirth.placeholder,
						currentField: .dateBirth,
						type: .numberPad,
						isEmpty: isEmpty,
						textField: $cardTourist.dateBirth.text,
						focus: $focus
					)
					.onChange(of: cardTourist.dateBirth.text) { value in
						cardTourist.dateBirth.text = value.dataSeparator()
						if value.count > 9 {
							self.checkSubmit()
						}
					}
					TextFieldForTourist(
						placeHolder: cardTourist.citizenShip.placeholder,
						currentField: .citizenShip,
						type: .default,
						isEmpty: isEmpty,
						textField: $cardTourist.citizenShip.text,
						focus: $focus
					)
					TextFieldForTourist(
						placeHolder: cardTourist.numberPassport.placeholder,
						currentField: .numberPassport,
						type: .default,
						isEmpty: isEmpty,
						textField: $cardTourist.numberPassport.text,
						focus: $focus
					)
					TextFieldForTourist(
						placeHolder: cardTourist.validityPeriodPassport.placeholder,
						currentField: .validityPeriodPassport,
						type: .numberPad,
						isEmpty: isEmpty,
						textField: $cardTourist.validityPeriodPassport.text,
						focus: $focus
					)
					.onChange(of: cardTourist.validityPeriodPassport.text) { value in
						cardTourist.validityPeriodPassport.text = value.dataSeparator()
						if value.count > 9 {
							self.checkSubmit()
						}
					}
				}
				.onSubmit {
					self.checkSubmit()
				}
			}
		}
		.padding(.horizontal, 13)
		.vLeading()
		.padding(.vertical, 16)
		.background(Color.white)
		.cornerRadius(15)
		.onTapGesture {
			UIApplication.shared.endEditing()
		}
	}
}

extension TouristCard {

	private func showCart() {
		DispatchQueue.main.async {
			withAnimation(.easeInOut) {
				self.isShow.toggle()
			}
		}
	}

	private func checkSubmit() {
		if cardTourist.firstName.text.isEmpty {
			focus = .firstName
		} else if cardTourist.lastName.text.isEmpty {
			focus = .lastName
		} else if cardTourist.dateBirth.text.isEmpty {
			focus = .dateBirth
		} else if cardTourist.citizenShip.text.isEmpty {
			focus = .citizenShip
		} else if cardTourist.numberPassport.text.isEmpty {
			focus = .numberPassport
		} else if cardTourist.validityPeriodPassport.text.isEmpty {
			focus = .validityPeriodPassport
		} else {
			focus = nil
		}
	}
}

struct TextFieldForTouristWithPlaceholder: View {

	let placeHolder: String
	var currentField: NameFields
	let type: UIKeyboardType
	var isEmpty: Bool
	@Binding var textField: String
	@FocusState.Binding var focus: NameFields?

	var body: some View {
		HStack {
			VStack(alignment: .leading, spacing: 0) {
				Text(placeHolder)
					.modifier(HeightModifier(size: 12, lineHeight: 120, weight: .regular))
					.tracking(0.1)
					.foregroundColor(.customOmbreGray)
				TextField("", text: $textField)
					.focused($focus, equals: currentField)
					.modifier(HeightModifier(size: 16, lineHeight: 110, weight: .regular))
					.tracking(0.075)
					.foregroundColor(.custom14142B)
					.textContentType(.name)
					.tint(Color.black)
					.keyboardType(type)
			}
			Circle()
				.fill(isEmptyField())
				.frame(width: 8, height: 8)
		}
		.vLeadingAndBack(isColor: (self.textField.isEmpty && self.isEmpty) ? false : true)
	}

	private func isEmptyField() -> Color {
		self.isEmpty ? .green : .red
	}
}

struct TextFieldForTourist: View {

	let placeHolder: String
	var currentField: NameFields
	let type: UIKeyboardType
	var isEmpty: Bool
	@Binding var textField: String
	@FocusState.Binding var focus: NameFields?

	var body: some View {
		HStack {
			ZStack(alignment: .leading) {
				if textField.isEmpty {
					Text(placeHolder)
						.modifier(
							HeightModifier(size: 17, lineHeight: 110, weight: .regular)
						)
						.foregroundColor(.customA9ABB7)
				}
				TextField("", text: $textField)
					.focused($focus, equals: currentField)
					.modifier(HeightModifier(size: 17, lineHeight: 110, weight: .regular)
					)
					.tracking(0.1)
					.foregroundColor(.custom14142B)
					.tint(.black)
					.keyboardType(type)
			}
			Circle()
				.fill(isEmptyField())
				.frame(width: 8, height: 8)
		}
		.vLeadingAndBack(isColor: (self.textField.isEmpty && self.isEmpty) ? false : true)
	}

	private func isEmptyField() -> Color {
		self.isEmpty ? .green : .red
	}
}

/// Блок показа полей регистрации туриста
/// - Parameters:
///   - title: String
///   - isShowRemove: Bool Показать / спрятать кнопку 'Удалить туриста'
///   - action: Отображение полей ввода
///   - remove: Удаление замыкающего блока полей ввода
struct ShowCardTourist: View {

	@Binding var isShow: Bool

	var title: String = ""
	var isShowRemove: Bool = false
	var action: () -> Void
	var remove: () -> Void

	var body: some View {
		HStack(spacing: 0) {
			Text(title)
				.modifier(HeightModifier(size: 22, lineHeight: 120, weight: .medium))
				.foregroundColor(.black)
				.frame(maxWidth: .infinity, alignment: .leading)
			HStack(spacing: 10) {
				LittleButtonForCard(image: "chevron.up",
									isShow: isShow,
									action: action)
				if !isShowRemove {
					LittleButtonForCard(image: "trash",
										isShow: nil,
										action: remove)
				}
			}
		}
	}
}

struct LittleButtonForCard: View {

	let image: String
	let isShow: Bool?
	var action: () -> Void

	var body: some View {
		Button(action: action) {
			Image(systemName: image)
				.rotationEffect(.degrees(isShow ?? true ? 0 : 180))
		}
		.font(Font.system(size: 16))
		.frame(width: 32, height: 32)
		.foregroundColor(.customBlue)
		.background(Color.blue10)
		.cornerRadius(6)
	}
}

struct AddCardTourist: View {

	var title: String = ""
	var action: () -> Void

	var body: some View {
		HStack(spacing: 0) {
			Text(title)
				.modifier(HeightModifier(size: 22, lineHeight: 120, weight: .medium))
				.foregroundColor(.black)
				.frame(maxWidth: .infinity, alignment: .leading)
			Button(action: action) {
				Image(systemName: "plus")
			}
			.font(Font.system(size: 16))
			.frame(width: 32, height: 32)
			.foregroundColor(.white)
			.background(Color.customBlue)
			.cornerRadius(6)
		}
		.solidBlackground()
	}
}

#if DEBUG
struct CardTourist_Previews: PreviewProvider {
	static var previews: some View {
		BookingView(isMainView: .constant(false))
	}
}
#endif
