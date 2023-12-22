//
//  TouristCartViewModel.swift
//  HotelBooking
//
//  Created by Steven Kirke on 28.09.2023.
//

import Foundation

typealias ContactList = BuyerInformation.Contact

final class BayerInformationModel: ObservableObject {

	// MARK: - Dependencies
	private let contactService: IContactManager
	private let phoneMask: IPhoneMaskManager?

	@Published var phone: String = ""
	@Published var eMail: String = ""

	@Published var contactList: [ContactList] = []

	internal init(
		contactService: IContactManager,
		phoneMask: IPhoneMaskManager
	) {
		self.contactService = contactService
		self.phoneMask = phoneMask
	}

	func fetchContactList() {
		Task.init {
			await fetchContact()
		}
	}
}

// Запрос к списку контактов
private extension BayerInformationModel {
	private func fetchContact() async {
		await contactService.fetckContact { [weak self] result in
			guard let self = self else { return }

			if case let .success(contacts) = result {
				DispatchQueue.main.async {
					self.contactList = contacts.map({ contact in
						ContactList(
							name: contact.name,
							number: contact.number,
							mask: contact.mask
						)
					})
				}
			}
			if case let .failure(error) = result {
				print("Error \(error)")
			}
		}
	}
}

	/*


	 /*
   Task.init {

   await self.fetchAllContacts { [weak self] list in
   if !list.isEmpty {
   guard let self = self else {
   return
   }
   DispatchQueue.main.async {
   self.contactList = list
   self.showingOptions = true
   }
   }
   }
   }
   */


	let nameTourist: [String] = ["Первый", "Второй", "Третий", "Четвертый", "Пятый", "Шестой"]

	private var count: Int {
		self.countList()
	}

	init() {
		self.getTourist()
	}

	func addTourist() {
		self.addTouristInCard(count - 1)
	}

	func removeTourist() {
		self.tourists.removeLast()
	}

	private func getTourist() {
		for index in 0...1 {
			self.addTouristInCard(index)
		}
	}

	private func addTouristInCard(_ index: Int) {
		self.tourists.append(
			FieldsTouristCard(
				firstName: FieldSave(
					text: "",
					placeholder: "Имя"
				),
				lastName: FieldSave(
					text: "",
					placeholder: "Фамилия"
				),
				dateBirth: FieldSave(
					text: "",
					placeholder: "Дата рождения"
				),
				citizenShip: FieldSave(
					text: "",
					placeholder: "Гражданство"
				),
				numberPassport: FieldSave(
					text: "",
					placeholder: "Номер загранпаспорта"
				),
				validityPeriodPassport: FieldSave(
					text: "",
					placeholder: "Срок действия загранпаспорта"
				)
			)
		)
	}
	 //@Published var tourists: [FieldsTouristCard] = []

	 //@Published var fullCart: FullCart?

	private func countList() -> Int {
		self.tourists.count

	}

	func writeForJSON() {
		self.fullCart = FullCart(
			phone: phone,
			eMail: eMail,
			tuorists: tourists
		)
	}
	 */

struct FullCart {
	var phone: String
	var eMail: String
	var tuorists: [FieldsTouristCard]
}

enum CheckField: String, CaseIterable {
	case activeField = "Active field"
	case inactiveField = "Inactive field"

}

struct FieldsTouristCard {
	var firstName: FieldSave
	var lastName: FieldSave
	var dateBirth: FieldSave
	var citizenShip: FieldSave
	var numberPassport: FieldSave
	var validityPeriodPassport: FieldSave
}

struct FieldSave {
	var text: String
	var placeholder: String
	var isEmpty: Bool {
		!text.isEmpty ? true : false
	}
}
