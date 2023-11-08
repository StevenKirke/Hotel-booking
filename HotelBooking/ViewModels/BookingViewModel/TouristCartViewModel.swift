//
//  TouristCartViewModel.swift
//  HotelBooking
//
//  Created by Steven Kirke on 28.09.2023.
//

import Foundation


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

class TouristCartViewModel: ObservableObject {

    @Published var phone: String = ""
    @Published var eMail: String = ""
    @Published var tourists: [FieldsTouristCard] = []
    
    @Published var fullCart: FullCart?
    
    
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
    
    private func countList() -> Int {
        self.tourists.count
    }
    
    func writeForJSON() {
        self.fullCart = FullCart(
            phone: phone,
            eMail: eMail,
            tuorists: tourists
        )
        print(fullCart)
    }
}
