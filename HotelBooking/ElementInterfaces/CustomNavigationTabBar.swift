//
//  CustomNavigationTabBar.swift
//  HotelBooking
//
//  Created by Steven Kirke on 05.09.2023.
//

import SwiftUI

struct CustomNavigationTabBar<Content: View>: View {
    var label: String = ""
    var content: Content
    
    var body: some View {
        ZStack {
            Text(label)
                .modifier(HeightModifier(size: 18, lineHeight: 120, weight: .medium))
                .lineLimit(1)
            content
        }
        .padding(.bottom, 20)
        .frame(maxWidth: .infinity, maxHeight: 101, alignment: .bottom)
        .foregroundColor(.black)
        .background(.white)
    }
}


struct ButtonForNavigationTabBar: View {
    
    var action: () -> Void
    
    var body: some View {
        HStack(spacing: 0) {
            Button(action: action) {
                Image(systemName: "chevron.left")
                    .font(.system(size: 18))
            }
            .padding(.leading, 27)
            Spacer()
        }
    }
}

#if DEBUG
struct CustomNavigationTabBarPreviews: PreviewProvider {
    static var previews: some View {
        CustomNavigationTabBar(content: ButtonForNavigationTabBar(action: {}))
    }
}
#endif

