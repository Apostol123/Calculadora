//
//  File.swift
//  
//
//  Created by Alex.personal on 3/7/24.
//

import Foundation
import UIKit
import SwiftUI

struct AttributedLabel: UIViewRepresentable {
    var attributedText: NSAttributedString
    
    func makeUIView(context: Context) -> UILabel {
        let label = UILabel()
        label.numberOfLines = 0
        label.textAlignment = .center
        return label
    }
    
    func updateUIView(_ uiView: UILabel, context: Context) {
        uiView.attributedText = attributedText
    }
    
    static func createSuperScriptText(baseText: String, superScriptText: String) -> NSAttributedString {
        let baseFont = UIFont.systemFont(ofSize: 20)
        let superScriptFont = UIFont.systemFont(ofSize: 10)
        let superScriptBaselineOffset: CGFloat = 8
        
        let baseAttributes: [NSAttributedString.Key: Any] = [.font: baseFont]
        let superScriptAttributes: [NSAttributedString.Key: Any] = [
            .font: superScriptFont,
            .baselineOffset: superScriptBaselineOffset
            
        ]
        
        let baseAttributedString = NSMutableAttributedString(string: baseText, attributes: baseAttributes)
        let superScriptAttributedString = NSAttributedString(string: superScriptText, attributes: superScriptAttributes)
        
        baseAttributedString.append(superScriptAttributedString)
        return baseAttributedString
    }
    
    static func createSubScriptText(baseText: String, subScriptText: String) -> NSAttributedString {
        let baseFont = UIFont.systemFont(ofSize: 20)
        let subScriptFont = UIFont.systemFont(ofSize: 10)
        let subScriptBaselineOffset: CGFloat = -6
        
        let baseAttributes: [NSAttributedString.Key: Any] = [.font: baseFont]
        let subScriptAttributes: [NSAttributedString.Key: Any] = [
            .font: subScriptFont,
            .baselineOffset: subScriptBaselineOffset
        ]
        
        let baseAttributedString = NSMutableAttributedString(string: baseText, attributes: baseAttributes)
        let subScriptAttributedString = NSAttributedString(string: subScriptText, attributes: subScriptAttributes)
        
        baseAttributedString.append(subScriptAttributedString)
        return baseAttributedString
    }
    
    static func createCubeRoot(superScript: String, subscript: String) -> NSAttributedString {
        let baseFont = UIFont.systemFont(ofSize: 20)
        let subScriptFont = UIFont.systemFont(ofSize: 10)
        let subScriptBaselineOffset: CGFloat = 6
        let kernSpacing: CGFloat = -8
        
        let baseAttributes: [NSAttributedString.Key: Any] = [.font: baseFont]
        let subscriptAttributes: [NSAttributedString.Key: Any] = [.font: subScriptFont]
        let superScriptAttributes: [NSAttributedString.Key: Any] = [
            .font: subScriptFont,
            .baselineOffset: subScriptBaselineOffset,
            .kern: kernSpacing
        ]
        
        
        let baseAttributedString = NSMutableAttributedString(string: "√", attributes: baseAttributes)
        let superScriptAttributesString = NSAttributedString(string: superScript, attributes: superScriptAttributes)
        let subScriptAttributedString = NSAttributedString(string: superScript, attributes: subscriptAttributes)
        
        baseAttributedString.insert(superScriptAttributesString, at: 0)
        baseAttributedString.append(subScriptAttributedString)
        return baseAttributedString
    }
}

