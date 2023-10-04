//
//  RequestData.swift
//  HotelBooking
//
//  Created by Steven Kirke on 08.09.2023.
//

import Foundation


class RequestData {
    
    let task = URLSession.shared
    
    func getData(url: String, returnData: @escaping (Data?, String) -> Void) {
        guard let url = URL(string: url) else {
            returnData(nil, "Convert url.")
            return
        }
        let request = URLRequest(url: url)
        let dataTask = task.dataTask(with: request) { data, response, error in
            DispatchQueue.main.async {
                if error != nil {
                    returnData(nil, "Request data.")
                    return
                }
                guard let currentData = data else {
                    returnData(nil, "Response data.")
                    return
                }
                returnData(currentData, "")
            }
        }
        dataTask.resume()
    }

}
