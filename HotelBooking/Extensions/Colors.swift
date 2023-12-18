//
//  Colors.swift
//  HotelBooking
//
//  Created by Steven Kirke on 04.09.2023.
//

import SwiftUI

extension Color {
	enum Name: String {
		case black90
		case black22
		case black17
		case black10
		case black05
		case customBlue
		case customBlue10
		case customDarkGrey
		case customOmbreGray
		case customBlack15
		case customMiddleGray
		case colorF6F6F9
		case colorFBFBFC
		case customYellow
		case customYellow20
		case customRed15
		case customRed
		case customDarkBlue
		case grayE8E9EC
	}

	init(_ name: Color.Name) {
		self.init(name.path)
	}
	static let black05 = Color(Name.black05)

	static let black90 = Color(Name.black90)
	static let black22 = Color(Name.black22)
	static let black17 = Color(Name.black17)
	static let black10 = Color(Name.black10)

	static let customBlue = Color(Name.customBlue)
	static let blue10 = Color(Name.customBlue10)

	static let grayE8E9EC = Color(Name.grayE8E9EC)

	static let customDarkGrey = Color(Name.customDarkGrey)
	static let customMiddleGray = Color(Name.customMiddleGray)
	static let ColorF6F6F9 = Color(Name.colorF6F6F9)
	static let ColorFBFBFC = Color(Name.colorFBFBFC)

	static let customOmbreGray = Color(Name.customOmbreGray)
	static let customBlack15 = Color(Name.customBlack15)

	static let customYellow = Color(Name.customYellow)
	static let customYellow20 = Color(Name.customYellow20)
	static let customRed15 = Color(Name.customRed15)
	static let customRed = Color(Name.customRed)

	static let customDarkBlue = Color(Name.customDarkBlue)
}

extension Color.Name {
	var path: String {
		"Colors/\(rawValue)"
	}
}
