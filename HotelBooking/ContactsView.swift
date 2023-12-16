//
//  ContactsView.swift
//  HotelBooking
//
//  Created by Steven Kirke on 07.10.2023.
//

import SwiftUI

struct ContactsView: View {

	var contactList: [Contact]

	@Binding var phone: String
	@Binding var showingOptions: Bool

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
				Button(action: {}, label: {
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
						DispatchQueue.main.async {
							self.phone = contact.mask
							self.closeActionView()
						}
					}, label: {
						HStack(spacing: 0) {
							Text(contact.name)
								.modifier(HeightModifier(size: 16,
														 lineHeight: 120,
														 weight: .medium))
								.foregroundColor(.customDarkGrey)
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

	private func closeActionView() {
		DispatchQueue.main.async {
			self.showingOptions.toggle()
		}
	}
}

#if DEBUG
struct ContactsView_Previews: PreviewProvider {

	static var previews: some View {
		ContactsView(contactList: [],
					 phone: .constant(""),
					 showingOptions: .constant(false))
	}
}
#endif
