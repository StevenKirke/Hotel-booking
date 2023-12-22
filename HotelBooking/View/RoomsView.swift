//
//  RoomsView.swift
//  HotelBooking
//
//  Created by Steven Kirke on 04.09.2023.
//

import SwiftUI

struct RoomsView: View {

	@Environment(\.presentationMode) var returnHotelView: Binding<PresentationMode>

	@ObservedObject var roomsVM: RoomsViewModel = RoomsViewModel(networkService: NetworkRequest())

	@Binding var isMainView: Bool

	let nameHotel: String

	var body: some View {
		VStack(spacing: 0) {
			CustomNavigationTabBar(
				label: nameHotel,
				content: ButtonForNavigationTabBar(action: { returnHotelSceneView() })
			)
			if roomsVM.isLoadRoom {
				ScrollView(.vertical, showsIndicators: false) {
					VStack(spacing: 8) {
						ForEach(roomsVM.displayHRoom.indices, id: \.self) { index in
							RoomCard(isMainView: $isMainView, room: roomsVM.displayHRoom[index])
						}
					}
				}
			} else {
				// Добавить Sceleton View
				Spacer()
			}
		}
		.background(Color.ColorF6F6F9)
		.edgesIgnoringSafeArea(.all)
		.navigationBarTitle("", displayMode: .inline)
		.navigationBarBackButtonHidden(true)
		.onAppear {
			roomsVM.getRoomData()
		}
	}

	private func returnHotelSceneView() {
		DispatchQueue.main.async {
			self.returnHotelView.wrappedValue.dismiss()
		}
	}
}

///  'RoomCard' Карточка комнаты`
/// - Parameters:
/// 	- isNumberView: Bool
/// - Note: Маркер переходв на другое View
private struct RoomCard: View {

	@State var isNumberView: Bool = false
	@Binding var isMainView: Bool

	var room: RoomModel.DisplayModelRoom

	var body: some View {
		VStack(spacing: 8) {
			CarouselImages(images: room.images)
			VStack(alignment: .leading, spacing: 8) {
				Text(room.name)
					.modifier(HeightModifier(size: 22, lineHeight: 120, weight: .medium))
					.foregroundColor(.black)
				VStack(spacing: 8) {
					TagCloudView(array: room.peculiarities)
				}
				Button(action: {}, label: {
					HStack(spacing: 2) {
						Text("Подробнее о номере")
							.modifier(HeightModifier(size: 16,
													 lineHeight: 120,
													 weight: .medium))
						Image(systemName: "chevron.right")
							.frame(width: 24, height: 24)
					}
					.foregroundColor(.customBlue)
					.padding(.vertical, 5)
					.padding(.leading, 10)
					.padding(.trailing, 2)
					.background(Color.blue10)
					.cornerRadius(5)

				})
				HStack(alignment: .firstTextBaseline, spacing: 7) {
					Text("\(room.price)")
						.modifier(HeightModifier(size: 30, lineHeight: 120, weight: .semibold))
						.foregroundColor(.black)
					Text(room.pricePer)
						.modifier(HeightModifier(size: 16, lineHeight: 120, weight: .regular))
						.foregroundColor(.customOmbreGray)
				}
				.padding(.vertical, 8)
				Button(action: {
					self.isNumberView = true
				}, label: {
					Text("Выбрать номер")
						.modifier(HeightModifier(size: 16,
												 lineHeight: 110,
												 weight: .medium))
						.tracking(0.1)
						.foregroundColor(.white)
						.frame(maxWidth: .infinity, maxHeight: 48)
						.frame(height: 48)
						.background(Color.customBlue)
						.cornerRadius(15)
						.navigationDestination(isPresented: $isNumberView) {
							BookingView(isMainView: $isMainView)
						}
				})
			}
			.padding(.horizontal, 16)
		}
		.padding(.vertical, 16)
		.background(
			RoundedRectangle(cornerRadius: 12)
				.fill(Color.white)
		)
	}
}

#if DEBUG
struct NumberView_Previews: PreviewProvider {
	static var previews: some View {
		RoomsView(isMainView: .constant(false), nameHotel: "Steigenberger Makadi")
	}
}
#endif
