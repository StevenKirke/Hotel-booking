//
//  BayerView.swift
//  HotelBooking
//
//  Created by Steven Kirke on 21.12.2023.
//

import SwiftUI

struct BayerView: View {

	@ObservedObject var bayerVm: BayerInformationModel = BayerInformationModel(
		contactService: ContactManager(),
		phoneMask: PhoneMaskManager()
	)

	var body: some View {
		VStack {
			BayerInformationView(action: {})
			AddCardTourist(title: "Добавить туриста", action: {addTourist()})
		}
	}

	private func addTourist() {
		print("ADD NEW THE CARD")
	}
}
/*
 .sheet(isPresented: $contactVM.showingOptions, content: {
	 ContactsView(contactList: contactVM.contactList,
				  phone: $mvTourist.phone,
				  showingOptions: $contactVM.showingOptions)
 })
 .onAppear {
	 self.specification.getSpecification(idRoom)
 }
		.onChange(of: mvTourist.phone) { value in
			mvTourist.phone.formatPhoneMumberDateString()
			if value.count > 18 {
				UIApplication.shared.endEditing()
			}
		}
		ForEach(mvTourist.tourists.indices, id: \.self) { index in
			let nameCard = mvTourist.nameTourist[index] + " турист"
			let zeroIndex = index == 0 ? true : false
			let lastIndex = index == mvTourist.tourists.count - 1 && index != 0 ? false : true
			CardBooking(
				title: nameCard,
				isShowRemove: lastIndex,
				isShow: zeroIndex,
				cardTourist: $mvTourist.tourists[index],
				remove: { removeCart() }
			)
		}
*/
