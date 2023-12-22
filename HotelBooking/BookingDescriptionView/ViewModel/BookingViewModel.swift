//
//  ContactViewModel.swift
//  HotelBooking
//
//  Created by Steven Kirke on 05.10.2023.
//

import SwiftUI
import Contacts

class BookingViewModel: ObservableObject {

	@Published var isLoadBooking = false
	@Published var displayBooking: InfoRoom.DisplayModelBooking?

	// MARK: - Dependencies
	private let networkService: INetworkRequest

	// MARK: - Initializator
	internal init( networkService: INetworkRequest ) {
		self.networkService = networkService
	}

	// MARK: - Private methods
	func getBokingData() {
		if !isLoadBooking {
			self.fetchData()
		}
	}
}

// Запрос к сети или к mock-файлу
private extension BookingViewModel {
	private func fetchData() {
		var model: InfoRoom.RoomDescription?
		networkService.getData(url: URLs.paid.url, model: model) { result in
			if case let .success(json) = result {
				self.modelProcessing(jsonModel: json)
			}
			if case let .failure(error) = result {
				print("error pair \(error.localizedDescription)")
			}
		}
	}
}

// Преобразование модели Responce.Rooms в DisplayModelRoom
private extension BookingViewModel {
	private func modelProcessing(jsonModel: InfoRoom.RoomDescription?) {
		guard let currentModel = jsonModel else { return }

		let totalPrice: Int = fullPayment(
			tour: currentModel.tourPrice,
			fuel: currentModel.fuelCharge,
			service: currentModel.serviceCharge
		)

		self.displayBooking = InfoRoom.DisplayModelBooking(
			id: currentModel.id,
			hotelName: currentModel.hotelName,
			hotelAdress: currentModel.hotelAdress,
			rating: assamblyRaiting(raiting: currentModel.horating, raitingName: currentModel.ratingName),
			datas: assamblyData(startData: currentModel.tourDateStart, stopData: currentModel.tourDateStop),
			departure: currentModel.departure,
			arrivalCountry: currentModel.arrivalCountry,
			tourDates: "",
			numberOfNights: assamblyNight(night: currentModel.numberOfNights),
			room: currentModel.room,
			nutrition: currentModel.nutrition,
			pay: payAssambly(totalPrice: totalPrice),
			price: InfoRoom.Price(
				tourPrice: centesimalInt(price: currentModel.tourPrice),
				fuelCharge: centesimalInt(price: currentModel.fuelCharge),
				serviceCharge: centesimalInt(price: currentModel.serviceCharge),
				totalPrice: centesimalInt(price: totalPrice)
			)
		)
		self.isLoadBooking = true
	}

	private func assamblyRaiting(raiting: Int, raitingName: String) -> String {
		"\(raiting) \(raitingName)"
	}

	private func assamblyData(startData: String, stopData: String) -> String {
		startData + " - " + stopData
	}

	private func assamblyNight(night: Int) -> String {
		"\(night) ночей"
	}

	private func centesimalInt(price: Int) -> String {
		price.centesimal() + " ₽"
	}

	private func fullPayment(tour: Int, fuel: Int, service: Int) -> Int {
		tour + fuel + service
	}

	private func payAssambly(totalPrice: Int) -> String {
		"Оплатить \(centesimalInt(price: totalPrice))"
	}
}
