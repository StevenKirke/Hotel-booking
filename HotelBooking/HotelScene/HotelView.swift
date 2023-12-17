//
//  MainView.swift
//  HotelBooking
//
//  Created by Steven Kirke on 04.09.2023.
//

import SwiftUI

struct HotelView: View {
	@ObservedObject var hotelVM: HotelViewModel = HotelViewModel()
	@State var isMainView: Bool = false
	// Connect safeArea, secure safe areas

	var body: some View {
		NavigationStack {
			if hotelVM.isLoadData {
				VStack(spacing: 0) {
					CustomNavigationTabBar(label: "Отель", content: EmptyView())
					AssamblyHotelView(hotelVM: hotelVM)
					CustomTapBar(label: "К выбору номера", action: actionButton)
				}
				.edgesIgnoringSafeArea(.all)
			}
		}
		.navigationBarTitle("", displayMode: .inline)
		.navigationBarBackButtonHidden(true)
		.navigationDestination(isPresented: $isMainView) {
			//RoomsView(isMainView: $isMainView, nameHotel: $hotelVM.hotel.name)
		}
	}
}

// Action UI Element
private extension HotelView {
	private func actionButton() {
		DispatchQueue.main.async {
			self.isMainView = true
		}
	}
}

///  'AssamblyHotelView' Собирает карточку текущего отеля
/// - Parameters:
/// 	- hotelVM: 'HotelModelEnum.DisplayModelHotel'
/// - Note: Отображает заголовок с горизонтальным скролом изображений
/// 		названием, ценой и описанием отеля
private struct AssamblyHotelView: View {

	var hotelVM: HotelViewModel

	var body: some View {
		ScrollView(.vertical, showsIndicators: false) {
			if let headerHotel = hotelVM.displayHotelModel {
				HeaderHotel(headerHotel: headerHotel)
				AboutHotel(hotelDescroption: headerHotel.aboutTheHotel)
			}
		}
		.mask {
			RoundedCornersShape(corners: [.bottomLeft, .bottomRight], radius: 12)
		}
	}
}

#if DEBUG
struct MainView_Previews: PreviewProvider {
	static var previews: some View {
		HotelView()
	}
}
#endif
