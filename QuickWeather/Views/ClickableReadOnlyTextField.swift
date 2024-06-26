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

    var body: some View {
        ZStack {
            TextField(placeholder, text: .constant(""))
                .opacity(0)
                .disabled(true)

            HStack {
                Text(placeholder).foregroundColor(.secondary)
                Spacer()
            }
            .background(RoundedRectangle(cornerRadius: 8).fill(Color.white))

            Button(action: action) {
                Color.clear
            }
        }.fixedSize(horizontal: false, vertical: /*@START_MENU_TOKEN@*/true/*@END_MENU_TOKEN@*/)
    }
}

#Preview {
    ClickableReadOnlyTextField(placeholder: "Search...", action: {})
}
