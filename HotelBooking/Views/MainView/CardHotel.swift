//
//  CardHotel.swift
//  HotelBooking
//
//  Created by Steven Kirke on 05.09.2023.
//

import SwiftUI

struct CardHotel: View {
    
    @State var hotel: HotelTitle
    @State var currentIndex: Int = 0
    
    var body: some View {
        VStack(spacing: 16) {
            CarouselImages(images: hotel.images)
            TitleWithGrade(hotel: $hotel, action: {})
        }
        .padding(.vertical, 16)
        .background(
            RoundedCornersShape(corners: [.bottomLeft, .bottomRight], radius: 12)
                .fill(Color.white)
        )
    }
}

struct TitleWithGrade: View {
        
    @Binding var hotel: HotelTitle
    var action: () -> Void
    
    var body: some View {
        VStack(alignment: .leading, spacing: 8) {
            GradeElement(grade: hotel.raiting)
            Text(hotel.name)
                .modifier(HeightModifier(size: 22, lineHeight: 120, weight: .medium))
                .lineLimit(2)
                .foregroundColor(.black)
            Button(action: action) {
                Text(hotel.adress)
                    .modifier(HeightModifier(size: 14, lineHeight: 120, weight: .medium))
                    .lineLimit(1)
                    .foregroundColor(.c_0D72FF)
            }
            .disabled(true)
            HStack(alignment: .firstTextBaseline, spacing: 8) {
                Text(hotel.minimalPrice)
                    .modifier(HeightModifier(size: 30, lineHeight: 120, weight: .semibold))
                    .foregroundColor(.black)
                Text(hotel.priceForIt)
                    .modifier(HeightModifier(size: 16, lineHeight: 120, weight: .regular))
                    .foregroundColor(.c_828796)
            }
            .padding(.top, 8)
        }
        .frame(maxWidth: .infinity, alignment: .leading)
        .padding(.horizontal, 16)
    }
}



#if DEBUG
struct CardHotel_Previews: PreviewProvider {
    
    static var previews: some View {
        MainView()
    }
}
#endif


