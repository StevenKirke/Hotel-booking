//
//  AboutHotel.swift
//  HotelBooking
//
//  Created by Steven Kirke on 05.09.2023.
//

import SwiftUI



struct AboutHotel: View {
    
    @State var hotelDescroption: AboutTheHotel
    
    var body: some View {
        VStack(alignment: .leading, spacing: 16) {
            Text("Об отеле")
                .modifier(HeightModifier(size: 22, lineHeight: 120, weight: .medium))
                .frame(maxWidth: .infinity, alignment: .leading)
                .foregroundColor(.black)
            VStack(spacing: 0) {
                TagCloudView(array: hotelDescroption.peculiarities)
            }
            .padding(.bottom, -2)
            HStack(alignment: .center, spacing: 0) {
                Text(hotelDescroption.description)
                    .foregroundColor(.c_000000_90)
                    .multilineTextAlignment(.leading)
                    .modifier(HeightModifier(size: 16,
                                             lineHeight: 120,
                                             weight: .regular))
            }
            RangeServices()
        }
        .frame(maxWidth: .infinity, alignment: .leading)
        .padding(.horizontal, 16)
        .padding(.vertical, 16)
        .background(
            RoundedRectangle(cornerRadius: 12)
                .fill(Color.white)
        )
    }
}

struct RangeServices: View {
    
    @State var widthSeparator: CGFloat = .zero
    
    var body: some View {
        VStack(alignment: .trailing, spacing: 0) {
            ForEach(RangeServicesButtons.allCases, id: \.self) { item in
                ButtonServices(widthSeparator: $widthSeparator, service: item)
                if item != RangeServicesButtons.allCases.last {

                }
            }
        }
        .background(Color.c_FBFBFC)
        .cornerRadius(15)
    }
}



struct ButtonServices: View {
    
    @Binding var widthSeparator: CGFloat
    var service: RangeServicesButtons
    
    var body: some View {
        HStack(spacing: 12) {
            service.image
                .resizable()
                .frame(width: 24,height: 24)
                .foregroundColor(.black)
            HStack(spacing: 0) {
                VStack(alignment: .leading, spacing: 0) {
                    Text(service.title)
                        .modifier(HeightModifier(size: 16, lineHeight: 120, weight: .medium))
                        .foregroundColor(.c_2C3035)
                    Text(service.discription)
                        .modifier(HeightModifier(size: 14, lineHeight: 120, weight: .medium))
                        .foregroundColor(.c_828796)
                }
                Spacer()
                Button(action: {}) {
                    Image(systemName: "chevron.right")
                        .frame(width: 24,height: 24)
                        .font(.system(size: 16))
                        .foregroundColor(.c_2C3035)
                }
            }
            .coordinateSpace(name: "Devider")
            .overlay(
                GeometryReader { proxy in
                    Color.clear
                        .preference(key: OffsetKey.self,
                                    value: proxy.frame(in: .named("Devider")))
                }
                    .onPreferenceChange(OffsetKey.self) {
                        self.widthSeparator = $0.width
                    }
            )
        }
        .padding(15)
    }
}


#if DEBUG
struct AboutHotel_Previews: PreviewProvider {
    static var previews: some View {
        MainView()
    }
}
#endif






