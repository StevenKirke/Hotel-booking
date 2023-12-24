//
//  BayerInformationView.swift
//  HotelBooking
//
//  Created by Steven Kirke on 20.12.2023.
//

import SwiftUI

/// Карточка 'Информация о покупателе'
/// - Note: Блок включает в себя описание, поля ввода почты и телефонного номера,
///	кнопку показа списка контактов
struct BayerInformationView: View {

	@ObservedObject var bayerVM: BayerInformationModel = BayerInformationModel(
		contactService: ContactManager(),
		phoneMaskManagers: PhoneMaskManager(),
		emailManagers: EmailValidationManager()
	)

	@FocusState private var focus: NameFields?

	var action: () -> Void

	var body: some View {
		return VStack(alignment: .leading, spacing: 8) {
			Text("Информация о покупателе")
				.modifier(HeightModifier(size: 22, lineHeight: 120, weight: .medium))
				.foregroundColor(.black)
				.padding(.bottom, 12)
			ZStack(alignment: .trailing) {
				TextFieldForTouristWithPlaceholder(
					placeHolder: "Номер телефона",
					currentField: .phone,
					type: .phonePad,
					isEmpty: false,
					textField: $bayerVM.phone,
					focus: $focus
				)
				.onChange(of: bayerVM.phone) { value in
					bayerVM.changePhone(phone: value)
					if value.count > 18 {
						UIApplication.shared.endEditing()
					}
				}
				Button(action: { contactView() }, label: {
					Image(systemName: "list.bullet")
						.resizable()
						.frame(width: 20, height: 20)
				})
				.padding(.trailing, 10)
			}
			VStack(spacing: 4) {
				TextFieldForTouristWithPlaceholder(
					placeHolder: "Почта",
					currentField: .eMail,
					type: .emailAddress,
					isEmpty: false,
					textField: $bayerVM.eMail,
					focus: $focus
				)
				.onChange(of: bayerVM.eMail) { value in
					DispatchQueue.main.async {
						withAnimation(.linear(duration: 1)) {
							bayerVM.validationEmail(email: value)
						}
					}
				}
				if !bayerVM.isValidEmail && !bayerVM.eMail.isEmpty {
					IsValidEMail()
				}
			}
			Text("Эти данные никому не передаются. После оплаты мы вышли чек на указанный вами номер и почту")
				.modifier(HeightModifier(size: 14, lineHeight: 120, weight: .regular))
				.foregroundColor(.customOmbreGray)
		}
		.solidBlackground()
		.sheet(isPresented: $bayerVM.isShowContact, content: {
			ContactsView(
				contactList: bayerVM.contactList,
				phone: $bayerVM.phone,
				isShowContact: $bayerVM.isShowContact
			)
		})
	}

	private func contactView() {
		DispatchQueue.main.async {
			bayerVM.fetchContactList()
		}
	}
}

private struct IsValidEMail: View {
	var body: some View {
		HStack(spacing: 5) {
			Image(systemName: "asterisk")
				.font(.system(size: 6))
			Text("Не верный адрес электронной почты")
				.modifier(HeightModifier(
					size: 12,
					lineHeight: 120,
					weight: .regular)
				)
		}
		.foregroundColor(Color.customRed)
		.padding(.leading, 16)
		.frame(maxWidth: .infinity, alignment: .leading)
	}
}

#if DEBUG
struct BayerInformationView_Previews: PreviewProvider {
	static var previews: some View {
		BookingView(isMainView: .constant(false))
	}
}
#endif
