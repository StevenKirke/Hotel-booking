//
//  TouristCartViewModel.swift
//  HotelBooking
//
//  Created by Steven Kirke on 28.09.2023.
//

import UIKit

typealias CurrentTouristCard = BuyerInformation.FieldsTouristCard
typealias ContactList = BuyerInformation.Contact

protocol IBayerInformationModel {
	func assambleTitle(index: Int) -> String
	func currentTourist(index: Int) -> CurrentTouristCard
	func removeLastTourist()
	func answerInEmptyField()
}

final class BayerInformationModel: ObservableObject, IBayerInformationModel {

	// MARK: - Dependencies
	private let contactService: IContactManager
	private let phoneMaskManagers: IPhoneMaskManager?
	private let emailManagers: IEmailValidationManager?

	// MARK: - Public properties
	@Published var phone: String = ""
	@Published var eMail: String = ""
	@Published var isValidEmail: Bool = false

	@Published var contactList: [ContactList] = []
	@Published var touristList: [CurrentTouristCard] = []
	@Published var isShowContact: Bool = false

	// MARK: - Private properties
	private let nameTourist: [String] = ["Первый", "Второй", "Третий", "Четвертый", "Пятый", "Шестой"]
	private let name: String = "турист"

	// MARK: - Initializator
	internal init(
		contactService: IContactManager,
		phoneMaskManagers: IPhoneMaskManager,
		emailManagers: IEmailValidationManager
	) {
		self.contactService = contactService
		self.phoneMaskManagers = phoneMaskManagers
		self.emailManagers = emailManagers
		self.getTourist()
	}

	// MARK: - Public methods
	func fetchContactList() {
		Task.init {
			await fetchContact()
		}
	}

	func assambleTitle(index: Int) -> String {
		var currentTitle: String = ""
		if index < nameTourist.count {
			currentTitle =  "\(nameTourist[index])" + " "  + name
		}
		return currentTitle
	}

	func currentTourist(index: Int) -> CurrentTouristCard {
		touristList[index]
	}

	func removeLastTourist() {
		self.touristList.removeLast()
	}

	func answerInEmptyField() {
		checkAllCard()
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
							mask: self.phoneMask(phone: contact.number)
						)
					})
					self.isShowContact.toggle()
				}
			}
			if case let .failure(error) = result {
				print("Error \(error)")
			}
		}
	}
}

// MARK: - ACTION UI Обработка поля 'phone'
extension BayerInformationModel {
	private func phoneMask(phone: String) -> String {
		guard let number = phoneMaskManagers?.maskForNumber(phoneNumber: phone) else {
			return ""
		}
		return number
	}

	func changePhone(phone: String) {
		if let currentMask = phoneMaskManagers {
			self.phone = currentMask.cropPhoneNumber(phone: phone)
		}
	}
}

// MARK: - ACTION UI Обработка поля 'mail'
extension BayerInformationModel {
	func validationEmail(email: String) {
		if let emailValidator = emailManagers {
			self.isValidEmail = emailValidator.isValidationEmail(email: email)
		}
	}
}

// MARK: - ACTION UI Обработка полей турист
extension BayerInformationModel {
	// Создаем две карточки туриста
	private func getTourist() {
		for index in 0...1 {
			self.addTouristInCard(index: index)
		}
	}

	// Создание структуры полей карточки для дальнейшей обработки и отправки на сервер
	func addTouristInCard(index: Int) {
		if index < nameTourist.count {
			self.touristList.append(
				BuyerInformation.FieldsTouristCard(
					firstName: BuyerInformation.FieldSave(
						text: "",
						placeholder: "Имя"
					),
					lastName: BuyerInformation.FieldSave(
						text: "",
						placeholder: "Фамилия"
					),
					dateBirth: BuyerInformation.FieldSave(
						text: "",
						placeholder: "Дата рождения"
					),
					citizenShip: BuyerInformation.FieldSave(
						text: "",
						placeholder: "Гражданство"
					),
					numberPassport: BuyerInformation.FieldSave(
						text: "",
						placeholder: "Номер загранпаспорта"
					),
					validityPeriodPassport: BuyerInformation.FieldSave(
						text: "",
						placeholder: "Срок действия загранпаспорта"
					)
				)
			)
		}
	}
}

// MARK: - ACTION UI Проверка полей на пустоту
extension BayerInformationModel {
	private func checkAllCard() {
		for index in touristList {
			checkFieldsInCardTourist(cartTourist: index)
		}
	}

	private func checkFieldsInCardTourist(cartTourist: CurrentTouristCard) {
		let mirrorField = Mirror(reflecting: cartTourist)

		for (property, value) in mirrorField.children {
			if let currentField = value as? BuyerInformation.FieldSave {
				if currentField.isEmpty {
					print("Field dont is empty")
				} else {
					print("Field is empty")
				}
			}
		}
	}
}
