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
    
    func removeNonNum() -> String {
        let target = "[^0-9]"
        let result = self.replacingOccurrences( of: target,
                                                 with: "",
                                                 options: .regularExpression)
        return result
    }
    
    func formatMaskPhone(_ mask: MaskPhone) -> String {
        let currentMask = mask.rawValue
        var result = ""
        var index = self.startIndex
        for ch in currentMask where index < self.endIndex {
            if ch == "X" {
                result.append(self[index])
                index = self.index(after: index)

            } else {
                result.append(ch)
            }
        }
        return result
    }
    
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
                target = "$1/$2"
            } else if number.count < 5 {
                pattern = "(\\d{2})(\\d{2})"
                target = "$1/$2"
            } else if number.count < 6 {
                pattern = "(\\d{2})(\\d{2})(\\d+)"
                target = "$1/$2/$3"
            } else {
                pattern = "(\\d{2})(\\d{2})(\\d+)"
                target = "$1/$2/$3"
            }
            number = number.replacingOccurrences(of: pattern, with: target, options: .regularExpression, range: regRange)
        } catch {
            return "Error"
        }
        return number
    }
    
    func textFieldValidatorEmail() -> Bool {
        if self.count > 100 {
            return false
        }
        let emailFormat = "(?:[\\p{L}0-9!#$%\\&'*+/=?\\^_`{|}~-]+(?:\\.[\\p{L}0-9!#$%\\&'*+/=?\\^_`{|}" + "~-]+)*|\"(?:[\\x01-\\x08\\x0b\\x0c\\x0e-\\x1f\\x21\\x23-\\x5b\\x5d-\\" + "x7f]|\\\\[\\x01-\\x09\\x0b\\x0c\\x0e-\\x7f])*\")@(?:(?:[\\p{L}0-9](?:[a-" + "z0-9-]*[\\p{L}0-9])?\\.)+[\\p{L}0-9](?:[\\p{L}0-9-]*[\\p{L}0-9])?|\\[(?:(?:25[0-5" + "]|2[0-4][0-9]|[01]?[0-9][0-9]?)\\.){3}(?:25[0-5]|2[0-4][0-9]|[01]?[0-" + "9][0-9]?|[\\p{L}0-9-]*[\\p{L}0-9]:(?:[\\x01-\\x08\\x0b\\x0c\\x0e-\\x1f\\x21" + "-\\x5a\\x53-\\x7f]|\\\\[\\x01-\\x09\\x0b\\x0c\\x0e-\\x7f])+)\\])"
        let emailPredicate = NSPredicate(format:"SELF MATCHES %@", emailFormat)
        return emailPredicate.evaluate(with: self)
    }
    
    mutating func formatPhoneMumberDateString() {
        if self.count <= 18 {
            let removeNonNuneric = self.removeNonNum()
            let convert = removeNonNuneric.formatMaskPhone(.mobile)
            let crop = String(convert.prefix(18))
            self = crop
        }
        if self.count > 18 {
            self.removeLast()
        }
    }
    
}

/*
 
 var phoneNumber: String

 mutating func formatPhoneMumberDateString() {
     if phoneNumber.count <= 18 {
         let removeNonNuneric = phoneNumber.removeNonNum()
         let convert = removeNonNuneric.formatMaskPhone(.mobile)
         let crop = String(convert.prefix(18))
         phoneNumber = crop
     }
     if phoneNumber.count > 18 {
         phoneNumber.removeLast()
     }
 }
 */

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
