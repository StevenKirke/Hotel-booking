//
//  CardTourist.swift
//  HotelBooking
//
//  Created by Steven Kirke on 11.09.2023.
//

import SwiftUI


struct CardTourist: View {
        
    @FocusState.Binding var nameFields: FieldForCard?
    @State var isShow: Bool = false
    
    @Binding var currentTourist: TouristCard

    let title: String

    @Binding var submitPressed: Bool
    
    var body: some View {
        VStack(spacing: 0) {
            ShowCardTourist(isShow: $isShow, title: title, action: {
                DispatchQueue.main.async {
                    withAnimation(.easeInOut) {
                        self.isShow.toggle()
                    }
                }
            })
            .padding(.bottom, isShow ? 17 : 0)
            if self.isShow {
                VStack(spacing: 8) {
                    TextFieldForTouristWithPlaceholder(textField: $currentTourist.name,
                                                       focus: $nameFields,
                                                       nameField: .lastName,
                                                       submitPressed: submitPressed)
                    TextFieldForTouristWithPlaceholder(textField: $currentTourist.lastName,
                                                       focus: $nameFields,
                                                       nameField: .firstName,
                                                       submitPressed: submitPressed)
                    TextFieldForTourist(textField: $currentTourist.dateBirth,
                                        focus: $nameFields,
                                        nameField: .dateBirth,
                                        type: .numberPad,
                                        submitPressed: submitPressed)
                    TextFieldForTourist(textField: $currentTourist.citizenShip,
                                        focus: $nameFields,
                                        nameField: .citizenShip,
                                        submitPressed: submitPressed)
                    TextFieldForTourist(textField: $currentTourist.numberPassport,
                                        focus: $nameFields,
                                        nameField: .passportNumber,
                                        submitPressed: submitPressed)
                    TextFieldForTourist(textField: $currentTourist.validityPeriodPassport,
                                        focus: $nameFields,
                                        nameField: .validityPassport,
                                        type: .numberPad,
                                        submitPressed: submitPressed)
                }
            }
        }
        .padding(.horizontal, 13)
        .vLeading()
        .padding(.vertical, 16)
        .background(Color.white)
        .cornerRadius(15)
    }
}


struct TextFieldForTouristWithPlaceholder: View {
    
    @Binding var textField: String
    @FocusState.Binding var focus: FieldForCard?
    var nameField: FieldForCard
    var submitPressed: Bool
    
    var body: some View {
        VStack(alignment: .leading, spacing: 0) {
            Text(nameField.rawValue)
                .modifier(HeightModifier(size: 12, lineHeight: 120, weight: .regular))
                .tracking(0.1)
                .foregroundColor(.c_A9ABB7)
            TextField("", text: $textField)
                .modifier(HeightModifier(size: 16, lineHeight: 110, weight: .regular))
                .tracking(0.075)
                .foregroundColor(.c_14142B)
                .textContentType(.name)
                .tint(Color.black)
        }
        .vLeadingAndBack((self.textField.isEmpty && self.submitPressed) ? false : true)
    }
}


struct TextFieldForTourist: View {
    
    @Binding var textField: String
    @FocusState.Binding var focus: FieldForCard?
    var nameField: FieldForCard
    var type: UIKeyboardType = .default
    var submitPressed: Bool
    
    var body: some View {
        ZStack(alignment: .leading) {
            if textField.isEmpty {
                Text(nameField.rawValue)
                    .modifier(HeightModifier(size: 17,
                                             lineHeight: 110,
                                             weight: .regular))
                    .foregroundColor(.c_A9ABB7)
            }
            TextField("", text: $textField)
                .modifier(HeightModifier(size: 17,
                                         lineHeight: 110,
                                         weight: .regular))
                .tracking(0.1)
                .foregroundColor(.c_14142B)
                .tint(.black)
                .keyboardType(type)
                .focused($focus, equals: nameField)
        }
        .vLeadingAndBack((self.textField.isEmpty && self.submitPressed) ? false : true)
    }
    
}

struct ShowCardTourist: View {
    
    @Binding var isShow: Bool
    
    var title: String = ""
    var action: () -> Void
    
    var body: some View {
        HStack(spacing: 0) {
            Text(title)
                .modifier(HeightModifier(size: 22, lineHeight: 120, weight: .medium))
                .foregroundColor(.black)
                .frame(maxWidth: .infinity, alignment: .leading)
            Button(action: action) {
                Image(systemName: "chevron.up")
                    .rotationEffect(.degrees(isShow ? 0 : 180))
            }
            .font(Font.system(size: 16))
            .frame(width: 32, height: 32)
            .foregroundColor(.c_0D72FF)
            .background(Color.c_0D72FF_10)
            .cornerRadius(6)
        }
    }
}

struct AddCardTourist: View {
    
    var title: String = ""
    var action: () -> Void
    
    var body: some View {
        HStack(spacing: 0) {
            Text(title)
                .modifier(HeightModifier(size: 22, lineHeight: 120, weight: .medium))
                .foregroundColor(.black)
                .frame(maxWidth: .infinity, alignment: .leading)
            Button(action: action) {
                Image(systemName: "plus")
            }
            .font(Font.system(size: 16))
            .frame(width: 32, height: 32)
            .foregroundColor(.white)
            .background(Color.c_0D72FF)
            .cornerRadius(6)
        }
        .solidBlackground()
    }
}



#if DEBUG
struct CardTourist_Previews: PreviewProvider {
    static var previews: some View {
        BookingView()
    }
}
#endif

