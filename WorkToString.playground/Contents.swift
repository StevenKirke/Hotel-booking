

import SwiftUI

class PaidViewModel: ObservableObject {
    
    @Published var code: String = ""
    
    init() {
        $code
            .sink { value in
                print(value)
            }
    }
    
    private func genericNumber(_ digits: Int) -> String {
        var number: String = ""
        for _ in 1...digits {
            number += "\(Int(Int.random(in: 0...9)))"
        }
        return number
    }
}


class main {
    
   // var mv: PaidViewModel = PaidViewModel()
    
    func start() {
        print("START")
    }
    
    init() {
        start()
    }
    
}
