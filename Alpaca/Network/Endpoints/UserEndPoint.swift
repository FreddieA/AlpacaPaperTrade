//
//  UserEndPoint.swift
//  SimpleTickerTracker
//
//  Created by Mikhail Kirillov on 12/02/2024.
//

import Foundation

enum UserAPI: Endpoint {
		case getUsers
		case createUser(name: String, email: String)
		
		var baseURL: URL { URL(string: "https://api.example.com")! }
		
		var path: String {
				switch self {
				case .getUsers:
						return "/users"
				case .createUser:
						return "/users/create"
				}
		}
		
		var method: String {
				switch self {
				case .getUsers:
						return "GET"
				case .createUser:
						return "POST"
				}
		}
		
		var parameters: [String: Any]? {
				switch self {
				case .getUsers:
						return nil
				case .createUser(let name, let email):
						return ["name": name, "email": email]
				}
		}
}

