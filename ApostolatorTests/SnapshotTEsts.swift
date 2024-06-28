//
//  SnapshotTEsts.swift
//  ApostolatorTests
//
//  Created by Alex.personal on 24/6/24.
//

import XCTest
import SwiftUI
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
    
//    func testLightModeLandscape() {
//        let orientationManger = OrientationManager()
//        orientationManger.orientation = .landscape
//        XCUIDevice.shared.orientation = UIDeviceOrientation.landscapeRight
//        UIDevice.current.setValue(orientationManger.orientation, forKey: "orientation")
//        UINavigationController.attemptRotationToDeviceOrientation()
//        
//        let sut = ContentView(viewModel: ApostolatorViewModel(engine: Engine()), orientationManager: orientationManger)
//        
//        assert(snapshot: sut.snapshot(for: .iPhone(style: .light, isLandscape: true)), named: "Apostolator_light_landscape")
//    }
//    
//    func testDarkModeLandscape() {
//        let orientationManger = OrientationManager()
//        orientationManger.orientation = .landscape
//        XCUIDevice.shared.orientation = UIDeviceOrientation.landscapeRight
//        let sut = ContentView(viewModel: ApostolatorViewModel(engine: Engine()), orientationManager: orientationManger)
//        
//        assert(snapshot: sut.snapshot(for: .iPhone(style: .dark, isLandscape: true)), named: "Apostolator_dark_landscape")
//    }
}
