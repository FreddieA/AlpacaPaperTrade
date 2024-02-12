//
//  AccountView.swift
//  SimpleTickerTracker
//
//  Created by Mikhail Kirillov on 12/02/2024.
//

import SwiftUI

struct AccountView: View {
		@ObservedObject var viewModel = AccountViewModel()

		var body: some View {
				VStack {
						if let accountInfo = viewModel.accountInfo {
								Text("Equity: \(accountInfo.equity)")
								Text("Buying Power: \(accountInfo.buyingPower)")
						} else {
								Text("Fetching account info...")
						}
				}
				.onAppear {
						viewModel.fetchAccountInfo()
				}
		}
}
