//
//  Texts.swift
//  HotelBooking
//
//  Created by Steven Kirke on 04.09.2023.
//

import SwiftUI

extension Text {
    
    func customFont(_ size: CGFloat, _ weight: Font.Weight) -> some View {
        switch weight {
            case .regular:
                return self.font(Font.custom("SFProDisplay-Regular", size: size))
            case .medium:
                return self.font(Font.custom("SFProDisplay-Medium", size: size))
            case .semibold:
                return self.font(Font.custom("SFProDisplay-Semibold", size: size))
            default:
                return self.font(.system(size: size))
        }
    }
    


}



struct HeightModifier: ViewModifier {
    
    var size: CGFloat = 16
    var lineHeight: CGFloat = 100
    var weight: Font.Weight = .regular
    
    func body(content: Content) -> some View {
        let calcPrecent: CGFloat = (size / 100) * lineHeight
        let padding: CGFloat = (calcPrecent - size) / 2
        
        return content
            .font(Font.custom(answerFont(weight), size: size))
            .lineSpacing(padding)
            .padding(.vertical, padding)
    }
    
    
    private func answerFont( _ weight: Font.Weight) -> String {
        switch weight {
            case .regular:
                return "SFProDisplay-Regular"
            case .medium:
                return "SFProDisplay-Medium"
            case .semibold:
                return "SFProDisplay-Semibold"
            default:
                return ""
        }
    }
    
}
