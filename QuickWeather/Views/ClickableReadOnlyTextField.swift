//
//  ClickableReadOnlyTextField.swift
//  QuickWeather
//
//  Created by Roger Andersen on 26.06.2024.
//

import SwiftUI

struct ClickableReadOnlyTextField: View {
    var placeholder: String
    var action: () -> Void

    @State private var text: String = ""

    var body: some View {
        ZStack {
            TextField(placeholder, text: $text)
                .disabled(true)
                .textFieldStyle(RoundedBorderTextFieldStyle())
                .padding()

            Button(action: action) {
                // Make the button invisible but clickable
                Color.clear
            }
        }
    }
}

#Preview {
    ClickableReadOnlyTextField(placeholder: "Search...", action: {})
}
