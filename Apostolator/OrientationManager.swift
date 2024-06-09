//
//  OrientationManager.swift
//  Apostolator
//
//  Created by Alex.personal on 9/6/24.
//

import SwiftUI
import Combine

class OrientationManager: ObservableObject {
    enum Orientation {
        case portrait
        case landscape
    }

    @Published var orientation: Orientation = .portrait

    private var cancellables = Set<AnyCancellable>()

    init() {
        UIDevice.current.beginGeneratingDeviceOrientationNotifications()
        NotificationCenter.default.publisher(for: UIDevice.orientationDidChangeNotification)
            .map { _ in UIDevice.current.orientation }
            .sink { [weak self] newOrientation in
                self?.updateOrientation(newOrientation)
            }
            .store(in: &cancellables)
    }

    private func updateOrientation(_ deviceOrientation: UIDeviceOrientation) {
        switch deviceOrientation {
        case .portrait, .portraitUpsideDown:
            orientation = .portrait
        case .landscapeLeft, .landscapeRight, .faceUp, .faceDown:
            orientation = .landscape
        default:
            break
        }
    }
}

