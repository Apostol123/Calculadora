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
            ScrollViewReader { scrollViewProxy in
                            List(viewModel.engine.results) { result in
                                HStack {
                                    Spacer()
                                    Text("\(result.firstValue) \(result.sign) \(result.lastValue) = \(result.total)")
                                        .foregroundStyle(.customLightGray)
                                        .opacity(0.5)
                                        .multilineTextAlignment(.trailing)
                                }
                            }
                            .listStyle(.plain)
                            .listRowSeparator(.hidden)
                            .onChange(of: viewModel.engine.results) { _ in
                                if let lastResult = viewModel.engine.results.last {
                                    withAnimation {
                                        scrollViewProxy.scrollTo(lastResult.id, anchor: .bottom)
                                    }
                                }
                            }
                        }
                        .padding(EdgeInsets(top: 20, leading: 0, bottom: 20, trailing: 0))
            
            Spacer()
            HStack(spacing: 20) {
                Spacer()
                Text(viewModel.engine.text)
                    .multilineTextAlignment(.trailing)
                    .font(.system(size: 40))
                    .foregroundColor(.white)
            }
            .padding(.trailing, 40)
            
            ForEach(viewModel.buttons.indices, id: \.self) { rowIndex in
                HStack(spacing: 20) {
                    ForEach(viewModel.buttons[rowIndex]) { button in
                        StandardButton(model: button, isSelected: viewModel.selectedButtonId == button.id, action: {
                            viewModel.selectButton(id: button.id)
                            button.action()
                        })
                    }
                }
            }
        }
        .padding()
    }
}

#Preview {
    ContentView(viewModel: ApostolatorViewModel(engine: Engine()))
}


extension Color {
    var customLightGray: Color {
        Color("CustomcustomLightGray")
    }
}
