//
//  ContactViewModel.swift
//  HotelBooking
//
//  Created by Steven Kirke on 05.10.2023.
//

import SwiftUI
import Contacts




class ContactViewModel {
    
    
    @Published var currentNumber: String = ""
    
    
    func fetchSpecificContact() async {
        let store = CNContactStore()
        let keys = [CNContactGivenNameKey, CNContactPhoneNumbersKey] as [CNKeyDescriptor]
        let predicate = CNContact.predicateForContacts(matchingName: "Kate")
        
        do {
            let contact = try store.unifiedContacts(matching: predicate, keysToFetch: keys)
            print(contact)
        } catch {
            print("Error")
        }
        
        
    }
    
    func fetchAllContacts() async {
        
        let store = CNContactStore()
        
        let keys = [CNContactGivenNameKey, CNContactPhoneNumbersKey] as [CNKeyDescriptor]
        
        let fetchRequest = CNContactFetchRequest(keysToFetch: keys)
        
        do {
            try store.enumerateContacts(with: fetchRequest) { contact, result in
                for number in contact.phoneNumbers {
                    switch number.label {
                        case CNLabelPhoneNumberMobile:
                            print(" - Mobile \(number.value.stringValue)")
                        case CNLabelPhoneNumberMain:
                            print(" - Main \(number.value.stringValue)")
                        default:
                            print(" - Other \(number.value.stringValue)")
                    }
                }
            }
        } catch {
            print("Error")
        }
    }

}
