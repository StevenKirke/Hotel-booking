//
//  NumberViewModel.swift
//  HotelBooking
//
//  Created by Steven Kirke on 10.09.2023.
//

import Foundation

final class RoomsViewModel: ObservableObject {

	// MARK: - Public properties
	@Published var isLoadRoom: Bool = false
	@Published var displayHRoom: [RoomModel.DisplayModelRoom] = []

	// MARK: - Dependencies
	private let networkService: INetworkRequest

	// MARK: - Initializator
	init(networkService: INetworkRequest) {
		self.networkService = networkService
	}

	// MARK: - Private methods
	func getRoomData() {
		if !isLoadRoom {
			self.fetchData()
		}
	}
}

// Запрос к сети или к mock-файлу
private extension RoomsViewModel {
	private func fetchData() {
		var model: RoomModel.Rooms?
		networkService.getData(url: URLs.rooms.url, model: model) { result in
			if case let .success(json) = result {
				self.modelProcessing(jsonModel: json)
			}
			if case let .failure(error) = result {
				print("error \(error)")
			}
		}
	}
}

// Преобразование модели Responce.Rooms в DisplayModelRoom
private extension RoomsViewModel {
	private func modelProcessing(jsonModel: RoomModel.Rooms?) {
		guard let currentModel = jsonModel else { return }

		self.displayHRoom = currentModel.rooms.map { room in
			RoomModel.DisplayModelRoom(
				id: room.id,
				name: room.name,
				price: centesimalInt(price: room.price),
				pricePer: room.pricePer,
				peculiarities: room.peculiarities,
				images: room.imageUrls
			)
		}
		self.isLoadRoom = true
	}

	private func centesimalInt(price: Int) -> String {
		price.centesimal() + " ₽"
	}
}
