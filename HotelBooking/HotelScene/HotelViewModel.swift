//
//  HotelViewModel.swift
//  HotelBooking
//
//  Created by Steven Kirke on 08.09.2023.
//

import Foundation

enum ProcessingError: Error {
	case errorProcessingModel
}

final class HotelViewModel: ObservableObject {

	// MARK: - Public properties
	@Published var isLoad: Bool = false
	@Published var hotelDescription: AboutTheHotel = AboutTheHotel(description: "", peculiarities: [])
	@Published var hotel: HotelTitle = HotelTitle(
		id: 0,
		name: "",
		adress: "",
		minimalPrice: "",
		raiting: "",
		priceForIt: "",
		images: []
	)

	// MARK: - Dependencies
	private let requestData: RequestData = RequestData()
	private let jsonManager: DecodeJson = DecodeJson()

	// MARK: - Private properties

	// MARK: - Initializator
	init() {
		self.getHotelData()
	}

	// MARK: - Lifecycle

	// MARK: - Public methods
	func getHotelData() {
		if !isLoad {
			self.getMock()
		}
	}

	// MARK: - Private methods
	private func getMock() {
		let hotels: Hotels? = nil
		let currentData = Data(mockHotel.utf8)
		self.jsonManager.decodeJSON(data: currentData, model: hotels) { result in
			if case let .success(jsonModel) = result {
				self.modelProcessing(jsonModel: jsonModel) { processingModel in
					if case let .success(model) = processingModel {
						self.isLoad = true
					}
					if case let .failure(error) = processingModel {
						self.showErrorView(masssage: error)
					}
				}
			}
			if case let .failure(error) = result {
				self.showErrorView(masssage: error)
			}
		}
	}

	private func modelProcessing(jsonModel: Hotels?, result: (Result<Bool, ProcessingError>) -> Void) {
		guard let currentHotel = jsonModel else {
			result(.failure(.errorProcessingModel))
			return
		}
		self.hotel.id = currentHotel.id
		self.hotel.name = currentHotel.adress.separate()
		self.hotel.adress = currentHotel.adress
		self.hotel.raiting = String(currentHotel.rating) + " " + currentHotel.ratingName
		self.hotel.minimalPrice = centesimalInt(price: currentHotel.minimalPrice)
		self.hotel.priceForIt = currentHotel.priceForIt.lowercased()

		self.hotel.images = currentHotel.imageUrls

		self.hotelDescription.description = currentHotel.aboutTheHotel.description
		self.hotelDescription.peculiarities = currentHotel.aboutTheHotel.peculiarities

		result(.success(true))
	}

	private func centesimalInt(price: Int) -> String {
		let conv = "От " + price.centesimal() + " ₽"
		return conv
	}

	private func showErrorView(masssage: Error) {
		print("Handle error! \(masssage.localizedDescription)")
	}
}
/*


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
 */


