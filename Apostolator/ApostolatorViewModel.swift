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

class ApostolatorViewModel: ObservableObject {
    @Published var selectedButtonId: Int? = nil
    @Published var engine: Engine
    lazy var myLazy: Bool = {
        true
    }()
    
    init(engine: Engine) {
        self.engine = engine
    }
    
    lazy var buttons: [[ButtonModel]] = { [
        [ ButtonModel(id: 0, text: "AC", textColor: .black, backgroundColor: .customLightGray, action: {
            [weak self] in
            self?.engine.observeEvent(.action(.reset))
        }),
          ButtonModel(id: 1, text: "+/-", textColor: .black, backgroundColor: .customLightGray, action: {
              [weak self] in
              self?.engine.observeEvent(.action(.toggleValueType))
          }),
          ButtonModel(id: 2, text: "%", textColor: .black, backgroundColor: .customLightGray, action: {
              [weak self] in
              self?.engine.observeEvent(.action(.percentage))
          }),
          ButtonModel(id: 3, text: "➗", textColor: .black, backgroundColor: .orange, staySelected: true, action: {
              [weak self] in
              self?.engine.observeEvent(.action(.split))
          })],
        
        [ ButtonModel(id: 4, text: "7", textColor: .white, backgroundColor: .gray, action: { [weak self] in
            self?.engine.observeEvent(.value(7))
        }),
          ButtonModel(id: 5, text: "8", textColor: .white, backgroundColor: .gray, action: { [weak self] in
              self?.engine.observeEvent(.value(8))
              
          }),
          ButtonModel(id: 6, text: "9", textColor: .white, backgroundColor: .gray, action: {
              [weak self] in
              self?.engine.observeEvent(.value(9))
              
          }),
          ButtonModel(id: 7, text: "X", textColor: .white, backgroundColor: .orange,  staySelected: true, action: {
              [weak self] in
              self?.engine.observeEvent(.action(.multiply))
          })],
        
        [  ButtonModel(id: 8, text: "4", textColor: .white, backgroundColor: .gray, action: {
            [weak self] in
            self?.engine.observeEvent(.value(4))
            
        }),
           ButtonModel(id: 9, text: "5", textColor: .white, backgroundColor: .gray, action: {[weak self] in
               self?.engine.observeEvent(.value(5))
               
           }),
           ButtonModel(id: 10, text: "6", textColor: .white, backgroundColor: .gray, action: { [weak self] in
               self?.engine.observeEvent(.value(6))
               
           }),
           ButtonModel(id: 11, text: "-", textColor: .white, backgroundColor: .orange,  staySelected: true, action: {
               [weak self] in
               self?.engine.observeEvent(.action(.subtract))
           })],
        
        [
            ButtonModel(id: 12, text: "1", textColor: .white, backgroundColor: .gray, action: {
                [weak self] in
                self?.engine.observeEvent(.value(1))
                
            }),
            ButtonModel(id: 13, text: "2", textColor: .white, backgroundColor: .gray, action: {
                [weak self] in
                self?.engine.observeEvent(.value(2))
                
            }),
            ButtonModel(id: 14, text: "3", textColor: .white, backgroundColor: .gray, action: {
                [weak self] in
                self?.engine.observeEvent(.value(3))
                
            }),
            ButtonModel(id: 15, text: "+", textColor: .white, backgroundColor: .orange,  staySelected: true, action: {
                [weak self] in
                self?.engine.observeEvent(.action(.add))
            })
        ],
        [
            ButtonModel(id: 16, text: "0", textColor: .white, backgroundColor: .gray, width: 144, height: 60, action: {
                [weak self] in
                self?.engine.observeEvent(.value(0))
            }),
            ButtonModel(id: 17, text: ".", textColor: .white, backgroundColor: .gray, action: {
                [weak self] in
                self?.engine.observeEvent(.action(.separator))
            }),
            ButtonModel(id: 18, text: "=", textColor: .white, backgroundColor: .gray, action: {
                [weak self] in
                self?.engine.observeEvent(.action(.result))
            })
        ]
        
    ]}()
    
    func selectButton(id: Int) {
        selectedButtonId = id
    }
}
