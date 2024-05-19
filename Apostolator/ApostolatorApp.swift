//
//  ApostolatorApp.swift
//  Apostolator
//
//  Created by Alex.personal on 18/5/24.
//

import SwiftUI
import Engine

@main
struct ApostolatorApp: App {
    var body: some Scene {
        WindowGroup {
            ContentView(engine: Engine())
        }
    }
}
