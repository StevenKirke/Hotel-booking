//
//  AppCoordinator.swift
//  HotelBooking
//
//  Created by Steven Kirke on 16.12.2023.
//

import SwiftUI

// Работа с потоками 'View'
protocol IAppCoordinator: AnyObject, ObservableObject {
	func showHotel()
	func showRooms()
	func showRoom()
	func showPaid()
}

final class AppCoordinator: IAppCoordinator {

	// MARK: - Public properties
	@Published var path = NavigationPath()
	@Published var currentPage: Pages = .hotel

	// MARK: - Public methods
	func showHotel() {
		path.removeLast(path.count)
	}

	func showRooms() {
		path.append(Pages.rooms)
	}

	func showRoom() {
		path.append(Pages.room)
	}

	func showPaid() {
		path.append(Pages.pair)
	}
}

enum Pages: String, CaseIterable, Identifiable {
	case hotel
	case rooms
	case room
	case pair

	var id: String { self.rawValue }
}
