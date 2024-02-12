//
//  Endpoint.swift
//  SimpleTickerTracker
//
//  Created by Mikhail Kirillov on 12/02/2024.
//

import Foundation

protocol Endpoint {
		var baseURL: URL { get }
		var path: String { get }
		var method: String { get }
		var parameters: [String: Any]? { get }
}
