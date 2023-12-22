//
//  AppCoordinator.swift
//  HotelBooking
//
//  Created by Steven Kirke on 16.12.2023.
//

import SwiftUI

final class AppCoordinator: ObservableObject {
	// MARK: - Public properties
	@Published var path = NavigationPath()
	@Published var currentScene: Scenes = .hotel

	// MARK: - Public methods
	func showHotelScene() {
		path.removeLast(path.count)
	}

	func showRoomsScene() {
		path.append(Scenes.rooms)
	}

	func showRoomScene() {
		path.append(Scenes.room)
	}

	func showPaidScene() {
		path.append(Scenes.pair)
	}

	@ViewBuilder
	func getPage(scenes: Scenes) -> some View {
		switch scenes {
		case .hotel:
			HotelView()
		case .rooms:
			RoomsView(isMainView: .constant(false), nameHotel: "")
		case .room:
			BookingView(isMainView: .constant(false))
		case .pair:
			PaidView(isMainView: .constant(false))
		}
	}
}

enum Scenes: String, CaseIterable, Identifiable {
	case hotel
	case rooms
	case room
	case pair

	var id: String { self.rawValue }
}
