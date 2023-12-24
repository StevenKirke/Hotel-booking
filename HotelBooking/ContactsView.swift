//
//  ContactsView.swift
//  HotelBooking
//
//  Created by Steven Kirke on 20.12.2023.
//

import SwiftUI

typealias ContactListDisplay = BuyerInformation.Contact

/// Окно контактов, список контактов из телефонной книги
struct ContactsView: View {

	var contactList: [ContactListDisplay]

	@Binding var phone: String
	@Binding var isShowContact: Bool

	var body: some View {
		VStack(spacing: 10) {
			HStack(alignment: .center, spacing: 0) {
				Text("Контакты")
					.modifier(HeightModifier(size: 22, lineHeight: 120, weight: .medium))
					.frame(maxWidth: .infinity, alignment: .leading)
					.foregroundColor(.black)
				Button(action: {
					self.closeActionView()
				}, label: {
					Image.closeSquare
						.resizable()
						.frame(width: 24, height: 24)
						.foregroundColor(.black)
				})
			}
			.padding(.horizontal, 16)
			.padding(.top, 16)
			ScrollView(.vertical, showsIndicators: false) {
				ForEach(contactList.indices, id: \.self) { list in
					let contact = contactList[list]
					Button(action: {
						self.addContact(contact: contact)
					}, label: {
						HStack(spacing: 0) {
							Text(contact.name)
								.modifier(HeightModifier(size: 16,
														 lineHeight: 120,
														 weight: .medium))
								.foregroundColor(.customA9ABB7)
							Spacer()
							Text(contact.mask)
								.modifier(HeightModifier(size: 16,
														 lineHeight: 120,
														 weight: .medium))
								.foregroundColor(.customOmbreGray)
						}
						.padding(.vertical, 10)
					})
					if list != contactList.count - 1 {
						createDivider()
					}
				}
				.padding(.horizontal, 16)
			}
			.background(Color.ColorFBFBFC)
			.cornerRadius(15)
		}
		.background(Color.white)
	}

	@ViewBuilder
	func createDivider() -> some View {
		Rectangle()
			.fill(Color.customBlack15)
			.frame(height: 1)
			.offset(x: -15)
	}

	private func addContact(contact: ContactListDisplay) {
		DispatchQueue.main.async {
			self.phone = contact.mask
			self.closeActionView()
		}
	}

	private func closeActionView() {
		DispatchQueue.main.async {
			self.isShowContact.toggle()
		}
	}
}

#if DEBUG
struct ContactsView_Previews: PreviewProvider {

	static var previews: some View {
		ContactsView(contactList: [],
					 phone: .constant(""),
					 isShowContact: .constant(false))
	}
}
#endif
