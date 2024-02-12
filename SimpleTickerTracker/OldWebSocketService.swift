//
//  WebSocketService.swift
//  SimpleTickerTracker
//
//  Created by Mikhail Kirillov on 11/02/2024.
//

import Foundation

class OldWebSocketService {
	private var webSocketTask: URLSessionWebSocketTask?
	private let apiKey = "{PKYSBVYT7F1SZMTNCHJF}"
	private let apiSecret = "{YuGs1fM7pzSeOaYspG4vw8H8pj7fJFidZsfh3aIA}"
	
	func connect() {
		let url = URL(string: "wss://paper-api.alpaca.markets/stream")!
		webSocketTask = URLSession.shared.webSocketTask(with: url)
		webSocketTask?.resume()
		
		authenticate()
		listenForMessages()
	}
	
	private func createAuthMessage(apiKey: String, apiSecret: String) -> String? {
			let authDict: [String: Any] = [
					"action": "auth",
					"key": apiKey,
					"secret": apiSecret
			]
			
			guard let jsonData = try? JSONSerialization.data(withJSONObject: authDict, options: []) else {
					print("Error: Unable to serialize authentication dictionary to JSON")
					return nil
			}
			
			return String(data: jsonData, encoding: .utf8)
	}
	
	private func authenticate() {
		guard let authMessage = createAuthMessage(apiKey: apiKey, apiSecret: apiSecret) else { return }
		
		webSocketTask?.send(.string(authMessage)) { error in
			if let error = error {
				print("Error sending authentication message: \(error)")
			}
		}
	}
	
	private func listenForMessages() {
		webSocketTask?.receive { [weak self] result in
			switch result {
			case .failure(let error):
				print("Error in receiving message: \(error)")
			case .success(let message):
				switch message {
				case .string(let text):
					print("Received string: \(text)")
				case .data(let data):
					print("Received data: \(data)")
				@unknown default:
					print("Unknown message type")
				}
			}
			
			// Listen for the next message
			self?.listenForMessages()
		}
	}
	
	func disconnect() {
		webSocketTask?.cancel(with: .normalClosure, reason: nil)
	}
}
