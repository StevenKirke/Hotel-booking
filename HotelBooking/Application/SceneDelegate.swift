//
//  SceneDelegate.swift
//  HotelBooking
//
//  Created by Steven Kirke on 04.09.2023.
//

import UIKit
import SwiftUI

class SceneDelegate: UIResponder, UIWindowSceneDelegate {

	var window: UIWindow?

	func scene(
		_ scene: UIScene,
		willConnectTo session: UISceneSession,
		options connectionOptions: UIScene.ConnectionOptions
	) {

		let contentView = HotelView()

		if let windowScene = scene as? UIWindowScene {
			let window = UIWindow(windowScene: windowScene)
			window.rootViewController =  UIHostingController(rootView: contentView)

			self.window = window
			window.makeKeyAndVisible()
		}
	}
}
