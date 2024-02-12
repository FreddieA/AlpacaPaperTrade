//
//  NetworkConfig.swift
//  SimpleTickerTracker
//
//  Created by Mikhail Kirillov on 12/02/2024.
//

import Foundation

struct NetworkConfig {
	let apiKey: String
	let apiSecret: String
	let urlString: String = "wss://paper-api.alpaca.markets/stream"
	
	public init(apiKey: String = "{PKYSBVYT7F1SZMTNCHJF}",
							apiSecret: String = "{YuGs1fM7pzSeOaYspG4vw8H8pj7fJFidZsfh3aIA}") {
		self.apiKey = apiKey
		self.apiSecret = apiSecret
	}
}
