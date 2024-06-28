//
//  UIViewController+Snapshot.swift
//  EssentialFeediOSTests
//
//  Created by Alex.personal on 21/1/24.
//

import UIKit
import SwiftUI

public extension UIViewController {
    func snapshot(for configuration: SnapshotConfiguration) -> UIImage {
        return SnapshotWindow(configuration: configuration, root: self).snapshot()
    }
}

public extension View {
    func snapshot(for configuration: SnapshotConfiguration) -> UIImage {
        let hostingController = UIHostingController(rootView: self)
        hostingController.view.frame = CGRect(origin: .zero, size: configuration.size)
        return hostingController.snapshot(for: configuration)
    }
}

public struct SnapshotConfiguration {
    let size: CGSize
    let safeAreaInsets: UIEdgeInsets
    let layoutMargins: UIEdgeInsets
    let traitCollection: UITraitCollection
    let isLandscape: Bool
    
    static func iPhone(style: UIUserInterfaceStyle, contentSize: UIContentSizeCategory = .medium, isLandscape: Bool = false) -> SnapshotConfiguration {
        let size = isLandscape ? CGSize(width: 844, height: 390) : CGSize(width: 390, height: 844)
        let safeAreaInsets = isLandscape ? UIEdgeInsets(top: 0, left: 47, bottom: 21, right: 47) : UIEdgeInsets(top: 47, left: 0, bottom: 34, right: 0)
        let layoutMargins = isLandscape ? UIEdgeInsets(top: 8, left: 55, bottom: 8, right: 55) : UIEdgeInsets(top: 55, left: 8, bottom: 42, right: 8)
        
        return SnapshotConfiguration(
            size: size,
            safeAreaInsets: safeAreaInsets,
            layoutMargins: layoutMargins,
            traitCollection: UITraitCollection(traitsFrom: [
                .init(forceTouchCapability: .unavailable),
                .init(layoutDirection: .leftToRight),
                .init(preferredContentSizeCategory: contentSize),
                .init(userInterfaceIdiom: .phone),
                .init(horizontalSizeClass: isLandscape ? .regular : .compact),
                .init(verticalSizeClass: isLandscape ? .compact : .regular),
                .init(displayScale: 3),
                .init(accessibilityContrast: .normal),
                .init(displayGamut: .P3),
                .init(userInterfaceStyle: style)
            ]),
            isLandscape: isLandscape
        )
    }
}

private final class SnapshotWindow: UIWindow {
    private var configuration: SnapshotConfiguration = .iPhone(style: .light)
    
    convenience init(configuration: SnapshotConfiguration, root: UIViewController) {
        self.init(frame: CGRect(origin: .zero, size: configuration.size))
        self.configuration = configuration
        self.layoutMargins = configuration.layoutMargins
        self.rootViewController = root
        self.isHidden = false
        root.view.layoutMargins = configuration.layoutMargins
    }
    
    override var safeAreaInsets: UIEdgeInsets {
        return configuration.safeAreaInsets
    }
    
    override var traitCollection: UITraitCollection {
        return UITraitCollection(traitsFrom: [super.traitCollection, configuration.traitCollection])
    }
    
    func snapshot() -> UIImage {
        let renderer = UIGraphicsImageRenderer(bounds: bounds, format: .init(for: traitCollection))
        return renderer.image { action in
            layer.render(in: action.cgContext)
        }
    }
}
