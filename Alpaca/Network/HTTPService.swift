//
//  HttpClient.swift
//  SimpleTickerTracker
//
//  Created by Mikhail Kirillov on 12/02/2024.
//

import Foundation

class HTTPService {
	
	private let config: NetworkConfig
	
	init(config: NetworkConfig) {
		self.config = config
	}
	
	func request<T: Decodable>(endpoint: Endpoint, completion: @escaping (Result<T, Error>) -> Void) {
		var urlComponents = URLComponents(url: endpoint.baseURL.appendingPathComponent(endpoint.path), resolvingAgainstBaseURL: true)!
		if let parameters = endpoint.parameters,
			 endpoint.method == "GET" {
			urlComponents.queryItems = parameters.map { URLQueryItem(name: $0.key, value: "\($0.value)") }
		}
		
		var request = URLRequest(url: urlComponents.url!)
		request.httpMethod = endpoint.method
		
		if endpoint.method != "GET", let parameters = endpoint.parameters {
			request.httpBody = try? JSONSerialization.data(withJSONObject: parameters, options: [])
			request.addValue("application/json", forHTTPHeaderField: "Content-Type")
		}
		
		let task = URLSession.shared.dataTask(with: request) { data, response, error in
			guard let data = data, error == nil else {
				completion(.failure(error ?? NSError()))
				return
			}
			
			do {
				let result = try JSONDecoder().decode(T.self, from: data)
				completion(.success(result))
			} catch {
				completion(.failure(error))
			}
		}
		
		task.resume()
	}
}
