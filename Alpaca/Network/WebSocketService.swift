//
//  WebSocketService.swift
//  SimpleTickerTracker
//
//  Created by Mikhail Kirillov on 12/02/2024.
//

import Foundation

class WebSocketService {
	private var webSocketTask: URLSessionWebSocketTask?
	private let config: NetworkConfig
	
	init(config: NetworkConfig) {
		self.config = config
	}
	
	func connect() {
		guard let url = URL(string: config.urlString) else {
			fatalError("could not connect")
		}
		webSocketTask = URLSession.shared.webSocketTask(with: url)
		webSocketTask?.resume()
		listen()
	}
	
	func send(message: String) {
		webSocketTask?.send(.string(message)) { error in
			if let error = error {
				print("WebSocket sending error: \(error)")
			}
		}
	}
	
	private func listen() {
		webSocketTask?.receive { [weak self] result in
			switch result {
			case .failure(let error):
				print("WebSocket receive error: \(error)")
			case .success(let message):
				switch message {
				case .string(let text):
					print("Received text: \(text)")
				case .data(let data):
					print("Received data: \(data)")
				@unknown default:
					break
				}
			}
			
			self?.listen()
		}
	}
	
	func disconnect() {
		webSocketTask?.cancel(with: .normalClosure, reason: nil)
	}
}
