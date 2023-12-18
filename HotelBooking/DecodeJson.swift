//
//  DecodeJson.swift
//  HotelBooking
//
//  Created by Steven Kirke on 08.09.2023.
//

import Foundation

protocol IDecodeJSON {
	func decodeJSON<T: Decodable>(data: Data, model: T, returnJSON: @escaping (Result<T, ErrorResponce>) -> Void)
	func encodeJSON<T: Encodable>(models: T, returnData: @escaping (Result<Data?, ErrorResponce>) -> Void)
}

final class DecodeJson {

	enum DecodeError: Error {
		case errorDecodeJson(Error)
		case errorEncodeJson(Error)
	}

	func decodeJSON<T: Decodable>(data: Data, model: T, returnJSON: @escaping (Result<T, DecodeError>) -> Void) {
		DispatchQueue.main.async {
			do {
				let json = try JSONDecoder().decode(T.self, from: data)
				return returnJSON(.success(json))
			} catch let error {
				return returnJSON(.failure(.errorDecodeJson(error)))
			}
		}
	}

	func encodeJSON<T: Encodable>(models: T, returnData: @escaping (Result<Data?, DecodeError>) -> Void) {
		DispatchQueue.main.async {
			do {
				let data = try JSONEncoder().encode(models)
				returnData(.success(data))
			} catch let error {
				returnData(.failure(.errorEncodeJson(error)))
			}
		}
	}
}
