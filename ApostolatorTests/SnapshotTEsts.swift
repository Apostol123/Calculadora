//
//  SnapshotTEsts.swift
//  ApostolatorTests
//
//  Created by Alex.personal on 24/6/24.
//

import XCTest
import Engine
@testable import Apostolator

final class SnapshotTEsts: XCTestCase {
    
    func testLightMode() {
        let sut = ContentView(viewModel: ApostolatorViewModel(engine: Engine()))
        
        assert(snapshot: sut.snapshot(for: .iPhone(style: .light)), named: "Apostolator_light")
    }
    
    func testDarkMode() {
        let sut = ContentView(viewModel: ApostolatorViewModel(engine: Engine()))
        
        assert(snapshot: sut.snapshot(for: .iPhone(style: .dark)), named: "Apostolator_dark")
    }

}
