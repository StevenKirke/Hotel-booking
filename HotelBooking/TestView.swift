//
//  TestView.swift
//  HotelBooking
//
//  Created by Steven Kirke on 05.11.2023.
//

import SwiftUI

struct TestTextFields: View {
    
    @ObservedObject var vm: CustomTextFieldViewModel = CustomTextFieldViewModel()
    @FocusState var focus: Bool
    
    
    var body: some View {
        VStack(spacing: 10) {
            ForEach(vm.customFields.indices, id: \.self) { index in
                VStack {
                    ForEach(vm.customFields[index].indices, id: \.self) { element in
                        let urrentElem = vm.customFields[index][element]
                        CustomTextFieldTest(
                            title: $vm.customFields[index][element],
                            nameField: check(urrentElem)
                        )
                    }
                    .onSubmit {
                    }
                }
            }
            Button(action: {}) {
                Text("Answer")
                    .modifier(HeightModifier(size: 16, lineHeight: 110, weight: .medium))
                    .tracking(0.1)
                    .foregroundColor(.white)
                    .frame(height: 48)
                    .frame(maxWidth: .infinity)
                    .background(Color.c_0D72FF)
                    .cornerRadius(15)
            }
            .padding(.horizontal, 16)
        }
        .frame(maxWidth: .infinity)
    }
    
    private func check(_ elem: ForFields) -> Binding<FormForFields> {
        switch elem {
        case .name(text: let text, field: _):
            print("CASE - NAME")
            var active: FormForFields = .none
            if !text.isEmpty {
                active = .inactiveField
            } else {
                active = .activeField
            }
            return .constant(active)
        case .lastName(lastName: let lastName, field: _):
            print("CASE - LAST NAME")
            var active: FormForFields = .none
            if !lastName.isEmpty {
                active = .inactiveField
            } else {
                active = .activeField
            }
            return .constant(active)
        }
    }
}
        
        
    
    struct CustomTextFieldTest: View {
        
        @Binding var title: ForFields
        @State var fram: String = ""
        @FocusState var focus: Bool
        @Binding var nameField: FormForFields
        
        var body: some View {
            HStack(spacing: 5) {
                ZStack(alignment: .leading) {
                    if fram.isEmpty {
                        Text(title.title)
                    }
                    TextField("", text: $fram)
                        .tint(.black)
                        .focused($focus)
                }
                HStack(spacing: 10) {
                    Circle()
                        .fill(.red)
                        .frame(width: 6, height: 6)
                }
                
            }
            .frame(maxWidth: .infinity, alignment: .leading)
            .padding(.horizontal, 16)
            .padding(.vertical, 10)
            .foregroundColor(.black)
            .background(.gray).opacity(0.4)
            .cornerRadius(13)
            .padding(.horizontal, 10)
            .onChange(of: $fram.wrappedValue) { _ in
                if case .name = title {
                   // print("CASE - NAME")
                    self.title = ForFields.name(text: fram, field: FormForFields.none)
                } else if case .lastName = title {
                    //print("CASE - LASR NAME")
                    self.title = ForFields.lastName(lastName: fram, field: FormForFields.none)
                }
                //checkFocus()
            }
        }
        
        //    private func checkFocus() {
        //        switch nameField {
        //        case .activeField:
        //            self.focus = true
        //        case .inactiveField:
        //            self.focus = false
        //        }
        //    }
    }
    
    
    
#if DEBUG
    struct TestTextFields_Previews: PreviewProvider {
        static var previews: some View {
            TestTextFields()
        }
    }
#endif
    
    
    
    /*
     //        var isBreak: Bool = false
     //    outerLoop: for (indexBlock, _) in vm.customFields.enumerated() {
     //            for (indexElement, _) in vm.customFields[indexBlock].enumerated() {
     //                let currentElement = vm.customFields[indexBlock][indexElement]
     //                //let currentText = currentElement.shows(currentElement)
     //
     //                switch currentElement {
     //                case .name(text: let text, field: _):
     //                    var active: FormForFields = .none
     //                    if !text.isEmpty {
     //                        active = .inactiveField
     //                    } else {
     //                        active = .activeField
     //                        isBreak = true
     //                    }
     //                    return active
     //                case .lastName(lastName: let lastName, field: _):
     //                    var active: FormForFields = .none
     //                    if !lastName.isEmpty {
     //                        active = .inactiveField
     //                    } else {
     //                        active = .activeField
     //                        isBreak = true
     //                    }
     //                    return active
     //                }
     //                if isBreak {
     //                    break outerLoop
     //                }
     //            }
     //        }
     .onSubmit() {
     let currentText: Bool = !fram.isEmpty ? true : false
     self.nameFields = currentText
     if case .name = title {
     print("CASE - NAME")
     self.title = ForFields.name(text: fram, field: .init(submit: currentText, ictive: .activeField))
     } else if case .lastName = title {
     print("CASE - LASR NAME")
     self.title = ForFields.lastName(lastName: fram, field: .init(submit: currentText, ictive: .inactiveField))
     }
     }
     private func changeField(_ field: ForFields) -> ForFieldElem {
     var blockField: ForFieldElem
     switch field {
     case .name(let name):
     blockField = ForFieldElem(name: .name(text: name), submit: false, ictive: .inactiveField)
     case .lastName:
     blockField = ForFieldElem(name: .lastName, submit: false, ictive: .inactiveField)
     case .dateBirth:
     blockField = ForFieldElem(name: .dateBirth, submit: false, ictive: .inactiveField)
     case .citizenShip:
     blockField = ForFieldElem(name: .citizenShip, submit: false, ictive: .inactiveField)
     case .numberPassport:
     blockField = ForFieldElem(name: .numberPassport, submit: false, ictive: .inactiveField)
     case .validityPeriodPassport:
     blockField = ForFieldElem(name: .validityPeriodPassport, submit: false, ictive: .inactiveField)
     }
     return blockField
     }
     
     
     private func isText(_ elem: ForFields, text: String) {
     var active = title.isActive(elem, text)
     print(active)
     }
     
     //    private func isActive(_ elem: ForFields) -> Bool {
     //        var active = title.isActive(elem: elem)
     //        self.nameFields = active
     //        return active
     //    }
     
     func isShow(_ elem: ForFields) -> String {
     var ret: String = ""
     switch elem {
     case .name(text: _):
     ret = elem.shows(elem: elem)
     }
     return ret
     }
     */
