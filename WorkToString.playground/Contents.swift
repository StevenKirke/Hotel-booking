import SwiftUI


@propertyWrapper
struct BirthDateFormatted {
    private var birthDate: String

    init(wrappedValue: String) {
        birthDate = wrappedValue
    }

    var wrappedValue: String {
        get { birthDate }

        set(value) {
            birthDate = value
            /// Inserting a slash in the third position to differentiate between day and month
            if value.count == 3 {
                let startIndex = value.startIndex
                let thirdPosition = value.index(startIndex, offsetBy: 2)
                let thirdPositionChar = value[thirdPosition]
                if thirdPositionChar != "/" {
                    birthDate.insert("/", at: thirdPosition)
                }
            }

            /// Inserting a slash in the sixth position to differentiate between month and year
            if value.count == 6 {
                let startIndex = value.startIndex
                let sixthPosition = value.index(startIndex, offsetBy: 5)
                let sixthPositionChar = value[sixthPosition]
                if sixthPositionChar != "/" {
                    birthDate.insert("/", at: sixthPosition)
                }
            }

            /// Removing / when going back
            if value.last == "/" {
                birthDate.removeLast()
            }

            /// Limiting string, including two slashes (8 + 2 = 10)
            birthDate = String(birthDate.prefix(10))
        }
    }
}

struct Person {
    @BirthDateFormatted var birthDate: String
}

class PersonViewModel: ObservableObject {
    @Published var person = Person(birthDate: "")
}

struct BirthDateView: View {
    @StateObject var vm = PersonViewModel()

    var body: some View {
        VStack {
            TextField("DD/MM/YYYY", text: $vm.person.birthDate)
        }
        .padding()
    }
}

