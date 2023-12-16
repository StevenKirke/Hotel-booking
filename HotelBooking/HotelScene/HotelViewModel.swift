//
//  HotelViewModel.swift
//  HotelBooking
//
//  Created by Steven Kirke on 08.09.2023.
//

import Foundation

class HotelViewModel: ObservableObject {

	private let requestData: RequestData = RequestData()
	private let jsonManager: DecodeJson = DecodeJson()

	@Published var isLoad: Bool = false

	@Published var hotel: HotelTitle = HotelTitle(
		id: 0,
		name: "",
		adress: "",
		minimalPrice: "",
		raiting: "",
		priceForIt: "",
		images: []
	)

	@Published var hotelDescription: AboutTheHotel = AboutTheHotel(description: "", peculiarities: [])

	init() {
		self.getHotel()
	}

	func getHotel() {
		if !isLoad {
			self.getMock()
		}
	}

	private func getMock1() {
		let hotels: Hotels? = nil
		let currentData = Data(mockHotel.utf8)
		self.jsonManager.decodeJSON(data: currentData, model: hotels) { [weak self] result in
			guard let self = self else {
				return
			}
			if case let .success(json) = result {
				self.modelProcessing(json) { result in
					self.isLoad = result
				}
			}
		}
	}

	private func getMock() {
		let hotels: Hotels? = nil
		let currentData = Data(mockHotel.utf8)
		self.jsonManager.decodeJSON(data: currentData, model: hotels) { [weak self] json, error in
			guard let self = self else {
				return
			}
			if error != "" {
				print("Error - ", error)
			}
			guard let currentJSON = json else {
				return
			}
			self.modelProcessing(currentJSON) { result in
				self.isLoad = result
			}
		}
	}

	private func getData() {
		let hotels: Hotels? = nil
		self.requestData.getData(url: URLs.hotel.url) { [weak self] data, error in
			guard let self = self else {
				return
			}
			if error != "" {
				print("Error - ", error)
			}
			guard let currentData = data else {
				return
			}
			self.jsonManager.decodeJSON(data: currentData, model: hotels) { [weak self] json, error in
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
					self.isLoad = result
				}
			}
		}
	}

	private func modelProcessing(_ hotel: Hotels?, result: (Bool) -> Void) {
		guard let currentHotel = hotel else {
			result(false)
			return
		}
		self.hotel.id = currentHotel.id
		self.hotel.name = currentHotel.adress.separate()
		self.hotel.adress = currentHotel.adress
		self.hotel.raiting = String(currentHotel.rating) + " " + currentHotel.ratingName
		self.hotel.minimalPrice = centesimalInt(currentHotel.minimalPrice)
		self.hotel.priceForIt = currentHotel.priceForIt.lowercased()

		self.hotel.images = currentHotel.imageUrls

		self.hotelDescription.description = currentHotel.aboutTheHotel.description
		self.hotelDescription.peculiarities = currentHotel.aboutTheHotel.peculiarities

		result(true)
	}

	private func centesimalInt(_ number: Int) -> String {
		let conv = "От " + number.centesimal() + " ₽"
		return conv
	}
}
