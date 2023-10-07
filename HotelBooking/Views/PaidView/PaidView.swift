//
//  PaidView.swift
//  HotelBooking
//
//  Created by Steven Kirke on 05.10.2023.
//

import SwiftUI

struct PaidView: View {
    
    @Environment(\.presentationMode) var returnBookingView: Binding<PresentationMode>
    
    var body: some View {
        VStack(spacing: 0) {
            CustomNavigationTabBar(label: "Заказ оплачен",
                                   content:
                                    ButtonForNavigationTabBar(action: returnView)
            )
            PaidContent()
            CustomTapBar(text: "Супер!", action: {})
        }
        .background(Color.white)
        .edgesIgnoringSafeArea(.vertical)
        .navigationBarTitle("", displayMode: .inline)
        .navigationBarBackButtonHidden(true)
    }
    
    private func returnView() {
        self.returnBookingView.wrappedValue.dismiss()
    }
}

struct PaidContent: View {
    
    @ObservedObject var paidVM: PaidViewModel = PaidViewModel()
    
    var body: some View {
        VStack(spacing: 20) {
            Image.partyPopper
                .resizable()
                .frame(width: 44, height: 44)
                .background(
                    Circle()
                        .fill(Color.c_F6F6F9)
                        .frame(width: 94, height: 94)
                )
            Text("Ваш заказ принят в работу")
                .modifier(HeightModifier(size: 22, lineHeight: 120, weight: .medium))
                .foregroundColor(.black)
                .padding(.top, (25 + 12))
            Text("Подтверждение заказа №\(paidVM.code) может занять некоторое время (от 1 часа до суток). Как только мы получим ответ от туроператора, вам на почту придет уведомление.")
                .modifier(HeightModifier(size: 16, lineHeight: 120, weight: .regular))
                .foregroundColor(Color.c_828796)
                .multilineTextAlignment(.center)
                .padding(.horizontal, 23)
        }
        .frame(maxHeight: .infinity)
    }
}


#if DEBUG
struct PaidView_Previews: PreviewProvider {
    static var previews: some View {
       PaidView()
    }
}
#endif
 
