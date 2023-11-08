//
//  RoomsView.swift
//  HotelBooking
//
//  Created by Steven Kirke on 04.09.2023.
//

import SwiftUI

struct RoomsView: View {
    
    @Environment(\.presentationMode) var returnMainView: Binding<PresentationMode>
    @ObservedObject var roomsVM: RoomsViewModel = RoomsViewModel()
    
    @Binding var isMainView : Bool
    
    var nameHotel: String
    
    var body: some View {
        VStack(spacing: 0) {
            CustomNavigationTabBar(label: nameHotel, content:
                                    ButtonForNavigationTabBar(action: {
                self.returnMainView.wrappedValue.dismiss()
            })
            )
            ScrollView(.vertical ,showsIndicators: false) {
                VStack(spacing: 8) {
                    ForEach(roomsVM.room.indices, id: \.self) { index in
                        if roomsVM.isLoadRoom {
                            HotelHumberCard(
                                room: roomsVM.room[index],
                                isMainView: $isMainView
                            )
                        }
                    }
                }
            }
        }
        .background(Color.c_F6F6F9)
        .edgesIgnoringSafeArea(.all)
        .navigationBarTitle("", displayMode: .inline)
        .navigationBarBackButtonHidden(true)
        .onAppear() {
            self.roomsVM.getRoom()
        }
    }
}

struct HotelHumberCard: View {
    
    var room: RoomTitle
    
    @State var isNumberView: Bool = false
    @Binding var isMainView : Bool
    
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
                Button(action: {}) {
                    HStack(spacing: 2) {
                        Text("Подробнее о номере")
                            .modifier(HeightModifier(size: 16,
                                                     lineHeight: 120,
                                                     weight: .medium))
                        Image(systemName: "chevron.right")
                            .frame(width: 24, height: 24)
                    }
                    .foregroundColor(.c_0D72FF)
                    .padding(.vertical, 5)
                    .padding(.leading, 10)
                    .padding(.trailing, 2)
                    .background(Color.c_0D72FF_10)
                    .cornerRadius(5)

                }
                HStack(alignment: .firstTextBaseline, spacing: 7) {
                    Text("\(room.price)")
                        .modifier(HeightModifier(size: 30, lineHeight: 120, weight: .semibold))
                        .foregroundColor(.black)
                    Text(room.pricePer)
                        .modifier(HeightModifier(size: 16, lineHeight: 120, weight: .regular))
                        .foregroundColor(.c_828796)
                }
                .padding(.vertical, 8)
                Button(action: {
                    self.isNumberView = true
                }) {
                    Text("Выбрать номер")
                        .modifier(HeightModifier(size: 16,
                                                 lineHeight: 110,
                                                 weight: .medium))
                        .tracking(0.1)
                        .foregroundColor(.white)
                        .frame(maxWidth: .infinity, maxHeight: 48)
                        .frame(height: 48)
                        .background(Color.c_0D72FF)
                        .cornerRadius(15)
                        .navigationDestination(isPresented: $isNumberView) {
                            BookingView(
                                isMainView: $isMainView,
                                        idRoom: room.id
                            )
                        }
                }
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
