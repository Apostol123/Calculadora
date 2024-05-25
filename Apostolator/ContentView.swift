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
    @ObservedObject var viewModel: ApostolatorViewModel
    var body: some View {
        VStack {
            Spacer()
            HStack(spacing: 20) {
                Spacer(); Text(viewModel.engine.text)
                    .multilineTextAlignment(.trailing)
                    .font(.system(size: 40))
                    .foregroundStyle(.white)
                
            }.padding(.trailing, 40)
            ForEach(viewModel.buttons.indices, id: \.self) { rowIndex in
                HStack(spacing: 20, content: {
                    ForEach(viewModel.buttons[rowIndex]) { button in
                        StandardButton(model: button, isSelected: viewModel.selectedButtonId == button.id, action: {
                            viewModel.selectButton(id: button.id)
                            button.action()
                        })
                    }
                })
            }
        }
        .padding()
    }
}

//#Preview {
////    ContentView(current: Event.value(0))
//}


extension Color {
    var customLightGray: Color {
        Color("CustomcustomLightGray")
    }
}
