//
//  ContentView.swift
//  SimpleTickerTracker
//
//  Created by Mikhail Kirillov on 09/02/2024.
//

import SwiftUI

struct ContentView: View {
	
	let service = OldWebSocketService()
	
    var body: some View {

			Image(systemName: "globe")
					.imageScale(.large)
					.foregroundStyle(.tint)
		}
	
	init() {
		service.connect()
	}
}

#Preview {
    ContentView()
}
