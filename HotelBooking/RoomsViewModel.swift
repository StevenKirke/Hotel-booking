//
//  NumberViewModel.swift
//  HotelBooking
//
//  Created by Steven Kirke on 10.09.2023.
//

import Foundation

class RoomsViewModel: ObservableObject {

	private let jsonManager: DecodeJson = DecodeJson()

	@Published var isLoadRoom: Bool = false
	@Published var room: [RoomTitle] = []

	init() {

	}

	func getRoom() {
		if !isLoadRoom {
			self.getMock()
		}
	}

	private func getMock() {
		let rooms: Rooms = Rooms(rooms: [])
		let currentData = Data(mockRooms.utf8)
		self.jsonManager.decodeJSON(data: currentData, model: rooms) { [weak self] result in
			guard let self = self else { return }
			if case let .success(jsonModel) = result {
				//print("jsonModel \(jsonModel)")
			}
			if case let .failure(error) = result {

			}

//			if !currentJSON.rooms.isEmpty {
//				currentJSON.rooms.forEach { room in
//					self.modelProcessing(room) { result in
//						self.room.append(result)
//					}
//				}
//				self.isLoadRoom = true
//			}
		}
	}
	/*
	private func getData() {
		let rooms: Rooms = Rooms(rooms: [])
		self.requestData.getData(url: URLs.nomer.url) { [weak self] data, error in
			guard let self = self else {
				return
			}
			if error != "" {
				print("Error - ", error)
			}
			guard let currentData = data else {
				return
			}
			self.jsonManager.decodeJSON(data: currentData, model: rooms) { [weak self] json, error in
				if error != "" {
					print("Error - ", error)
				}
				guard let self = self else {
					return
				}
				guard let currentJSON = json else {
					return
				}
				if !currentJSON.rooms.isEmpty {
					currentJSON.rooms.forEach { room in
						self.modelProcessing(room) { result in
							self.room.append(result)
						}
					}
					self.isLoadRoom = true
				}
			}
		}
	}
	 */
	private func modelProcessing(_ currentRoom: Room, result: (RoomTitle) -> Void) {

		var room: RoomTitle = RoomTitle(id: 0, name: "", price: "", pricePer: "",
										peculiarities: [], images: [])

		room.id = currentRoom.id
		room.name = currentRoom.name
		room.price = centesimalInt(currentRoom.price)
		room.pricePer = currentRoom.pricePer
		room.peculiarities = currentRoom.peculiarities
		room.images = currentRoom.imageUrls
		result(room)
	}

	private func centesimalInt(_ number: Int) -> String {
		number.centesimal() + " ₽"
	}
}
