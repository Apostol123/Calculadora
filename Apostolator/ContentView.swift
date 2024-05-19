//
//  ContentView.swift
//  Apostolator
//
//  Created by Alex.personal on 18/5/24.
//

import SwiftUI
import Engine
import DesignSystem

struct ContentView: View {
    var body: some View {
        VStack {
            Spacer()
            Spacer()
            Spacer()
            Spacer()
            Spacer()
            Spacer()
            HStack(spacing: 20) {
                Spacer(); Text("test").multilineTextAlignment(.trailing)
                    .font(.system(size: 40))
                    .foregroundStyle(.white)
            }.padding(.trailing, 40)
            
            Spacer()
            HStack(spacing: 20) {
                StandardButton(text: "AC", textColor: .black, backgroundColor: .customLightGray, action: {
                    Engine.observeEvent(.action(.reset))
                })
                StandardButton(text: "+/-", textColor: .black, backgroundColor: .customLightGray, action: {
                    Engine.observeEvent(.action(.toggleValueType))
                })
                StandardButton(text: "%", textColor: .black, backgroundColor: .customLightGray, action: {
                    Engine.observeEvent(.action(.percentage))
                })
                StandardButton(text: "➗", textColor: .white, backgroundColor: .orange, action: {
                    Engine.observeEvent(.action(.split))
                })
            }
            HStack(spacing: 20) {
                StandardButton(text: "7", textColor: .white, backgroundColor: .gray, action: {
                    Engine.observeEvent(.value(7))
                })
                StandardButton(text: "8", textColor: .white, backgroundColor: .gray, action: {
                    Engine.observeEvent(.value(8))
                })
                StandardButton(text: "9", textColor: .white, backgroundColor: .gray, action: {
                    Engine.observeEvent(.value(9))
                })
                StandardButton(text: "X", textColor: .white, backgroundColor: .orange, action: {
                    Engine.observeEvent(.action(.multiply))
                })
            }
            HStack(spacing: 20) {
                StandardButton(text: "4", textColor: .white, backgroundColor: .gray, action: {
                    Engine.observeEvent(.value(4))
                })
                StandardButton(text: "5", textColor: .white, backgroundColor: .gray, action: {
                    Engine.observeEvent(.value(5))
                })
                StandardButton(text: "6", textColor: .white, backgroundColor: .gray, action: {
                    Engine.observeEvent(.value(6))
                })
                StandardButton(text: "-", textColor: .white, backgroundColor: .orange, action: {
                    Engine.observeEvent(.action(.subtract))
                })
            }
            HStack(spacing: 20) {
                StandardButton(text: "1", textColor: .white, backgroundColor: .gray, action: {
                    Engine.observeEvent(.value(1))
                })
                StandardButton(text: "2", textColor: .white, backgroundColor: .gray, action: {
                    Engine.observeEvent(.value(2))
                })
                StandardButton(text: "3", textColor: .white, backgroundColor: .gray, action: {
                    Engine.observeEvent(.value(3))
                })
                StandardButton(text: "+", textColor: .white, backgroundColor: .orange, action: {
                    Engine.observeEvent(.action(.add))
                })
            }
            HStack(spacing: 20) {
                StandardButton(text: "0", textColor: .white, backgroundColor: .gray, width: 144, height: 60 ,action: {
                    Engine.observeEvent(.value(0))
                })
                StandardButton(text: ".", textColor: .white, backgroundColor: .gray, action: {
                    Engine.observeEvent(.action(.separator))
                })
                StandardButton(text: "=", textColor: .white, backgroundColor: .gray, action: {
                    Engine.observeEvent(.action(.result))
                })
            }
        }
        .padding()
    }
}

#Preview {
    ContentView()
}


extension Color {
    var customLightGray: Color {
        Color("CustomcustomLightGray")
    }
}
