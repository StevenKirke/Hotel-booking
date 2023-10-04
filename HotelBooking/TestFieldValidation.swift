//
//  TestFieldValidation.swift
//  HotelBooking
//
//  Created by Steven Kirke on 04.10.2023.
//

import SwiftUI


class TestFieldValidationModel: ObservableObject {
    @Published var firstName = ""
    @Published var lastName = ""
    @Published var passportNumber = ""

    @Published var nameValidation = ""
    @Published var lastNameValidation = ""
    @Published var passportValidation = ""

    init() {
        $firstName
            .map {$0.isEmpty ? "🔴" : "🟢"}
            .assign(to: &$nameValidation)

        $lastName
            .map {$0.isEmpty ? "🔴" : "🟢"}
            .assign(to: &$lastNameValidation)

        $passportNumber
            .map {$0.isEmpty ? "🔴" : "🟢"}
            .assign(to: &$passportValidation)
    }
}

// Create enum to monitor focus state of text fields
enum NameFields: String {
    case firstName = "First Name"
    case lastName = "Last Name"
    case passportNumber = "Passport Number"
}

struct TestFieldValidation: View {
    @StateObject private var vm = TestFieldValidationModel()

    // Monitor focused state of text fields using this property
    @FocusState private var nameFields: NameFields?

    @State private var submitPressed = false

    // This is just to show on the screen what was submitted
    @State private var showSubmittedNames = false

    var body: some View {
        VStack(spacing: 20) {
            CustomTextField(text: $vm.firstName,
                            focus: $nameFields,
                            nameField: .firstName,
                            submitPressed: submitPressed
            )

            CustomTextField(text: $vm.lastName,
                            focus: $nameFields,
                            nameField: .lastName,
                            submitPressed: submitPressed
            )

            CustomTextField(text: $vm.passportNumber,
                            focus: $nameFields,
                            nameField: .passportNumber,
                            submitPressed: submitPressed
            )

            Button("Submit") {
                if vm.firstName.isEmpty {
                    nameFields = .firstName
                } else if vm.lastName.isEmpty {
                    nameFields = .lastName
                } else if vm.passportNumber.isEmpty {
                    nameFields = .passportNumber
                } else {
                    // save function or whatever logic applied when all fields are filled
                    // here we just toggle to show the names on the screen
                    showSubmittedNames = true
                    nameFields = nil
                }

                submitPressed = true

            }
            // with this you can change return button name on virtual keyboard
            // other options also available like 'go', 'join', 'next' etc
            .submitLabel(.done)

            // This is just to show that data was submitted
            if showSubmittedNames {
                Text(vm.firstName + " " + vm.lastName + " " + vm.passportNumber)
            } else {
                EmptyView()
            }
        }
        .padding()
        .onSubmit {
            // once you tap return on virtual keyboard this will be triggered
            showSubmittedNames = true
            submitPressed = true
        }
    }
}

struct CustomTextField: View {
    @Binding var text: String

    @FocusState.Binding var focus: NameFields?
    var nameField: NameFields

    var submitPressed: Bool

    var body: some View {
        ZStack(alignment: .trailing) {
            TextField("\(nameField.rawValue)", text: $text)
                .padding(8)
                .focused($focus, equals: nameField)
                .background(
                    RoundedRectangle(cornerRadius: 8)
                        .fill(text.isEmpty && submitPressed ? Color.red.opacity(0.5) : Color.clear)
                )
        }
    }
}


#if DEBUG
struct TestFieldValidation_Previews: PreviewProvider {
    static var previews: some View {
        TestFieldValidation()
    }
}
#endif

