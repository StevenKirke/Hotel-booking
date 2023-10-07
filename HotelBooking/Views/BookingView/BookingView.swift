//
//  BookingView.swift
//  HotelBooking
//
//  Created by Steven Kirke on 10.09.2023.
//

import SwiftUI


struct BookingView: View {
    
    @ObservedObject var contactVM: ContactViewModel = ContactViewModel()
    @ObservedObject var specification: GetSpecificationHotelViewModel = GetSpecificationHotelViewModel()
    @ObservedObject var touristList: TouristCartViewModel = TouristCartViewModel()
    
    @Environment(\.presentationMode) var returnRoomsView: Binding<PresentationMode>
    
    @FocusState private var nameFields: FieldForCard?
    
    @State private var submitPressed = false
    @State var isPairView: Bool = false
    
    var name: String = ""

    
    var body: some View {
        VStack(spacing: 0) {
            CustomNavigationTabBar(label: "Бронирование",
                                   content:
                                    ButtonForNavigationTabBar(action: {
                self.returnRoomsView.wrappedValue.dismiss()
            })
            )
            ScrollView(.vertical ,showsIndicators: false) {
                VStack(spacing: 8) {
                    if specification.isLoadDesc {
                        HeaderBooking(info: specification.desc)
                        InformationView(info: specification.desc)
                    }
                    
                    BuyerInformation(nameFields: $nameFields,
                                     textPhone: $touristList.phoneMask,
                                     textEmail: $touristList.eMail,
                                     submitPressed: $submitPressed,
                                     action: {
                        DispatchQueue.main.async {
                           self.contactVM.getContactList()
                        }
                    })
                    
                    ForEach(touristList.touristList.indices, id: \.self) { index in
                        let nameCard = touristList.nameTourist[index] + " турист"
                        let zeroIndex = index == 0 ? true : false
                        CardTourist(nameFields: $nameFields, isShow: zeroIndex, currentTourist: $touristList.touristList[index], title: nameCard, submitPressed: $submitPressed)
                    }
                    
                    AddCardTourist(title: "Добавить туриста", action: {
                        self.touristList.addTourist()
                    })
                    
                    if specification.isLoadDesc {
                        CalculatePrice(price: specification.totalPrice)
                    }
                    if specification.isLoadDesc {
                        let assambly = "Оплатить " + specification.totalPrice.totalPrice
                        CustomTapBar(text: assambly, action: {
                            self.isPairView = true
                        })
                        .navigationDestination(isPresented: $isPairView) {
                            PaidView()
                        }
                    }
                }
            }
        }
        .background(Color.c_F6F6F9)
        .edgesIgnoringSafeArea(.top)
        .navigationBarTitle("", displayMode: .inline)
        .navigationBarBackButtonHidden(true)
        .onAppear() {

        }
        .onSubmit {
            submitPressed = true
        }
        .sheet(isPresented: $contactVM.showingOptions, content: {
            ActionSheetContacts(contactList: contactVM.contactList,
                                phone: $touristList.phone,
                                phoneMask: $touristList.phoneMask,
                                showingOptions: $contactVM.showingOptions)
        })
    }
}



struct ActionSheetContacts: View {
    
    var contactList: [Contact]

    @Binding var phone: String
    @Binding var phoneMask: String
    @Binding var showingOptions: Bool
    
    var body: some View {
        VStack(spacing: 10) {
            HStack(alignment: .center, spacing: 0) {
                Text("Контакты")
                    .modifier(HeightModifier(size: 22, lineHeight: 120, weight: .medium))
                    .frame(maxWidth: .infinity, alignment: .leading)
                    .foregroundColor(.black)
                Button(action: {
                    self.closeActionView()
                }) {
                    Image.closeSquare
                        .resizable()
                        .frame(width: 24,height: 24)
                        .foregroundColor(.black)
                }
            }
            .padding(.horizontal, 16)
            .padding(.top, 16)
            ScrollView(.vertical, showsIndicators: false) {
                ForEach(contactList.indices, id: \.self) { list in
                    let contact = contactList[list]
                    Button(action: {
                        DispatchQueue.main.async {
                            self.phone = contact.number
                            self.phoneMask = contact.numberMask
                            self.closeActionView()
                        }
                    }) {
                        HStack(spacing: 0) {
                            Text(contact.name)
                                .modifier(HeightModifier(size: 16,
                                                         lineHeight: 120,
                                                         weight: .medium))
                                .foregroundColor(.c_2C3035)
                            Spacer()
                            Text(contact.numberMask)
                                .modifier(HeightModifier(size: 16,
                                                         lineHeight: 120,
                                                         weight: .medium))
                                .foregroundColor(.c_828796)
                        }
                        .padding(.vertical, 10)
                    }
                    if list != contactList.count - 1 {
                        createDivider()
                    }
                }
                .padding(.horizontal, 16)
            }
            .background(Color.c_FBFBFC)
            .cornerRadius(15)
        }
        .background(Color.white)
        
    }
    
    @ViewBuilder
    func createDivider() -> some View {
        Rectangle()
            .fill(Color.c_828796_15)
            .frame(height: 1)
            .offset(x: -15)
    }
    
    private func closeActionView() {
        DispatchQueue.main.async {
            self.showingOptions.toggle()
        }
    }
}
 

struct HeaderBooking: View {
    
    var info: Specification
    
    var body: some View {
        VStack(alignment: .leading, spacing: 8) {
            GradeElement(grade: info.rating)
            Text(info.hotelName)
                .modifier(HeightModifier(size: 22, lineHeight: 120, weight: .medium))
                .lineLimit(2)
                .foregroundColor(.black)
            Button(action: {}) {
                Text(info.hotelAdress)
                    .modifier(HeightModifier(size: 14, lineHeight: 120, weight: .medium))
                    .lineLimit(1)
                    .foregroundColor(.c_0D72FF)
            }
            .disabled(true)
        }
        .solidBlackground()
    }
}

struct InformationView: View {
    
    var info: Specification
    
    var body: some View {
        VStack(alignment: .leading, spacing: 16) {
            LabelForInfo(title: "Вылет из", text: info.departure)
            LabelForInfo(title: "Страна, город", text: info.arrivalCountry)
            LabelForInfo(title: "Даты", text: info.datas)
            LabelForInfo(title: "Кол-во ночей", text: info.numberOfNights)
            LabelForInfo(title: "Отель", text: info.hotelName)
            LabelForInfo(title: "Номер", text: info.room)
            LabelForInfo(title: "Питание", text: info.nutrition)
        }
        .solidBlackground()
    }
}

struct CalculatePrice: View {
    
    var price: TotalPrice
    
    var body: some View {
        VStack(alignment: .leading, spacing: 16) {
            LabelForPrice(title: "Тур", text: price.tourPrice)
            LabelForPrice(title: "Топливный сбор", text: price.fuelCharge)
            LabelForPrice(title: "Сервисный сбор", text: price.serviceCharge)
            LabelForPrice(title: "К оплате", text: price.totalPrice, isSumm: true)
        }
        .solidBlackground()
    }
}


struct BuyerInformation: View {
    
    private let workToNumber: WorkToNumber = WorkToNumber()
    
    @FocusState.Binding var nameFields: FieldForCard?
    @State var isValid: Bool = true
    @Binding var textPhone: String
    @Binding var textEmail: String {
        if textEmail.isEmpty {
            self.isValid = true
        }
    }
    @Binding var submitPressed: Bool

    var action: () -> Void
    
    var body: some View {
        VStack(alignment: .leading, spacing: 8) {
            Text("Информация о покупателе")
                .modifier(HeightModifier(size: 22, lineHeight: 120, weight: .medium))
                .foregroundColor(.black)
                .padding(.bottom, 12)
            ZStack(alignment: .trailing) {
                TextFieldForTouristWithPlaceholder(textField: $textPhone,
                                                   focus: $nameFields,
                                                   nameField: .phome,
                                                   submitPressed: submitPressed)
                Button(action: action) {
                    Image(systemName: "list.bullet")
                        .resizable()
                        .frame(width: 20, height: 20)
                        .foregroundColor(.c_0D72FF).opacity(0.5)
                }
                .padding(.trailing, 10)
            }
            VStack(spacing: 4) {
                TextFieldForTouristWithPlaceholder(textField: $textEmail,
                                                   focus: $nameFields,
                                                   nameField: .eMail,
                                                   submitPressed: submitPressed)
                if !isValid {
                    HStack(spacing: 5) {
                        Image(systemName: "asterisk")
                            .font(.system(size: 6))
                        Text("Не верный адрес электронной почты")
                            .modifier(HeightModifier(size: 12,
                                                     lineHeight: 120,
                                                     weight: .regular))
                    }
                    .foregroundColor(Color.c_EB5757)
                    .padding(.leading, 16)
                    .frame(maxWidth: .infinity, alignment: .leading)
                }
            }
            .onChange(of: textEmail) {
                if self.workToNumber.textFieldValidatorEmail($0) {
                    self.isValid = true
                } else {
                    self.isValid = false
                }
            }
            Text("Эти данные никому не передаются. После оплаты мы вышли чек на указанный вами номер и почту")
                .modifier(HeightModifier(size: 14, lineHeight: 120, weight: .regular))
                .foregroundColor(.c_828796)
        }
        .solidBlackground()
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
        print(emailPredicate)
        return emailPredicate.evaluate(with: string)
    }
}




struct LabelForInfo: View {
    
    let title: String
    let text: String
    
    var body: some View {
        HStack(alignment: .top, spacing: 40) {
            Text(title)
                .modifier(HeightModifier(size: 16, lineHeight: 120, weight: .regular))
                .foregroundColor(.c_828796)
                .fixedSize()
                .frame(width: 100, alignment: .leading)
            Text(text)
                .modifier(HeightModifier(size: 16, lineHeight: 120, weight: .regular))
                .foregroundColor(.black)
        }
    }
}


struct LabelForPrice: View {
    
    let title: String
    let text: String
    var isSumm: Bool = false
    
    var body: some View {
        HStack(alignment: .top, spacing: 40) {
            Text(title)
                .modifier(HeightModifier(size: 16, lineHeight: 120, weight: .regular))
                .foregroundColor(.c_828796)
                .frame(maxWidth: .infinity, alignment: .leading)
            Text(text)
                .modifier(HeightModifier(size: 16, lineHeight: 120,
                                         weight: isSumm ? .semibold : .regular))
                .foregroundColor(isSumm ? .c_0D72FF : .black)
                .frame(maxWidth: .infinity, alignment: .trailing)
        }
    }
}


#if DEBUG
struct BookingView_Previews: PreviewProvider {
    static var previews: some View {
        BookingView()
    }
}
#endif


