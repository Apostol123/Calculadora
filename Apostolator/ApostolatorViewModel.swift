//
//  ApostolatorViewModel.swift
//  Apostolator
//
//  Created by Alex.personal on 22/5/24.
//

import Foundation
import SwiftUI
import Engine
import DesignSystem
import Combine

class ApostolatorViewModel: ObservableObject {
    @Published var selectedButtonId: Int? = nil
    @Published var specialAction: Action = .idle
    @Published var engine: Engine
    @Published var orientation = OrientationManager()
    var cancellable: AnyCancellable?
    var buttonLayout: ButtonLayout {
        ButtonLayout(orientation: orientation.orientation)
    }
    
    init(engine: Engine) {
        self.engine = engine
        cancellable = orientation.$orientation.sink { [weak self] orientation in
            self?.engine.decimals = orientation == .landscape ? 12 : 3
            self?.engine.updateNumberLength(orientation == .landscape ? 18 : 11)
        }
    }
    
    func  buttons() ->  [[ButtonModel]] { 
        portraitButtons()
    }
    
    private func portraitButtons() -> [[ButtonModel]] {
        [
            [ ButtonModel(id: 0, text: "AC",textColor: .black, backgroundColor: .customLightGray, width: buttonLayout.buttonWidth, height: buttonLayout.buttonHeight ,action: {
                [weak self] in
                self?.engine.observeEvent(.action(.reset))
            }),
              ButtonModel(id: 1, text: "+/-", textColor: .black, backgroundColor: .customLightGray, width: buttonLayout.buttonWidth, height: buttonLayout.buttonHeight, action: {
                  [weak self] in
                  self?.engine.observeEvent(.action(.toggleValueType))
              }),
              ButtonModel(id: 2, text: "%", textColor: .black, backgroundColor: .customLightGray, width: buttonLayout.buttonWidth, height: buttonLayout.buttonHeight,action: {
                  [weak self] in
                  self?.engine.observeEvent(.action(.percentage))
              }),
              ButtonModel(id: 3, text: "➗", textColor: .black, backgroundColor: .orange, width: buttonLayout.buttonWidth, height: buttonLayout.buttonHeight, staySelected: true, action: {
                  [weak self] in
                  self?.engine.observeEvent(.action(.split))
              })],
            
            [ ButtonModel(id: 4, text: "7", textColor: .white, backgroundColor: .gray, width: buttonLayout.buttonWidth, height: buttonLayout.buttonHeight, action: { [weak self] in
                self?.engine.observeEvent(.value("7"))
            }),
              ButtonModel(id: 5, text: "8", textColor: .white, backgroundColor: .gray, width: buttonLayout.buttonWidth, height: buttonLayout.buttonHeight, action: { [weak self] in
                  self?.engine.observeEvent(.value("8"))
                  
              }),
              ButtonModel(id: 6, text: "9", textColor: .white, backgroundColor: .gray, width: buttonLayout.buttonWidth, height: buttonLayout.buttonHeight, action: {
                  [weak self] in
                  self?.engine.observeEvent(.value("9"))
                  
              }),
              ButtonModel(id: 7, text: "X", textColor: .white, backgroundColor: .orange,  width: buttonLayout.buttonWidth, height: buttonLayout.buttonHeight, staySelected: true, action: {
                  [weak self] in
                  self?.engine.observeEvent(.action(.multiply))
              })],
            
            [  ButtonModel(id: 8, text: "4", textColor: .white, backgroundColor: .gray, width: buttonLayout.buttonWidth, height: buttonLayout.buttonHeight, action: {
                [weak self] in
                self?.engine.observeEvent(.value("4"))
                
            }),
               ButtonModel(id: 9, text: "5", textColor: .white, backgroundColor: .gray, width: buttonLayout.buttonWidth, height: buttonLayout.buttonHeight, action: {[weak self] in
                   self?.engine.observeEvent(.value("5"))
                   
               }),
               ButtonModel(id: 10, text: "6", textColor: .white, backgroundColor: .gray, width: buttonLayout.buttonWidth, height: buttonLayout.buttonHeight, action: { [weak self] in
                   self?.engine.observeEvent(.value("6"))
                   
               }),
               ButtonModel(id: 11, text: "-", textColor: .white, backgroundColor: .orange,  width: buttonLayout.buttonWidth, height: buttonLayout.buttonHeight, staySelected: true, action: {
                   [weak self] in
                   self?.engine.observeEvent(.action(.subtract))
               })],
            
            [
                ButtonModel(id: 12, text: "1", textColor: .white, backgroundColor: .gray, width: buttonLayout.buttonWidth, height: buttonLayout.buttonHeight, action: {
                    [weak self] in
                    self?.engine.observeEvent(.value("1"))
                    
                }),
                ButtonModel(id: 13, text: "2", textColor: .white, backgroundColor: .gray, width: buttonLayout.buttonWidth, height: buttonLayout.buttonHeight, action: {
                    [weak self] in
                    self?.engine.observeEvent(.value("2"))
                    
                }),
                ButtonModel(id: 14, text: "3", textColor: .white, backgroundColor: .gray, width: buttonLayout.buttonWidth, height: buttonLayout.buttonHeight, action: {
                    [weak self] in
                    self?.engine.observeEvent(.value("3"))
                    
                }),
                ButtonModel(id: 15, text: "+", textColor: .white, backgroundColor: .orange,  width: buttonLayout.buttonWidth, height: buttonLayout.buttonHeight, staySelected: true, action: {
                    [weak self] in
                    self?.specialAction = .add
                    self?.engine.observeEvent(.action(.add))
                })
            ],
            [
                ButtonModel(id: 16, text: "0", textColor: .white, backgroundColor: .gray, width: buttonLayout.zerobuttonWidth, height: buttonLayout.zerobuttonLayoutHeight, action: {
                    [weak self] in
                    self?.engine.observeEvent(.value("0"))
                }),
                ButtonModel(id: 17, text: ".", textColor: .white, backgroundColor: .gray, width: buttonLayout.buttonWidth, height: buttonLayout.buttonHeight, action: {
                    [weak self] in
                    self?.engine.observeEvent(.value(","))
                }),
                ButtonModel(id: 18, text: "=", textColor: .white, backgroundColor: .gray, width: buttonLayout.buttonWidth, height: buttonLayout.buttonHeight, action: {
                    [weak self] in
                    self?.engine.observeEvent(.action(.result))
                })
            ]
            
        ]
    }
    
    public func landscapeButtons() -> [[ButtonModel]] {
       [
        fifthRowLandscapeOnlyButtons().reversed(),
        forthRowLandscapeOnlyButtons().reversed(),
        thirdRowLandscapeOnlyButtons().reversed(),
        secondRowLandscapeOnlyButtons().reversed(),
        firstRowLandscapeOnlyButtons().reversed()
       ]
    }
    
    private func fifthRowLandscapeOnlyButtons() -> [ButtonModel] {
        [
            ButtonModel(id: 124,
                        text: "mr",
                        fontSize: 20,
                        textColor: .white,
                        backgroundColor: .gray,
                        width: buttonLayout.buttonWidth,
                        height: buttonLayout.buttonHeight,
                        action: {}),
            ButtonModel(id: 125,
                        text: "m-",
                        fontSize: 15,
                        textColor: .white,
                        backgroundColor: .gray,
                        width: buttonLayout.buttonWidth,
                        height: buttonLayout.buttonHeight,
                        action: {}),
            ButtonModel(id: 126,
                        text: "m+",
                        fontSize: 15,
                        textColor: .white,
                        backgroundColor: .gray,
                        width: buttonLayout.buttonWidth,
                        height: buttonLayout.buttonHeight,
                        action: {}),
            ButtonModel(id: 127,
                        text: "mc",
                        fontSize: 15,
                        textColor: .white,
                        backgroundColor: .gray,
                        width: buttonLayout.buttonWidth,
                        height: buttonLayout.buttonHeight,
                        action: {}),
            ButtonModel(id: 128,
                        text: ")",
                        fontSize: 15,
                        textColor: .white,
                        backgroundColor: .gray,
                        width: buttonLayout.buttonWidth,
                        height: buttonLayout.buttonHeight,
                        action: {}),
            ButtonModel(id: 129,
                        text: "(",
                        fontSize: 15,
                        textColor: .white,
                        backgroundColor: .gray,
                        width: buttonLayout.buttonWidth,
                        height: buttonLayout.buttonHeight,
                        action: {}),
        ]
    }
    
    private func forthRowLandscapeOnlyButtons() -> [ButtonModel]  {
        [
            ButtonModel(id: 118,
                        text: "10",
                        fontSize: 15,
                        textColor: .white,
                        backgroundColor: .gray,
                        width: buttonLayout.buttonWidth,
                        height: buttonLayout.buttonHeight,
                        superIndex: "x",
                        action: {}),
            ButtonModel(id: 119,
                        text: "e",
                        fontSize: 15,
                        textColor: .white,
                        backgroundColor: .gray,
                        width: buttonLayout.buttonWidth,
                        height: buttonLayout.buttonHeight,
                        superIndex: "x",
                        action: {}),
            ButtonModel(id: 120,
                        text: "x",
                        fontSize: 15,
                        textColor: .white,
                        backgroundColor: .gray,
                        width: buttonLayout.buttonWidth,
                        height: buttonLayout.buttonHeight,
                        superIndex: "y",
                        action: {}),
            ButtonModel(id: 121,
                        text: "x",
                        fontSize: 15,
                        textColor: .white,
                        backgroundColor: .gray,
                        width: buttonLayout.buttonWidth,
                        height: buttonLayout.buttonHeight,
                        superIndex: "3",
                        action: {}),
            ButtonModel(id: 122,
                        text: "x",
                        fontSize: 15,
                        textColor: .white,
                        backgroundColor: .gray,
                        width: buttonLayout.buttonWidth,
                        height: buttonLayout.buttonHeight,
                        superIndex: "2",
                        action: {}),
            ButtonModel(id: 123,
                        text: "2",
                        fontSize: 15,
                        textColor: .white,
                        backgroundColor: .gray,
                        width: buttonLayout.buttonWidth,
                        height: buttonLayout.buttonHeight,
                        superIndex: "nd",
                        action: {}),
        
        ]
    }
    
    private func thirdRowLandscapeOnlyButtons() -> [ButtonModel]  {
        [
            ButtonModel(id: 112,
                        text: "log",
                        fontSize: 15,
                        textColor: .white,
                        backgroundColor: .gray,
                        width: buttonLayout.buttonWidth,
                        height: buttonLayout.buttonHeight,
                        subIndex: "10",
                        action: { [weak self] in
                            self?.engine.observeEvent(.action(.landscapeAction(.log10)))
                        }),
            ButtonModel(id: 113,
                        text: "ln",
                        fontSize: 15,
                        textColor: .white,
                        backgroundColor: .gray,
                        width: buttonLayout.buttonWidth,
                        height: buttonLayout.buttonHeight,
                        action: {}),
            ButtonModel(id: 114,
                        text: "",
                        fontSize: 15,
                        textColor: .white,
                        backgroundColor: .gray,
                        width: buttonLayout.buttonWidth,
                        height: buttonLayout.buttonHeight,
                        subIndex: "x",
                        superIndex: "y",
                        action: {}),
            ButtonModel(id: 115,
                        text: "",
                        fontSize: 15,
                        textColor: .white,
                        backgroundColor: .gray,
                        width: buttonLayout.buttonWidth,
                        height: buttonLayout.buttonHeight,
                        subIndex: "x",
                        superIndex: "3",
                        action: {}),
            ButtonModel(id: 116,
                        text: "",
                        fontSize: 15,
                        textColor: .white,
                        backgroundColor: .gray,
                        width: buttonLayout.buttonWidth,
                        height: buttonLayout.buttonHeight,
                        subIndex: "x",
                        superIndex: "2",
                        action: {}),
            ButtonModel(id: 117,
                        text: "",
                        fontSize: 15,
                        textColor: .white,
                        backgroundColor: .gray,
                        width: buttonLayout.buttonWidth,
                        height: buttonLayout.buttonHeight,
                        subIndex: "x",
                        superIndex: "1",
                        action: {}),
            ]
    }
    
    private func secondRowLandscapeOnlyButtons() -> [ButtonModel] {
        [
            ButtonModel(id: 12313,
                        text: "EE",
                        fontSize: 15,
                        textColor: .white,
                        backgroundColor: .gray,
                        width: buttonLayout.buttonWidth,
                        height: buttonLayout.buttonHeight,
                        action: {}),
            ButtonModel(id: 107,
                        text: "e",
                        fontSize: 15,
                        textColor: .white,
                        backgroundColor: .gray,
                        width: buttonLayout.buttonWidth,
                        height: buttonLayout.buttonHeight,
                        action: {}),
            ButtonModel(id: 108,
                        text: "tan",
                        fontSize: 15,
                        textColor: .white,
                        backgroundColor: .gray,
                        width: buttonLayout.buttonWidth,
                        height: buttonLayout.buttonHeight,
                        action: { [weak self] in
                            self?.engine.observeEvent(.action(.landscapeAction(.tan)))
                        }),
            ButtonModel(id: 109,
                        text: "cos",
                        fontSize: 15,
                        textColor: .white,
                        backgroundColor: .gray,
                        width: buttonLayout.buttonWidth,
                        height: buttonLayout.buttonHeight,
                        action: {[weak self] in
                            self?.engine.observeEvent(.action(.landscapeAction(.cos)))}),
            ButtonModel(id: 110,
                        text: "sin",
                        fontSize: 15,
                        textColor: .white,
                        backgroundColor: .gray,
                        width: buttonLayout.buttonWidth,
                        height: buttonLayout.buttonHeight,
                        action: {[weak self] in
                            self?.engine.observeEvent(.action(.landscapeAction(.sin)))}),
            ButtonModel(id: 111,
                        text: "x!",
                        fontSize: 15,
                        textColor: .white,
                        backgroundColor: .gray,
                        width: buttonLayout.buttonWidth,
                        height: buttonLayout.buttonHeight,
                        action: {})
        ]
    }
    
    private func firstRowLandscapeOnlyButtons() -> [ButtonModel] {
        [
            ButtonModel(id: 100,
                        text: "Rand",
                        fontSize: 15,
                        textColor: .white,
                        backgroundColor: .gray,
                        width: buttonLayout.buttonWidth,
                        height: buttonLayout.buttonHeight,
                        action: {[weak self] in
                            self?.engine.observeEvent(.action(.landscapeAction(.rand)))
                            
                        }),
            ButtonModel(id: 101,
                        text: "π",
                        fontSize: 15,
                        textColor: .white,
                        backgroundColor: .gray,
                        width: buttonLayout.buttonWidth,
                        height: buttonLayout.buttonHeight,
                        action: {[weak self] in
                            self?.engine.observeEvent(.action(.landscapeAction(.pi)))
                            
                        }),
            
            ButtonModel(id: 103,
                        text: "tanh",
                        fontSize: 15,
                        textColor: .white,
                        backgroundColor: .gray,
                        width: buttonLayout.buttonWidth,
                        height: buttonLayout.buttonHeight,
                        action: {[weak self] in
                            self?.engine.observeEvent(.action(.landscapeAction(.tanh)))
                            
                        }),
            
            ButtonModel(id: 104,
                        text: "cosh",
                        fontSize: 15,
                        textColor: .white,
                        backgroundColor: .gray,
                        width: buttonLayout.buttonWidth,
                        height: buttonLayout.buttonHeight,
                        action: {[weak self] in
                            self?.engine.observeEvent(.action(.landscapeAction(.cosh)))
                        }),
            ButtonModel(id: 105,
                        text: "sinh",
                        fontSize: 15,
                        textColor: .white,
                        backgroundColor: .gray,
                        width: buttonLayout.buttonWidth,
                        height: buttonLayout.buttonHeight,
                        action: {[weak self] in
                            self?.engine.observeEvent(.action(.landscapeAction(.sinh)))}),
            
            ButtonModel(id: 106,
                        text: "Rad",
                        fontSize: 15,
                        textColor: .white,
                        backgroundColor: .gray,
                        width: buttonLayout.buttonWidth,
                        height: buttonLayout.buttonHeight,
                        action: {})
            
            
        ]
        
    }
    
    func selectButton(id: Int) {
        selectedButtonId = id
    }
}


struct ButtonLayout {
    var orientation: OrientationManager.Orientation

    var buttonWidth: CGFloat
    var buttonHeight: CGFloat
    var separation: CGFloat
    var textSize: CGFloat
    var scrollViewTextSize: CGFloat
    var zerobuttonWidth: CGFloat
    var zerobuttonLayoutHeight: CGFloat

    init(orientation: OrientationManager.Orientation) {
        self.orientation = orientation

        switch orientation {
        case .landscape:
            self.buttonWidth = 52
            self.buttonHeight = 52
            self.separation = 15
            self.textSize = 30
            self.scrollViewTextSize = 15
            self.zerobuttonWidth = 100
            self.zerobuttonLayoutHeight = 42
        case .portrait:
            self.buttonWidth = 62
            self.buttonHeight = 62
            self.separation = 20
            self.textSize = 40
            self.scrollViewTextSize = 30
            self.zerobuttonWidth = 144
            self.zerobuttonLayoutHeight = 60
        }
    }
}
