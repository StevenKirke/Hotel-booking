//
//  BookingViewModel.swift
//  HotelBooking
//
//  Created by Steven Kirke on 12.09.2023.
//

import Foundation

struct Specification {
    var id: Int
    var hotelName: String
    var hotelAdress: String
    var rating: String
    var datas: String
    var departure: String
    var arrivalCountry: String
    var tourDates: String
    var numberOfNights: String
    var room, nutrition: String

}

struct TotalPrice {
    var tourPrice: String
    var fuelCharge: String
    var serviceCharge: String
    var totalPrice: String
}

class GetSpecificationHotelViewModel: ObservableObject {
    
    private let requestData: RequestData = RequestData()
    private let jsonManager: DecodeJson = DecodeJson()
    
    @Published var isLoadDesc: Bool = false
   
    @Published var desc: Specification = Specification(id: 0, hotelName: "",
                                                     hotelAdress: "", rating: "",
                                                     datas: "", departure: "",
                                                     arrivalCountry: "", tourDates: "",
                                                     numberOfNights: "", room: "",
                                                     nutrition: "")
    
    @Published var totalPrice: TotalPrice = TotalPrice(tourPrice: "", fuelCharge: "",
                                                       serviceCharge: "", totalPrice: "")
    
    init() {
        self.getSpecification()
    }

    deinit {
        print("CLOSE Specification")
    }
    
    func getSpecification() {
        if !isLoadDesc {
            /*
            let infoNumber: InfoMumber? = nil
            self.getMock(mock: MockInfoNumber, model: infoNumber) { [weak self] infoNumber in
                guard let self = self else {
                    return
                }
                guard let currentModel = infoNumber else {
                    return
                }
                self.modelProcessing(currentModel) { result in
                    self.isLoadDesc = true
                }
            }
             */
            self.getData()
        }
    }
    
    private func getMock<T: Decodable>(mock: String, model: T, returnModel: @escaping (T?) -> Void) {
        let currentData = Data(mock.utf8)
        self.jsonManager.decodeJSON(data: currentData, model: model) { json, error in
            if error != "" {
                print("Error - ", error)
            }
            returnModel(json)
        }
    }
    
    private func getData() {
        let infoNumber: InfoMumber? = nil
        self.requestData.getData(url: URLs.paid.url) { [weak self] data, error in
            guard let self = self else {
                return
            }
            if error != "" {
                print("Error - ", error)
            }
            guard let currentData = data else {
                return
            }
            self.jsonManager.decodeJSON(data: currentData, model: infoNumber) { [weak self] json, error in
                if error != "" {
                    print("Error - ", error)
                }
                guard let self = self else {
                    return
                }
                guard let currentJSON = json else {
                    return
                }
                self.modelProcessing(currentJSON) { result in
                    self.isLoadDesc = true
                }
            }
        }
    }
    

    private func modelProcessing<T: Decodable>(_ currentModel: T?, result: (Bool) -> Void) {
        guard let temptModel = currentModel as? InfoMumber else {
            return
        }
        self.desc.id = temptModel.id
        self.desc.hotelName = temptModel.hotelAdress.separate()
        self.desc.hotelAdress = temptModel.hotelAdress
        self.desc.arrivalCountry = temptModel.arrivalCountry
        self.desc.departure = temptModel.departure
        self.desc.datas = temptModel.tourDateStart + " - " + temptModel.tourDateStop
        self.desc.rating = String(temptModel.horating) + " " + temptModel.ratingName
        self.desc.numberOfNights = String(temptModel.numberOfNights) + " ночей"
        self.desc.room = temptModel.room
        self.desc.nutrition = temptModel.nutrition
        
        
        self.totalPrice.tourPrice = centesimalInt(temptModel.tourPrice)
        self.totalPrice.fuelCharge = centesimalInt(temptModel.fuelCharge)
        self.totalPrice.serviceCharge = centesimalInt(temptModel.serviceCharge)
        
        let summ = temptModel.tourPrice + temptModel.fuelCharge + temptModel.serviceCharge
        self.totalPrice.totalPrice = centesimalInt(summ)

        result(true)
    }
    
    private func centesimalInt(_ number: Int) -> String {
        let conv = number.centesimal() + " ₽"
        return conv
    }

}


//centesimal
