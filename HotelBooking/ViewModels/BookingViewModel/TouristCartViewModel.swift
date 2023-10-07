//
//  TouristCartViewModel.swift
//  HotelBooking
//
//  Created by Steven Kirke on 28.09.2023.
//

import Foundation


struct TouristCard {
    var name: String
    var lastName: String
    @DateFormatted var dateBirth: String
    var citizenShip: String
    var numberPassport: String
    @DateFormatted var validityPeriodPassport: String
}


class TouristCartViewModel: ObservableObject {
    
    @Published var isLoadTourist: Bool = false
    @Published var touristList: [TouristCard] = []
    @Published var phone: String = ""
    @Published var phoneMask: String = ""
    @Published var eMail: String = ""
    
    
    let nameTourist: [String] = ["Первый", "Второй", "Третий", "Четвертый", "Пятый", "Шестой"]
    var currentTourist = TouristCard(name: "", lastName: "",
                                     dateBirth: "",
                                     citizenShip: "",
                                     numberPassport: "",
                                     validityPeriodPassport: ""
    )
    
    init() {
        self.getTourist()
    }
    
    func addTourist() {
        self.touristList.append(currentTourist)
    }
    
    
    private func getTourist() {
        if touristList.isEmpty {
            self.touristList.append(currentTourist)
            self.touristList.append(currentTourist)
        }
    }
}
