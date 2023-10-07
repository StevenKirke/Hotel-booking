

import SwiftUI

func number(text: String) {
   // print(text)
    let currentText = text.removeNonNum()
    print(currentText)
    /*
    switch currentText.count {
        case 10:
            let assambly = "7" + currentText
            let newFormat = format(with: "+X (XXX) XXX-XXXX", phone: assambly)
            print(newFormat)
        //case 11:
            //let newFormat = format(with: "+X (XXX) XXX-XXXX", phone: currentText)
            //print(newFormat)
        default:
            print("Incorrect phone number!")
    }
    */
}

private func removeNonNUmeric(phone: String) -> String {
    let target = "[^0-9]"
    let result = phone.replacingOccurrences( of: target,
                                             with: "",
                                             options: .regularExpression)
    return result
}



private func format(with mask: String, phone: String) -> String {
    var result = ""
    var index = phone.startIndex
    for ch in mask where index < phone.endIndex {
        if ch == "X" {
            result.append(phone[index])
            index = phone.index(after: index)

        } else {
            result.append(ch)
        }
    }
    return result
}


number(text: "(707) 555-1854")
//number(text: "+7 (968) 891-85-22")


extension String {
    func removeNonNum() -> String {
        let target = "[^0-9]"
        let result = self.replacingOccurrences( of: target,
                                                 with: "",
                                                 options: .regularExpression)
        return result
    }
}
