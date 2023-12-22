//
//  BookingView.swift
//  HotelBooking
//
//  Created by Steven Kirke on 20.12.2023..
//

import SwiftUI

struct BookingView: View {

	@Environment(\.presentationMode) var returnRoomsView: Binding<PresentationMode>

	@ObservedObject var bookingVM: BookingViewModel = BookingViewModel(networkService: NetworkRequest())

	@State var isPairView: Bool = false
	@Binding var isMainView: Bool

	var body: some View {
		ZStack {
			Color.ColorF6F6F9
			if let model = bookingVM.displayBooking {
				VStack(spacing: 8) {
					CustomNavigationTabBar(
						label: "Бронирование",
						content: ButtonForNavigationTabBar(action: {returnView()})
					)
					ScroolBlock(model: model)
					CustomTapBar(label: bookingVM.displayBooking?.pay ?? "", action: {})
				}
			}
		}
		.edgesIgnoringSafeArea(.all)
		.navigationBarTitle("", displayMode: .inline)
		.navigationBarBackButtonHidden(true)
		.onAppear {
			bookingVM.getBokingData()
		}
		.navigationDestination(isPresented: $isPairView) {
			PaidView(isMainView: $isMainView)
		}
	}

	private func returnView() {
		DispatchQueue.main.async {
			self.returnRoomsView.wrappedValue.dismiss()
		}
	}
}

private struct ScroolBlock: View {

	var model: InfoRoom.DisplayModelBooking

	var body: some View {
		ScrollView(.vertical, showsIndicators: false) {
			GradeAndDescriptionBooking(modelBiooking: model)
			BayerView()
			PriceCard(price: model.price)
		}
	}

	private func pairView() {
		DispatchQueue.main.async {
			print("PAIR SCENE")
		}
	}
}

#if DEBUG
struct BookingView_Previews: PreviewProvider {
	static var previews: some View {
		BookingView(isMainView: .constant(false))
	}
}
#endif
