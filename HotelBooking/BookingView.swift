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
	@ObservedObject var mvTourist: TouristCartViewModel = TouristCartViewModel()

	@Environment(\.presentationMode) var returnRoomsView: Binding<PresentationMode>

	@State var isPairView: Bool = false
	@Binding var isMainView: Bool

	var idRoom: Int

	var body: some View {
		VStack(spacing: 0) {
			CustomNavigationTabBar(
				label: "Бронирование",
				content:
					ButtonForNavigationTabBar(
						action: { returnView() })
			)
			ScrollView(.vertical, showsIndicators: false) {
				VStack(spacing: 8) {
					if specification.isLoadDesc {
						HeaderBooking(info: specification.desc, action: {})
						InformationView(info: specification.desc)
					}
					BuyerInformation(
						textPhone: $mvTourist.phone,
						textEmail: $mvTourist.eMail,
						action: {
							contactVM.getContactList()
						}
					)
					.onChange(of: mvTourist.phone) { value in
						mvTourist.phone.formatPhoneMumberDateString()
						if value.count > 18 {
							UIApplication.shared.endEditing()
						}
					}
					ForEach(mvTourist.tourists.indices, id: \.self) { index in
						let nameCard = mvTourist.nameTourist[index] + " турист"
						let zeroIndex = index == 0 ? true : false
						let lastIndex = index == mvTourist.tourists.count - 1 && index != 0 ? false : true
						CardTourist(
							title: nameCard,
							isShowRemove: lastIndex,
							isShow: zeroIndex,
							cardTourist: $mvTourist.tourists[index],
							remove: { removeCart() }
						)
					}
					AddCardTourist(title: "Добавить туриста", action: {
						DispatchQueue.main.async {
							withAnimation(.easeInOut) {
								self.mvTourist.addTourist()
							}
						}
					})
					if specification.isLoadDesc {
						CalculatePrice(price: specification.totalPrice)
					}
					if specification.isLoadDesc {
						let assambly = "Оплатить " + specification.totalPrice.totalPrice
						CustomTapBar(label: assambly, action: {
							self.isPairView.toggle()
						})
						.navigationDestination(isPresented: $isPairView) {
							PaidView(isMainView: $isMainView)
						}
					}
				}
			}
		}
		.background(Color.ColorF6F6F9)
		.edgesIgnoringSafeArea(.top)
		.navigationBarTitle("", displayMode: .inline)
		.navigationBarBackButtonHidden(true)
		.sheet(isPresented: $contactVM.showingOptions, content: {
			ContactsView(contactList: contactVM.contactList,
						 phone: $mvTourist.phone,
						 showingOptions: $contactVM.showingOptions)
		})
		.onAppear {
			self.specification.getSpecification(idRoom)
		}
	}

	private func removeCart() {
		DispatchQueue.main.async {
			withAnimation(.easeInOut) {
				self.mvTourist.removeTourist()
			}
		}
	}

	private func returnView() {
		self.returnRoomsView.wrappedValue.dismiss()
	}
}

struct HeaderBooking: View {

	var info: Specification
	var action: () -> Void

	var body: some View {
		VStack(alignment: .leading, spacing: 8) {
			GradeElement(raiting: info.rating)
			Text(info.hotelName)
				.modifier(HeightModifier(size: 22, lineHeight: 120, weight: .medium))
				.lineLimit(2)
				.foregroundColor(.black)
			Button(action: action) {
				Text(info.hotelAdress)
					.modifier(HeightModifier(size: 14, lineHeight: 120, weight: .medium))
					.lineLimit(1)
					.foregroundColor(.customBlue)
			}
			.disabled(true)
		}
		.solidBlackground()
	}
}

struct InformationView: View {

	let info: Specification

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

	let price: TotalPrice

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

	@State var isValidEmail: Bool = true
	@Binding var textPhone: String
	@Binding var textEmail: String
	@FocusState private var focus: NameFields?
	var action: () -> Void

	var body: some View {
		return VStack(alignment: .leading, spacing: 8) {
			Text("Информация о покупателе")
				.modifier(HeightModifier(size: 22, lineHeight: 120, weight: .medium))
				.foregroundColor(.black)
				.padding(.bottom, 12)
			ZStack(alignment: .trailing) {
				TextFieldForTouristWithPlaceholder(
					placeHolder: "Номер телефона",
					currentField: .phone,
					type: .phonePad,
					isEmpty: false,
					textField: $textPhone,
					focus: $focus
				)
				Button(action: action) {
					Image(systemName: "list.bullet")
						.resizable()
						.frame(width: 20, height: 20)
						.foregroundColor(.customBlue).opacity(0.5)
				}
				.padding(.trailing, 10)
			}
			VStack(spacing: 4) {
				TextFieldForTouristWithPlaceholder(
					placeHolder: "Почта",
					currentField: .eMail,
					type: .emailAddress,
					isEmpty: false,
					textField: $textEmail,
					focus: $focus
				)
				.onSubmit {
					if textEmail.textFieldValidatorEmail() {
						self.isValidEmail = true
					} else {
						self.isValidEmail = false
					}
				}
				if !isValidEmail && !textEmail.isEmpty {
					IsValidEMail()
				}

			}
			Text("Эти данные никому не передаются. После оплаты мы вышли чек на указанный вами номер и почту")
				.modifier(HeightModifier(size: 14, lineHeight: 120, weight: .regular))
				.foregroundColor(.customOmbreGray)
		}
		.solidBlackground()
	}
}

struct IsValidEMail: View {
	var body: some View {
		HStack(spacing: 5) {
			Image(systemName: "asterisk")
				.font(.system(size: 6))
			Text("Не верный адрес электронной почты")
				.modifier(HeightModifier(
					size: 12,
					lineHeight: 120,
					weight: .regular)
				)
		}
		.foregroundColor(Color.customRed)
		.padding(.leading, 16)
		.frame(maxWidth: .infinity, alignment: .leading)
	}
}

struct LabelForInfo: View {

	let title: String
	let text: String

	var body: some View {
		HStack(alignment: .top, spacing: 40) {
			Text(title)
				.modifier(HeightModifier(size: 16, lineHeight: 120, weight: .regular))
				.foregroundColor(.customOmbreGray)
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
				.foregroundColor(.customOmbreGray)
				.frame(maxWidth: .infinity, alignment: .leading)
			Text(text)
				.modifier(HeightModifier(size: 16, lineHeight: 120,
										 weight: isSumm ? .semibold : .regular))
				.foregroundColor(isSumm ? .customBlue : .black)
				.frame(maxWidth: .infinity, alignment: .trailing)
		}
	}
}

#if DEBUG
struct BookingView_Previews: PreviewProvider {
	static var previews: some View {
		BookingView(isMainView: .constant(false), idRoom: 0)
	}
}
#endif
