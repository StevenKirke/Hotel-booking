//
//  DecodeJson.swift
//  HotelBooking
//
//  Created by Steven Kirke on 08.09.2023.
//

import Foundation

class DecodeJson {

	enum DecodeError: Error {
		case errorDecodeJson(Error)
		case errorDecodeData
	}

	func decodeJSON<T: Decodable>(data: Data, model: T, returnJSON: @escaping (Result<T, DecodeError>) -> Void) {
		DispatchQueue.main.async {
			do {
				let decodedUsers = try JSONDecoder().decode(T.self, from: data)
				return returnJSON(.success(decodedUsers))
			} catch let error {
				return returnJSON(.failure(.errorDecodeJson(error)))
			}
		}
	}

	func decodeJSON<T: Decodable>(data: Data, model: T, returnJSON: @escaping (T?, String) -> Void) {
		DispatchQueue.main.async {
			do {
				let decodedUsers = try JSONDecoder().decode(T.self, from: data)
				return returnJSON(decodedUsers, "")
			} catch let error {
				print("Error  \(error)")
				return returnJSON(nil, "Error decode JSON.")
			}
		}
	}

	func encodeJSON<T: Encodable>(models: T, returnData: @escaping (Data?, String) -> Void) {
		DispatchQueue.main.async {
			do {
				let data = try JSONEncoder().encode(models)
				return returnData(data, "")
			} catch {
				return returnData(nil, "Error decode in data.")
			}
		}
	}
}
