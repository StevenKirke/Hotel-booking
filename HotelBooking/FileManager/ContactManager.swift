//
//  ContactManager.swift
//  HotelBooking
//
//  Created by Steven Kirke on 21.12.2023.
//

import SwiftUI
import Contacts

enum ErrorContact: Error {
	case errorLoadContact(String)
}

struct Contact: Decodable {
	let name: String
	let number: String
	let mask: String
}

///  'IContactManager' Получает список контактов из телефонного справочника
/// - Returns:
/// 	- returnListContacts: Возрашает массив контактов в формате ``Contact`` или ошибку
/// - Note:
protocol IContactManager {
	func fetckContact(returnListContacts: (Result<[Contact], ErrorContact>) -> Void) async
}

final class ContactManager: IContactManager {

	func fetckContact(returnListContacts: ( (Result<[Contact], ErrorContact>)) -> Void) async {

		let store = CNContactStore()
		let keys = [CNContactGivenNameKey, CNContactFamilyNameKey, CNContactPhoneNumbersKey] as [CNKeyDescriptor]
		let fetchRequest = CNContactFetchRequest(keysToFetch: keys)
		var tempContacts: [Contact] = []

		do {
			try store.enumerateContacts(with: fetchRequest) { contact, _ in
				for number in contact.phoneNumbers {
					let phone = removeNonNumeric(number: number.value.stringValue)
					let fullName = assamblyContact(givenName: contact.givenName, familyName: contact.familyName)

					if number.label == CNLabelPhoneNumberMobile && !phone.isEmpty {
						tempContacts.append(Contact(
							name: fullName,
							number: phone,
							mask: ""
						))
					}
				}
			}
		} catch let error {
			returnListContacts(.failure(.errorLoadContact(error.localizedDescription)))
		}
		returnListContacts(.success(tempContacts))
	}

	private func assamblyContact(givenName: String, familyName: String) -> String {
		"\(givenName)  \(familyName)"
	}

	private func removeNonNumeric(number: String) -> String {
		let target = "[^0-9]"
		let result = number.replacingOccurrences( of: target, with: "", options: .regularExpression)
		return result
	}
}
