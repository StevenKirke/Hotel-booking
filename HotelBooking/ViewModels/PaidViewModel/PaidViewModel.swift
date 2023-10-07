//
//  PaidViewModel.swift
//  HotelBooking
//
//  Created by Steven Kirke on 05.10.2023.
//

import Foundation
import Combine


class PaidViewModel: ObservableObject {
    
    
    private var cancellables = Set<AnyCancellable>()
    
    @Published var code: String = ""
    
    private var isLoad: Bool = false
    
    init() {
        print("111")
        if !isLoad {
            self.code = genericNumber(6)
            $code
                .sink { value in
                    print("value \(value)")
                } receiveValue: { other in
                    print("other \(other)")
                }
                .store(in: &cancellables)
            self.isLoad = true
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
