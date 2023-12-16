//
//  RequestData.swift
//  HotelBooking
//
//  Created by Steven Kirke on 08.09.2023.
//

import Foundation

enum DecodeError: Error {
	case errorConvertURL
	case errorDecodeData(String)
}

final class RequestData {

	let task = URLSession.shared

	func getData(url: String, returnData: @escaping (Result<Data?, DecodeError>) -> Void) {
		guard let url = URL(string: url) else {
			returnData(.failure(.errorConvertURL))
			return
		}
		let request = URLRequest(url: url)
		let dataTask = task.dataTask(with: request) { data, _, error in
			DispatchQueue.main.async {
				if let currentError = error {
					returnData(.failure(.errorDecodeData(currentError.localizedDescription)))
				   return
				}
				guard let currentData = data else { return }
				returnData(.success(currentData))
			}
		}
		dataTask.resume()
	}
}

private extension DecodeError {
	var errorDescription: String {
		var currentError = ""
		switch self {
		case .errorConvertURL:
				currentError = "Incorrect URL conversion."
		case .errorDecodeData(let error):
			currentError = "Error data \(error)"
		}
		return currentError
	}
}
