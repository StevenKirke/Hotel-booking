//
//  MainView.swift
//  HotelBooking
//
//  Created by Steven Kirke on 04.09.2023.
//

import SwiftUI

class GlobalModel: ObservableObject {
    
    @Published var safeArea: (top: CGFloat, bottom: CGFloat)
    
    init() {
        self.safeArea = (0, 0)
    }
}

struct MainView: View {
    
    let globalModel = GlobalModel()
    
    @State var isMainView: Bool = false
    
    var body: some View {
        NavigationStack {
            ZStack {
                GeometryReader { geo in
                    Color.c_F6F6F9
                        .edgesIgnoringSafeArea(.all)
                        .onAppear {
                            self.globalModel.safeArea = (geo.safeAreaInsets.top, geo.safeAreaInsets.bottom)
                        }
                }
                VStack(spacing: 0) {
                    CustomNavigationTabBar(label: "Отель", content: EmptyView())
                    ScrollView(.vertical ,showsIndicators: false) {
                        HotelView(isMainView: $isMainView)
                    }
                    .mask {
                        RoundedCornersShape(corners: [.bottomLeft, .bottomRight], radius: 12)
                    }
                    CustomTapBar(text: "К выбору номера", action: {
                        DispatchQueue.main.async {
                            self.isMainView = true
                        }
                    })
                }
                .edgesIgnoringSafeArea(.all)

            }
        }
        .navigationBarTitle("", displayMode: .inline)
        .navigationBarBackButtonHidden(true)
    }
    
}


struct HotelView: View {
    
    @ObservedObject var hotelVM: HotelViewModel = HotelViewModel()
    
    @Binding var isMainView: Bool
    
    var body: some View {
        VStack(spacing: 8) {
            if hotelVM.isLoad {
                CardHotel(hotel: hotelVM.hotel)
                AboutHotel(
                    hotelDescroption: hotelVM.hotelDescription,
                    isMainView: $isMainView)
            }
        }
        .navigationDestination(isPresented: $isMainView) {
            RoomsView(isMainView: $isMainView, nameHotel: hotelVM.hotel.name)
        }
    }
}


#if DEBUG
struct MainView_Previews: PreviewProvider {
    static var previews: some View {
        MainView()
    }
}
#endif

