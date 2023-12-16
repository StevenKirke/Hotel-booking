//
//  CarouselImages.swift
//  HotelBooking
//
//  Created by Steven Kirke on 10.09.2023.
//

import SwiftUI

struct CarouselImages: View {

	@State var currentIndex: Int = 0
	@State var images: [String] = []

	var body: some View {
		ZStack(alignment: .bottom) {
			ScrollViewReader { geoHotels in
				ScrollView(.horizontal, showsIndicators: false) {
					HStack(spacing: 32) {
						ForEach(images.indices, id: \.self) { index in
							let image = images[index]
							ImageHotel(currentIndex: $currentIndex,
									   image: image,
									   index: index)
							.modifier(OffsetsModefier(currentIndex: $currentIndex,
													  index: index))
						}
						.padding(.horizontal, 16)
					}
				}
				.coordinateSpace(name: "SCROLL")
				.onChange(of: currentIndex, perform: { _ in
					DispatchQueue.main.async {
						withAnimation(.easeInOut) {
							geoHotels.scrollTo(currentIndex, anchor: .topTrailing)
						}
					}
				})
			}
			HStack(spacing: 5) {
				ForEach(images.indices, id: \.self) { index in
					CircleIndicator(currentIndex: $currentIndex, index: index)
				}
			}
			.padding(.vertical, 5)
			.padding(.horizontal, 10)
			.background(
				Color.white
			)
			.cornerRadius(7)
			.padding(.bottom, 8)
		}
	}
}

struct ImageHotel: View {

	@Binding var currentIndex: Int

	var image: String = ""
	let index: Int
	let width = UIScreen.main.bounds.width - 32

	var height: CGFloat {
		CGFloat(Int(width * (1 - 25 / 100)))
	}

	var body: some View {
		CustomImage(image: image)
			.frame(width: width, height: height)
			.id("\(index)")
			.mask({
				RoundedRectangle(cornerRadius: 15)
			})
	}
}

struct CircleIndicator: View {

	@Binding var currentIndex: Int
	let index: Int

	var body: some View {
		Circle()
			.fill(currentIndex == index ? Color.black : Color.black22)
			.frame(width: 7, height: 7)
	}
}

#if DEBUG
struct CarouselImages_Previews: PreviewProvider {
	static var previews: some View {
		CarouselImages()
	}
}
#endif
