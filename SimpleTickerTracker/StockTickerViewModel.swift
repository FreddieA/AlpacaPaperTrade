//
//  File.swift
//  SimpleTickerTracker
//
//  Created by Mikhail Kirillov on 09/02/2024.
//

import Foundation
import SwiftUI
import Combine
import Network

struct StockTickerBatch: Decodable {
	let bestMatches: [StockTicker]
}

struct StockTicker: Decodable, Identifiable {
	let id = UUID()
	let symbol: String
	let name: String
	let type: String
	let region: String
	let marketOpen: String
	let marketClose: String
	let timezone: String
	let currency: String
	let matchScore: String
	
	enum CodingKeys: String, CodingKey {
		case symbol = "1. symbol"
		case name = "2. name"
		case type = "3. type"
		case region = "4. region"
		case marketOpen = "5. marketOpen"
		case marketClose = "6. marketClose"
		case timezone = "7. timezone"
		case currency = "8. currency"
		case matchScore = "9. matchScore"
	}
}

struct StockTickerGridView: View {
	@StateObject private var viewModel = StockTickerViewModel()
	@ObservedObject var searchViewModel: EmailValidationViewModel
	
	let columns: [GridItem] = Array(repeating: .init(.flexible()), count: 2) // Adjust the number of columns as needed
	
	init(searchViewModel: EmailValidationViewModel) {
		self.searchViewModel = searchViewModel
	}
	
	var body: some View {
		ScrollView {
			LazyVGrid(columns: columns, spacing: 20) {
				ForEach(viewModel.stockTickers.bestMatches) { ticker in
					VStack {
						Text(ticker.symbol)
							.font(.headline)
						Text(ticker.name.prefix(4))
							.font(.subheadline)
					}
					.padding()
					.background(Color.gray.opacity(0.2))
					.cornerRadius(10)
				}
			}
			.padding()
		}
	}
}

class StockTickerViewModel: ObservableObject {
		@Published var stockTickers: StockTickerBatch = StockTickerBatch(bestMatches: [])
		private var cancellables = Set<AnyCancellable>()
		private let apiKey = "YHZLHAYNKS4EM3HQ"
		
		func fetchStockTickers(prompt: String) {
				let urlString = "https://www.alphavantage.co/query?function=SYMBOL_SEARCH&keywords=\(prompt)&apikey=\(apiKey)"
				guard let url = URL(string: urlString.addingPercentEncoding(withAllowedCharacters: .urlQueryAllowed) ?? "") else { return }

				URLSession.shared.dataTaskPublisher(for: url)
				.map(\.data)
						.decode(type: StockTickerBatch.self, decoder: JSONDecoder()) // Adjust decoding based on the actual API response structure
						.replaceError(with: StockTickerBatch(bestMatches: []))
						.receive(on: DispatchQueue.main)
						.assign(to: &$stockTickers)
		}
}
