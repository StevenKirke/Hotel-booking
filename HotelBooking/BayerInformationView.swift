//
//  BayerInformationView.swift
//  HotelBooking
//
//  Created by Steven Kirke on 20.12.2023.
//

import SwiftUI

// Карточка Информация о покупателе
struct BayerInformationView: View {

	@ObservedObject var bayerM: BayerInformationModel = BayerInformationModel(
		contactService: ContactManager(),
		phoneMask: PhoneMaskManager()
	)

	@State var isValidEmail: Bool = true
	@State var textPhone: String = ""
	@State var textEmail: String = ""

	@FocusState private var focus: NameFields?

	@State var isShowContact: Bool = false

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
					textField: $textPhone,
					focus: $focus
				)
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
					textField: $textEmail,
					focus: $focus
				)
				.onSubmit {
					if textEmail.textFieldValidatorEmail() {
						self.isValidEmail = true
					} else {
						self.isValidEmail = false
					}
				}
				if !isValidEmail && !textEmail.isEmpty {
					IsValidEMail()
				}
			}
			Text("Эти данные никому не передаются. После оплаты мы вышли чек на указанный вами номер и почту")
				.modifier(HeightModifier(size: 14, lineHeight: 120, weight: .regular))
				.foregroundColor(.customOmbreGray)
		}
		.solidBlackground()
		.sheet(isPresented: $isShowContact, content: {
			ContactsView(
				contactList: bayerM.contactList,
				phone: $textPhone,
				isShowContact: $isShowContact
			)
		})
	}

	private func contactView() {
		DispatchQueue.main.async {
			bayerM.fetchContactList()
			if !bayerM.contactList.isEmpty {
				self.isShowContact.toggle()
			}
		}
	}
}

struct IsValidEMail: View {
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
