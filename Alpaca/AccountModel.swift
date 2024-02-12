//
//  AccountModel.swift
//  SimpleTickerTracker
//
//  Created by Mikhail Kirillov on 12/02/2024.
//

import Foundation

class AccountViewModel: ObservableObject {
		@Published var accountInfo: AccountInfo?
		
		func fetchAccountInfo() {
		}
}

struct AccountInfo: Codable {
		var equity: Double
		var buyingPower: Double
}
