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
    @ObservedObject private var orientationManager: OrientationManager
    
    init(viewModel: ApostolatorViewModel, orientationManager: OrientationManager = OrientationManager()) {
        self.viewModel = viewModel
        self.orientationManager = orientationManager
    }

    var body: some View {
        switch orientationManager.orientation {
        case .portrait:
            VStack(alignment: .center) {
                MainContent(viewModel: viewModel, orientationManager: orientationManager)
            }
        case .landscape:
            HStack {
                VStack(alignment: .leading) {
                    MainContent(viewModel: viewModel, orientationManager: orientationManager)
                }
                    
            }.frame(maxWidth: .infinity, alignment: .leading)
        }
    }
}

struct MainContent: View {
    @ObservedObject var viewModel: ApostolatorViewModel
    @ObservedObject private var orientationManager: OrientationManager
    
    init(viewModel: ApostolatorViewModel, orientationManager: OrientationManager) {
        self.viewModel = viewModel
        self.orientationManager = orientationManager
    }
    
    var body: some View {
        if orientationManager.orientation == .landscape {
            HStack {
                PrimaryContent(viewModel: viewModel, orientationManager: orientationManager)
            }
        } else {
            VStack {
                PrimaryContent(viewModel: viewModel, orientationManager: orientationManager)
            }
        }
    }
}


struct PrimaryContent: View {
    @ObservedObject var viewModel: ApostolatorViewModel
    @ObservedObject private var orientationManager: OrientationManager
    
    init(viewModel: ApostolatorViewModel, orientationManager: OrientationManager) {
        self.viewModel = viewModel
        self.orientationManager = orientationManager
    }
    
    var body: some View {
        VStack(alignment: orientationManager.orientation == .portrait ? .trailing : .leading) {
            ScrollViewReader { scrollViewProxy in
                List(viewModel.engine.results) { result in
                    HStack {
                        
                        Text("\(result.firstValue) \(result.sign) \(result.lastValue) = \(result.total)")
                            .foregroundStyle(.primaryText)
                            .font(.system(size: viewModel.buttonLayout.scrollViewTextSize))
                            .opacity(0.5)
                            
                            .accessibilityIdentifier("operationAgendaTXT")
                            .frame(minWidth: 60,maxWidth: .infinity, maxHeight: .infinity, alignment: .leading)
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
            }.frame(maxWidth: .infinity, maxHeight: .infinity, alignment: .leading)
        }.padding(.top).frame(maxWidth: .infinity,maxHeight: .infinity, alignment: .leading)
        
        VStack(alignment: orientationManager.orientation == .landscape ?  .trailing : .center) {
            HStack {
                Text(viewModel.engine.text)
                    .multilineTextAlignment(.trailing)
                    .font(.system(size: viewModel.buttonLayout.textSize))
                    .foregroundColor(.primaryText)
                    .accessibilityIdentifier("resultText")
            }.frame(maxWidth: .infinity, alignment: .trailing)
                .padding(.trailing, 40)
            
            HStack {
                Spacer()
                if orientationManager.orientation == .landscape {
                    VStack(alignment: .leading) {
                        ForEach(viewModel.landscapeButtons().indices, id: \.self) { rowIndex in
                            HStack(spacing: viewModel.buttonLayout.separation) {
                                ForEach(viewModel.landscapeButtons()[rowIndex]) { button in
                                    StandardButton(model: button, isSelected: viewModel.selectedButtonId == button.id, action: {
                                        viewModel.selectButton(id: button.id)
                                        button.action()
                                    }).accessibilityIdentifier("btn\(button.text)")
                                }
                            }
                        }
                    }.padding(.trailing, viewModel.buttonLayout.separation)
                        
                }
                VStack {
                    ForEach(viewModel.buttons().indices, id: \.self) { rowIndex in
                        HStack(spacing: viewModel.buttonLayout.separation) {
                            ForEach(viewModel.buttons()[rowIndex]) { button in
                                StandardButton(model: button, isSelected: viewModel.selectedButtonId == button.id, action: {
                                    viewModel.selectButton(id: button.id)
                                    button.action()
                                }).accessibilityIdentifier("btn\(button.text)")
                            }
                        }
                    }
                }
            }.frame(maxWidth: .infinity, alignment: .leading).padding(.trailing, orientationManager.orientation == .portrait ? 40 : 0)
        }
    }
}




#Preview {
    ContentView(viewModel: ApostolatorViewModel(engine: Engine()), orientationManager: OrientationManager())
}


extension Color {
    var customLightGray: Color {
        Color("CustomcustomLightGray")
    }
    
    var primaryText: Color {
        Color("primaryText")
    }
}
