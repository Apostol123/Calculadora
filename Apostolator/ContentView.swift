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
    @StateObject private var orientationManager = OrientationManager()

    var body: some View {
        switch orientationManager.orientation {
        case .portrait:
            VStack(alignment: .center) {
                MainContent(viewModel: viewModel)
            }
        case .landscape:
            HStack {
                VStack(alignment: .trailing) {
                    MainContent(viewModel: viewModel)
                }
                    
            }.frame(maxWidth: .infinity, alignment: .trailing)
        }
    }
}

struct MainContent: View {
    @ObservedObject var viewModel: ApostolatorViewModel
    @StateObject private var orientation = OrientationManager()
    
    var body: some View {
        if orientation.orientation == .landscape {
            HStack {
                PrimaryContent(viewModel: viewModel)
            }
        } else {
            VStack {
                PrimaryContent(viewModel: viewModel)
            }
        }
    }
}


struct PrimaryContent: View {
    @ObservedObject var viewModel: ApostolatorViewModel
    @StateObject private var orientation = OrientationManager()
    
    var body: some View {
        VStack(alignment: .trailing) {
            ScrollViewReader { scrollViewProxy in
                List(viewModel.engine.results) { result in
                    HStack {
                        
                        Text("\(result.firstValue) \(result.sign) \(result.lastValue) = \(result.total)")
                            .foregroundStyle(.primaryText)
                            .font(.system(size: viewModel.buttonLayout.scrollViewTextSize))
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
        }.padding(.top)
        
        VStack(alignment: orientation.orientation == .landscape ?  .trailing : .center) {
            HStack {
                Text(viewModel.engine.text)
                    .multilineTextAlignment(.trailing)
                    .font(.system(size: viewModel.buttonLayout.textSize))
                    .foregroundColor(.primaryText)
            }.frame(maxWidth: .infinity, alignment: .trailing)
                .padding(.trailing, 40)
            
            VStack {
                ForEach(viewModel.buttons().indices, id: \.self) { rowIndex in
                    HStack(spacing: viewModel.buttonLayout.separation) {
                        ForEach(viewModel.buttons()[rowIndex]) { button in
                            StandardButton(model: button, isSelected: viewModel.selectedButtonId == button.id, action: {
                                viewModel.selectButton(id: button.id)
                                button.action()
                            })
                        }
                    }
                }
            }
        }
    }
}




#Preview {
    ContentView(viewModel: ApostolatorViewModel(engine: Engine()))
}


extension Color {
    var customLightGray: Color {
        Color("CustomcustomLightGray")
    }
    
    var primaryText: Color {
        Color("primaryText")
    }
}
