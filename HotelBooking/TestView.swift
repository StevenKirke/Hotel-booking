//
//  TestView.swift
//  HotelBooking
//
//  Created by Steven Kirke on 05.11.2023.
//

import SwiftUI

struct TestTextFields: View {

	@ObservedObject var customdVM: CustomTextFieldViewModel = CustomTextFieldViewModel()
	@FocusState var focus: Bool

	var body: some View {
		VStack(spacing: 10) {
			ForEach(customdVM.customFields.indices, id: \.self) { index in
				VStack {
					ForEach(customdVM.customFields[index].indices, id: \.self) { element in
						let urrentElem = customdVM.customFields[index][element]
						CustomTextFieldTest(
							title: $customdVM.customFields[index][element],
							nameField: check(urrentElem)
						)
					}
					.onSubmit {
					}
				}
			}
			Button {
				Text("Answer")
					.modifier(HeightModifier(size: 16, lineHeight: 110, weight: .medium))
					.tracking(0.1)
					.foregroundColor(.white)
					.frame(height: 48)
					.frame(maxWidth: .infinity)
					.background(Color.c_0D72FF)
					.cornerRadius(15)
			}
			.padding(.horizontal, 16)
		}
		.frame(maxWidth: .infinity)
	}

	private func check(_ elem: ForFields) -> Binding<FormForFields> {
		switch elem {
		case .name(text: let text, field: _):
			print("CASE - NAME")
			var active: FormForFields = .none
			if !text.isEmpty {
				active = .inactiveField
			} else {
				active = .activeField
			}
			return .constant(active)
		case .lastName(lastName: let lastName, field: _):
			print("CASE - LAST NAME")
			var active: FormForFields = .none
			if !lastName.isEmpty {
				active = .inactiveField
			} else {
				active = .activeField
			}
			return .constant(active)
		}
	}
}

struct CustomTextFieldTest: View {

	@Binding var title: ForFields
	@State var fram: String = ""
	@FocusState var focus: Bool
	@Binding var nameField: FormForFields

	var body: some View {
		HStack(spacing: 5) {
			ZStack(alignment: .leading) {
				if fram.isEmpty {
					Text(title.title)
				}
				TextField("", text: $fram)
					.tint(.black)
					.focused($focus)
			}
			HStack(spacing: 10) {
				Circle()
					.fill(.red)
					.frame(width: 6, height: 6)
			}

		}
		.frame(maxWidth: .infinity, alignment: .leading)
		.padding(.horizontal, 16)
		.padding(.vertical, 10)
		.foregroundColor(.black)
		.background(.gray).opacity(0.4)
		.cornerRadius(13)
		.padding(.horizontal, 10)
		.onChange(of: $fram.wrappedValue) { _ in
			if case .name = title {
				self.title = ForFields.name(text: fram, field: FormForFields.none)
			} else if case .lastName = title {
				self.title = ForFields.lastName(lastName: fram, field: FormForFields.none)
			}
		}
	}
}

#if DEBUG
struct TestTextFields_Previews: PreviewProvider {
	static var previews: some View {
		TestTextFields()
	}
}
#endif
