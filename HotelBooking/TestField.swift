//
//  TestField.swift
//  HotelBooking
//
//  Created by Steven Kirke on 05.11.2023.
//

import Foundation
import SwiftUI

/*
 var name: String
 var lastName: String
 @DateFormatted var dateBirth: String
 var citizenShip: String
 var numberPassport: String
 @DateFormatted var validityPeriodPassport: String
 */

enum FormForFields: String, CaseIterable {
    case activeField = "Active field"
    case inactiveField = "Inactive field"
    case none
}

enum ForFields: CaseIterable {

    case name(text: String, field: FormForFields?)
    case lastName(lastName: String, field: FormForFields?)
//    case dateBirth(dateBirth: String)
//    case citizenShip(citizenShip: String)
//    case numberPassport(numberPassport: String)
//    case validityPeriodPassport(validityPeriodPassport: String)
    
    var title: String {
        var name: String = ""
        switch self {
        case .name:
            name = "Имя"
        case .lastName:
            name = "Фамилия"
//        case .dateBirth:
//            name = "Дата рождения"
//        case .citizenShip:
//            name = "Гражданство"
//        case .numberPassport:
//            name = "Номер загранпаспорта"
//        case .validityPeriodPassport:
//            name = "Срок действия загранпаспорта"
        }
        return name
    }
    
    func shows(_ elem: Self) -> String {
        switch elem {
        case .name(let text, _):
            return text
        case .lastName(let lastName, _):
            return lastName
        }
    }
    
    func currentActive(_ elem: Self) -> FormForFields {
        var active: FormForFields = .none
        switch elem {
        case .name(let text, _):
            if !text.isEmpty {
                active = .inactiveField
            } else {
                active = .activeField
            }
        case .lastName(let lastName, _):
            if !lastName.isEmpty {
                active =  .inactiveField
            } else {
                active =  .activeField
            }
        }
        return active
    }

    
    static let allCases: [ForFields] = [
        .name(text: "", field: .inactiveField),
        .lastName(lastName: "", field: .inactiveField)
    ]
}

@MainActor
class CustomTextFieldViewModel: ObservableObject {
    
    @Published var customFields: [[ForFields]] = []
    
    init() {
        self.loadTouristCard()
    }
    
    
    private func loadTouristCard() {
        //for _ in 0...1 {
            let currentBlockField: [ForFields] = [
                ForFields.name(text: "", field: .inactiveField),
                ForFields.lastName(lastName: "", field: .inactiveField),
                ]
            self.customFields.append(currentBlockField)
       // }
    }
}
    
/*
 
 mutating func isActive(_ elem: Self, _ text: String) -> Bool {
     var currentColor: Bool = true
     switch elem {
     case .name(let text, _):
         print("Field name - \(text)")
         currentColor = !text.isEmpty ? true : false
     case .lastName(let lastName, _):
         print("Field lastName - \(lastName)")
         currentColor = !lastName.isEmpty ? true : false
     }
     return currentColor
 }
 
 ForFieldElem(name: .lastName, submit: false, ictive: .activeField),
 ForFieldElem(name: .dateBirth, submit: false, ictive: .activeField),
 ForFieldElem(name: .citizenShip, submit: false, ictive: .activeField),
 ForFieldElem(name: .numberPassport, submit: false, ictive: .activeField),
 ForFieldElem(name: .validityPeriodPassport, submit: false, ictive: .activeField)
 */
