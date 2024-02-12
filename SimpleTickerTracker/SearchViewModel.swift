//
//  File.swift
//  SimpleTickerTracker
//
//  Created by Mikhail Kirillov on 09/02/2024.
//

import SwiftUI
import Combine

class EmailValidationViewModel: ObservableObject {
		// Input
		@Published var emailAddress = ""
		
		// Output
		@Published var isEmailAddressValid = false
		
		private var cancellables = Set<AnyCancellable>()
		
		init() {
				$emailAddress
						.map { email in
								// Simple regex for email validation
								let emailPattern = "[A-Z0-9a-z._%+-]+@[A-Za-z0-9.-]+\\.[A-Za-z]{2,}"
								let emailPred = NSPredicate(format:"SELF MATCHES %@", emailPattern)
								return emailPred.evaluate(with: email)
						}
						.assign(to: \.isEmailAddressValid, on: self)
						.store(in: &cancellables)
		}
}

struct User: Decodable, Identifiable {
		let id: Int
		let name: String
		let username: String
		let email: String
}

struct EmailValidationView: View {
		@StateObject private var viewModel = EmailValidationViewModel()
		
		var body: some View {
			
				VStack {
						TextField("Enter your email", text: $viewModel.emailAddress)
								.textFieldStyle(RoundedBorderTextFieldStyle())
								.padding()
						
					Text(viewModel.emailAddress)
				}
				.padding()
		}
}


#Preview {
	EmailValidationView()
}
