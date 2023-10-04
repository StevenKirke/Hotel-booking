//
//  String.swift
//  HotelBooking
//
//  Created by Steven Kirke on 08.09.2023.
//

import Foundation


extension String {
    var isNumber: Bool {
        let digitsCharacters = CharacterSet(charactersIn: "0123456789")
        return CharacterSet(charactersIn: self).isSubset(of: digitsCharacters)
    }
    

}

extension String {
    func separate() -> String {
        let separate = self.components(separatedBy: ",").first
        guard let firstElement = separate else {
            return ""
        }
       return firstElement
    }
    
    
    func dataSeparator() -> String {
            let maxNumberCount = 8
            var number: String = ""
            do {
                let regex = try NSRegularExpression(pattern: "\\D", options: .caseInsensitive)
                let range = NSRange(location: 0, length: self.utf8.count)
                number = regex.stringByReplacingMatches(in: self, options: [], range: range, withTemplate: "")
                if number.count > maxNumberCount {
                    let maxIndex = number.index(number.startIndex, offsetBy: maxNumberCount)
                    number = String(number[number.startIndex..<maxIndex])
                }
                let maxIndex = number.index(number.startIndex, offsetBy: number.count)
                let regRange = number.startIndex..<maxIndex
                
                var pattern = ""
                var target = ""
                
                if number.count < 4 {
                    pattern = "(\\d{2})(\\d+)"
                    target = "$1.$2"
                } else if number.count < 5 {
                    pattern = "(\\d{2})(\\d{2})"
                    target = "$1.$2"
                } else if number.count < 6 {
                    pattern = "(\\d{2})(\\d{2})(\\d+)"
                    target = "$1.$2.$3"
                } else {
                    pattern = "(\\d{2})(\\d{2})(\\d+)"
                    target = "$1.$2.$3"
                }
                number = number.replacingOccurrences(of: pattern, with: target, options: .regularExpression, range: regRange)
            } catch {
                return "Error"
            }
            return number
    }
}



extension Int {
    func centesimal() -> String {
        let convert: NSNumber = self as NSNumber
        let formatter = NumberFormatter()
        formatter.positiveFormat = "##,###,###"
        formatter.groupingSeparator = " "
        if let string = formatter.string(from: convert) {
            return string
        }
        return String(self)
    }
}


/*
 
 .onChange(of: title) {
     if self.workToString.textFieldValidatorEmail($0) {
         self.isValid = true
         self.emailValid = ""
     } else {
         self.isValid = false
         self.emailValid = "No correct email"
     }
 }
 
 class WorkToNumber {

     func forTrailingZero(number: Double) -> String {
         return String(format: "%.2f", number)
     }
     
     func textFieldValidatorEmail(_ string: String) -> Bool {
         if string.count > 100 {
             return false
         }
         let emailFormat = "(?:[\\p{L}0-9!#$%\\&'*+/=?\\^_`{|}~-]+(?:\\.[\\p{L}0-9!#$%\\&'*+/=?\\^_`{|}" + "~-]+)*|\"(?:[\\x01-\\x08\\x0b\\x0c\\x0e-\\x1f\\x21\\x23-\\x5b\\x5d-\\" + "x7f]|\\\\[\\x01-\\x09\\x0b\\x0c\\x0e-\\x7f])*\")@(?:(?:[\\p{L}0-9](?:[a-" + "z0-9-]*[\\p{L}0-9])?\\.)+[\\p{L}0-9](?:[\\p{L}0-9-]*[\\p{L}0-9])?|\\[(?:(?:25[0-5" + "]|2[0-4][0-9]|[01]?[0-9][0-9]?)\\.){3}(?:25[0-5]|2[0-4][0-9]|[01]?[0-" + "9][0-9]?|[\\p{L}0-9-]*[\\p{L}0-9]:(?:[\\x01-\\x08\\x0b\\x0c\\x0e-\\x1f\\x21" + "-\\x5a\\x53-\\x7f]|\\\\[\\x01-\\x09\\x0b\\x0c\\x0e-\\x7f])+)\\])"
         let emailPredicate = NSPredicate(format:"SELF MATCHES %@", emailFormat)
         return emailPredicate.evaluate(with: string)
     }
 }

 */
