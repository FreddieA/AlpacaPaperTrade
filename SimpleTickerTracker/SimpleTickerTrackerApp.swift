//
//  SimpleTickerTrackerApp.swift
//  SimpleTickerTracker
//
//  Created by Mikhail Kirillov on 09/02/2024.
//

import SwiftUI
import Combine

@main
struct SimpleTickerTrackerApp: App {
	
	private var cancellables = Set<AnyCancellable>()
		
    var body: some Scene {
        WindowGroup {
					TabContentView()
				}
		}
}

struct Item: Identifiable {
		var id: Int
		var name: String
}

class ItemListViewModel: ObservableObject {
		// Published property to store the list of items
		@Published var items: [Item] = []
		
		// Function to simulate fetching data
		func fetchItems() {
				// Simulate an asynchronous data fetch with a delay
				DispatchQueue.main.asyncAfter(deadline: .now() + 2) {
						// Example items
						self.items = [
								Item(id: 1, name: "Item 1"),
								Item(id: 2, name: "Item 2"),
								Item(id: 3, name: "Item 3")
						]
				}
		}
}

struct ItemListView: View {
		// Connect the ViewModel to the View
		@ObservedObject var viewModel = ItemListViewModel()
		
		var body: some View {
				NavigationView {
						List(viewModel.items) { item in
								Text(item.name)
						}
						.navigationTitle("Items")
						.onAppear {
								viewModel.fetchItems() // Fetch items when the view appears
						}
				}
		}
}

struct ItemListView_Previews: PreviewProvider {
		static var previews: some View {
			VStack {
//				EmailValidationView()
//				StockTickerGridView()
			}
		}
}
