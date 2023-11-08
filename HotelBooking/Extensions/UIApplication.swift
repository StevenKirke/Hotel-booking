//
//  UIApplication.swift
//  HotelBooking
//
//  Created by Steven Kirke on 08.11.2023.
//

import UIKit

extension UIApplication {
    func endEditing() {
        sendAction(#selector(UIResponder.resignFirstResponder), to: nil, from: nil, for: nil)
    }
}
