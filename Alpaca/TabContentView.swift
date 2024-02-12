//
//  TabView.swift
//  SimpleTickerTracker
//
//  Created by Mikhail Kirillov on 12/02/2024.
//

import SwiftUI

struct TabContentView: View {
		var body: some View {
				TabView {
						AccountView()
								.tabItem {
										Image(systemName: "person.fill")
										Text("My Account")
								}

						TickerSearchView()
								.tabItem {
										Image(systemName: "magnifyingglass")
										Text("Ticker Search")
								}

					PerformanceGraphView()
								.tabItem {
										Image(systemName: "chart.bar.fill")
										Text("Performance Graph")
								}
				}
		}
}
