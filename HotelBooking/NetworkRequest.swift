//
//  RequestData.swift
//  HotelBooking
//
//  Created by Steven Kirke on 08.09.2023.
//

import Foundation

protocol INetworkRequest {
	func getData<T: Decodable>(url: String, model: T, returnModel: @escaping (Result<T, ErrorResponce>) -> Void)
}

enum ErrorResponce: Error {
	case errorConvertURL
	case errorDecodeData(String)
}

final class MockNetworkRequest: INetworkRequest {

	private let jsonManager: DecodeJson = DecodeJson()

	func getData<T>(url: String, model: T, returnModel: @escaping (Result<T, ErrorResponce>) -> Void) where T: Decodable {
		let currentData = Data(url.utf8)

		jsonManager.decodeJSON(data: currentData, model: model) { result in
			if case let .success(json) = result {
				returnModel(.success(json))
			}
			if case let .failure(error) = result {
				returnModel(.failure(.errorDecodeData(error.localizedDescription)))
			}
		}
	}
}

final class NetworkRequest: INetworkRequest {

	private let jsonManager: DecodeJson = DecodeJson()

	private let task = URLSession.shared

	func getData<T>(url: String, model: T, returnModel: @escaping (Result<T, ErrorResponce>) -> Void) where T: Decodable {
		guard let url = URL(string: url) else {
			returnModel(.failure(.errorConvertURL))
			return
		}

		let request = URLRequest(url: url)
		let dataTask = task.dataTask(with: request) { data, _, error in
			DispatchQueue.main.async {
				if let currentError = error {
					returnModel(.failure(.errorDecodeData(currentError.localizedDescription)))
				   return
				}
				guard let currentData = data else { return }
				self.decodeJSON(data: currentData, model: model) { result in
					if case let .success(json) = result {
						returnModel(.success(json))
					}
					if case let .failure(error) = result {
						returnModel(.failure(.errorDecodeData(error.localizedDescription)))
					}
				}
			}
		}
		dataTask.resume()
	}

	private func decodeJSON<T: Decodable>(data: Data, model: T, returnData: @escaping (Result<T, ErrorResponce>) -> Void) {
		jsonManager.decodeJSON(data: data, model: model) { result in
			if case let .success(json) = result {
				returnData(.success(json))
			}
			if case let .failure(error) = result {
				returnData(.failure(.errorDecodeData(error.localizedDescription)))
			}
		}
	}
}
