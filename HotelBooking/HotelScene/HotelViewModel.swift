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
	@Published var isLoadData: Bool = false
	@Published var displayHotelModel: HotelModelEnum.DisplayModelHotel?

	// MARK: - Dependencies
	private let requestData: RequestData = RequestData()
	private let jsonManager: DecodeJson = DecodeJson()

	// MARK: - Private properties

	// MARK: - Initializator
	init() {
		self.getHotelData()
	}

	// MARK: - Public methods
	func getHotelData() {
		if !isLoadData {
			self.getMock()
		}
	}

	// MARK: - Private methods
	private func getMock() {
		let hotels: HotelModel? = nil
		let currentData = Data(mockHotel.utf8)

		self.jsonManager.decodeJSON(data: currentData, model: hotels) { [weak self] result  in
			guard let self = self else { return }
			if case let .success(jsonModel) = result {
				self.modelProcessing(jsonModel: jsonModel)
				self.isLoadData = true
			}
			if case let .failure(error) = result {
				self.showErrorView(masssage: error)
			}
		}
	}
}

// Processing fields for the 'displayHotelModel'
private extension HotelViewModel {

	private func modelProcessing(jsonModel: HotelModel?) {
		guard let currentModel = jsonModel else {
			return
		}

		self.displayHotelModel = HotelModelEnum.DisplayModelHotel(
			id: currentModel.id,
			name: currentModel.name,
			adress: currentModel.adress,
			minimalPrice: centesimalInt(price: currentModel.minimalPrice),
			raiting: assamblyRaiting(raiting: currentModel.rating, raitingName: currentModel.ratingName),
			priceForIt: currentModel.priceForIt.lowercased(),
			imageURL: currentModel.imageUrls,
			aboutTheHotel: HotelModelEnum.DisplayModelHotel.DisplayAboutHotel(
				description: currentModel.aboutTheHotel.description,
				peculiarities: currentModel.aboutTheHotel.peculiarities
			)
		)
	}

	private func centesimalInt(price: Int) -> String {
		let conv = "От " + price.centesimal() + " ₽"
		return conv
	}

	private func assamblyRaiting(raiting: Int, raitingName: String) -> String {
		"\(raiting) \(raitingName)"
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
