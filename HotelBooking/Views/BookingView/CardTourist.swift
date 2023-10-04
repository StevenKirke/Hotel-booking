//
//  CardTourist.swift
//  HotelBooking
//
//  Created by Steven Kirke on 11.09.2023.
//

import SwiftUI




struct CardTourist: View {
        
    @State var isShow: Bool = false
    
    @Binding var currentTourist: TouristCard
    
    let title: String

    
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
                                                       title: "Имя")
                    TextFieldForTouristWithPlaceholder(textField: $currentTourist.lastName,
                                                       title: "Фамилия")
                    TextFieldForTourist(textField: $currentTourist.dateBirth,
                                        isValid: isEmpty($currentTourist.dateBirth),
                                        pleaceHolder: "Дата рождения",
                                        type: .numberPad)
                    .border(isEmpty($currentTourist.dateBirth) ? Color.black : Color.red)
                    /*
                    TextFieldForTourist(textField: $currentTourist.citizenShip,
                                        pleaceHolder: "Гражданство", answer: {})
                    TextFieldForTourist(textField: $currentTourist.numberPassport,
                                        pleaceHolder: "Номер загранпаспорта", answer: {})
                    TextFieldForTourist(textField: $currentTourist.validityPeriodPassport,
                                       pleaceHolder: "Срок действия загранпаспорта",
                                        type: .numberPad, answer: {})
                     */
                }
            }
        }
        .padding(.horizontal, 13)
        .vLeading()
        .padding(.vertical, 16)
        .background(Color.white)
        .cornerRadius(15)
    }
    
    func isEmpty(_ text: Binding<String>) -> Bool {
        if !text.wrappedValue.isEmpty {
            return true
        } else {
            return false
        }
    }
}

protocol AnswerField {
    func answerField(text: String) -> Bool
}

struct TextFieldForTourist: View {
    

    @Binding var textField: String
    @State var isValid: Bool = false

    
    let pleaceHolder: String
    var type: UIKeyboardType = .default
    
    var body: some View {
        ZStack(alignment: .leading) {
            if textField.isEmpty {
                Text(pleaceHolder)
                    .modifier(HeightModifier(size: 17,
                                             lineHeight: 110,
                                             weight: .regular))
                    .foregroundColor(.c_A9ABB7)
            }
            HStack {
                TextField("", text: $textField)
                    .modifier(HeightModifier(size: 17,
                                             lineHeight: 110,
                                             weight: .regular))
                    .tracking(0.1)
                    .foregroundColor(.c_14142B)
                    .tint(.black)
                    .keyboardType(type)
                Circle()
                    .fill(isValid ? Color.green : Color.red)
                    .frame(width: 10, height: 10)
            }
        }
        .vLeadingAndBack(isValid)
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

struct TextFieldForTouristWithPlaceholder: View {
    
    
    @State var isValid: Bool = false
    @Binding var textField: String
    
    let title: String
    
    var body: some View {
        VStack(alignment: .leading, spacing: 0) {
            Text(title)
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
        .vLeadingAndBack(isValid)
    }
}




#if DEBUG
struct CardTourist_Previews: PreviewProvider {
    static var previews: some View {
        BookingView()
    }
}
#endif

