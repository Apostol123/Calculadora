// The Swift Programming Language
// https://docs.swift.org/swift-book
import SwiftUI

public struct StandardButton: View {
   
    let text: String
    let fontSize: CGFloat
    let textColor: Color
    let backgroundColor: Color
    let width: CGFloat
    let height: CGFloat
    let radius: CGFloat
    let action: () -> Void
    
    public init(text: String, fontSize: CGFloat, textColor: Color, backgroundColor: Color, width: CGFloat = 62, height: CGFloat = 62, radius: CGFloat = 100, action: @escaping () -> Void) {
        self.text = text
        self.fontSize = fontSize
        self.textColor = textColor
        self.backgroundColor = backgroundColor
        self.action = action
        self.width = width
        self.radius = radius
        self.height = height
    }
    
    
    public var body: some View {
        Button {
            action()
        } label: {
            Text(text)
                .multilineTextAlignment(.center)
                .font(.system(size: fontSize))
        }.buttonStyle(ApostolatorButton(width: width, height: height))
            .foregroundStyle(textColor)
            .background(RoundedRectangle(cornerRadius: radius).fill(backgroundColor))
    }
}

struct ApostolatorButton: ButtonStyle {
    let width: CGFloat
    let height: CGFloat
    func makeBody(configuration: Configuration) -> some View {
        MainButton(width: width, height: height, configuration: configuration)
    }
}

fileprivate struct MainButton: View {
    @Environment(\.isEnabled) private var isEnabled: Bool
    let width: CGFloat
    let height: CGFloat
    
    let configuration: ButtonStyleConfiguration
    
    var body: some View {
        configuration.label
            .font(.body)
            .frame(width: width)
            .frame(height: height)
            .clipShape(Circle())
    }
}


#Preview {
    StandardButton(text: "7", fontSize: 32, textColor: .white, backgroundColor: .orange,width: 144, height: 60, radius: 27 ,action: {
        print("Hell111o")
    })
}
