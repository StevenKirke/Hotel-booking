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
	private let networkService: INetworkRequest

	// MARK: - Private properties

	// MARK: - Initializator
	init(networkService: INetworkRequest) {
		self.networkService = networkService
		self.getHotelData()
	}

	// MARK: - Public methods
	func getHotelData() {
		if !isLoadData {
			self.fetchData()
		}
	}
}

// Запрос к сети или к mock-файлу
private extension HotelViewModel {
	private func fetchData() {
		var model: HotelModel?
		networkService.getData(url: URLs.hotel.url, model: model) { [weak self] result in
			guard let self = self else { return }

			if case let .success(json) = result {
				self.modelProcessing(jsonModel: json)
			}
			if case let .failure(error) = result {
				self.showError(massage: error.localizedDescription)
			}
		}
	}

}

// Преобразование модели Responce.HotelModel в DisplayModelHotel
private extension HotelViewModel {

	private func modelProcessing(jsonModel: HotelModel?) {
		guard let currentModel = jsonModel else {
			return
		}

		self.displayHotelModel = HotelModelEnum.DisplayModelHotel(
			id: currentModel.id,
			name: currentModel.name,
			adress: currentModel.adress,
			cropAdress: cropAdress(adress: currentModel.adress),
			minimalPrice: centesimalInt(price: currentModel.minimalPrice),
			raiting: assamblyRaiting(raiting: currentModel.rating, raitingName: currentModel.ratingName),
			priceForIt: currentModel.priceForIt.lowercased(),
			imageURL: currentModel.imageUrls,
			aboutTheHotel: HotelModelEnum.DisplayModelHotel.DisplayAboutHotel(
				description: currentModel.aboutTheHotel.description,
				peculiarities: currentModel.aboutTheHotel.peculiarities
			)
		)
		self.isLoadData = true
	}

	private func centesimalInt(price: Int) -> String {
		let conv = "От " + price.centesimal() + " ₽"
		return conv
	}

	private func assamblyRaiting(raiting: Int, raitingName: String) -> String {
		"\(raiting) \(raitingName)"
	}

	private func cropAdress(adress: String) -> String {
		let crop = adress.components(separatedBy: ",")
		guard let currentFirst = crop.first else { return ""}

		return currentFirst
	}
}

// Обрпботка ошибки с сервера или декодирования
private extension HotelViewModel {
	private func showError(massage: String) {
		print("Error \(massage)")
	}
}
