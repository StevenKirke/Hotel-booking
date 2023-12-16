//
//  ContactViewModel.swift
//  HotelBooking
//
//  Created by Steven Kirke on 05.10.2023.
//

import SwiftUI
import Contacts

struct Contact {
	let name: String
	let number: String
	let mask: String
}

class ContactViewModel: ObservableObject {

	@Published var showingOptions = false
	@Published var contactList: [Contact] = []

	func getContactList() {
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
	}

	private func fetchAllContacts(returnList: ([Contact]) -> Void) async {
		let store = CNContactStore()
		let keys = [CNContactGivenNameKey, CNContactFamilyNameKey, CNContactPhoneNumbersKey] as [CNKeyDescriptor]
		let fetchRequest = CNContactFetchRequest(keysToFetch: keys)

		var tempContacts: [Contact] = []

		do {
			try store.enumerateContacts(with: fetchRequest) { contact, _ in
				for number in contact.phoneNumbers {
					let phone = number.value.stringValue.removeNonNum()
					let fullName = assamblyFullName(contact.givenName, contact.familyName)

					if number.label == CNLabelPhoneNumberMobile {
						if !phone.isEmpty {
							tempContacts.append(
								Contact(name: fullName, number: phone, mask: maskForNumber(phone))
							)
						}
					}
				}
			}
		} catch {
			print("Error load contact list.")
		}
		return returnList(tempContacts)
	}

	private func assamblyFullName(_ firstName: String?, _ lastName: String?) -> String {
		(firstName ?? "") + " " + (lastName ?? "")
	}

	private func maskForNumber(_ phone: String) -> String {
		var tempNumber = ""
		switch phone.count {
		case 10:
			let assamply = "7" + phone
			tempNumber = assamply.formatMaskPhone(.mobile)
		case 11:
			tempNumber = phone.formatMaskPhone(.mobile)
		case 13:
			tempNumber = phone.formatMaskPhone(.landline)
		default:
			tempNumber = ""
		}
		return tempNumber
	}
}
