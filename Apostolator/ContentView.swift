//
//  ContentView.swift
//  Apostolator
//
//  Created by Alex.personal on 18/5/24.
//

import SwiftUI
import DesignSystem

struct ContentView: View {
    var body: some View {
        VStack {
            Spacer()
            HStack(spacing: 20) {
                StandardButton(text: "AC", textColor: .black, backgroundColor: .lightGray, action: {})
                StandardButton(text: "+/-", textColor: .black, backgroundColor: .lightGray, action: {})
                StandardButton(text: "%", textColor: .black, backgroundColor: .lightGray, action: {})
                StandardButton(text: "➗", textColor: .black, backgroundColor: .orange, action: {})
            }
            HStack(spacing: 20) {
                StandardButton(text: "7", textColor: .white, backgroundColor: .gray, action: {})
                StandardButton(text: "8", textColor: .white, backgroundColor: .gray, action: {})
                StandardButton(text: "9", textColor: .white, backgroundColor: .gray, action: {})
                StandardButton(text: "X", textColor: .white, backgroundColor: .orange, action: {})
            }
            HStack(spacing: 20) {
                StandardButton(text: "4", textColor: .white, backgroundColor: .gray, action: {})
                StandardButton(text: "5", textColor: .white, backgroundColor: .gray, action: {})
                StandardButton(text: "6", textColor: .white, backgroundColor: .gray, action: {})
                StandardButton(text: "-", textColor: .white, backgroundColor: .orange, action: {})
            }
            HStack(spacing: 20) {
                StandardButton(text: "1", textColor: .white, backgroundColor: .gray, action: {})
                StandardButton(text: "2", textColor: .white, backgroundColor: .gray, action: {})
                StandardButton(text: "3", textColor: .white, backgroundColor: .gray, action: {})
                StandardButton(text: "+", textColor: .white, backgroundColor: .orange, action: {})
            }
            HStack(spacing: 20) {
                StandardButton(text: "0", textColor: .white, backgroundColor: .gray, width: 144, height: 60 ,action: {})
                StandardButton(text: ".", textColor: .white, backgroundColor: .gray, action: {})
                StandardButton(text: "=", textColor: .white, backgroundColor: .gray, action: {})
            }
        }
        .padding()
    }
}

#Preview {
    ContentView()
}


extension Color {
    var lightGray: Color {
        Color("lightGray")
    }
}
