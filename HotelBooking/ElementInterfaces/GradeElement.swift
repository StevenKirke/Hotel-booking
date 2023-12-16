//
//  GradeElement.swift
//  HotelBooking
//
//  Created by Steven Kirke on 10.09.2023.
//

import SwiftUI

struct GradeElement: View {

	var grade: String

	var body: some View {
		HStack(alignment: .center, spacing: 2) {
			Image(systemName: "star.fill")
				.font(.system(size: 15))
			Group {
				Text(grade)
					.modifier(HeightModifier(size: 16, lineHeight: 120, weight: .medium))
			}
		}
		.foregroundColor(.customYellow)
		.padding(.vertical, 5)
		.padding(.horizontal, 10)
		.background(Color.customYellow20)
		.cornerRadius(5)
	}
}

#if DEBUG
struct GradeElement_Previews: PreviewProvider {
	static var previews: some View {
		GradeElement(grade: "5 Превосходно")
	}
}
#endif
