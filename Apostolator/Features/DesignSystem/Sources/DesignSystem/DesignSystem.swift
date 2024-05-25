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
    let isSelected: Bool
    let action: () -> Void
    
    public init(model: ButtonModel, isSelected: Bool, action: @escaping () -> Void) {
        self.text = model.text
        self.fontSize =  model.fontSize
        self.textColor =  model.textColor
        self.backgroundColor =  model.backgroundColor
        self.width =  model.width
        self.radius =  model.radius
        self.height =  model.height
        self.isSelected = isSelected
        self.action = action
    }
    
    
    public var body: some View {
        Button {
            action()
        } label: {
            Text(text)
                .multilineTextAlignment(.center)
                .font(.system(size: fontSize))
        }.buttonStyle(ApostolatorButton(width: width, height: height, backgroundColor: backgroundColor, textColor: textColor))
            .background(RoundedRectangle(cornerRadius: radius).fill(isSelected ? .white : backgroundColor))
    }
}

public struct SpecialActionButton: View {
   
    let text: String
    let fontSize: CGFloat
    let textColor: Color
    let backgroundColor: Color
    let width: CGFloat
    let height: CGFloat
    let radius: CGFloat
    let isSelected: Bool
    let action: () -> Void
    
    public init(model: ButtonModel, isSelected: Bool, action: @escaping () -> Void) {
        self.text = model.text
        self.fontSize =  model.fontSize
        self.textColor =  model.textColor
        self.backgroundColor =  model.backgroundColor
        self.width =  model.width
        self.radius =  model.radius
        self.height =  model.height
        self.isSelected = isSelected
        self.action = action
    }
    
    
    public var body: some View {
        Button {
            action()
        } label: {
            Text(text)
                .multilineTextAlignment(.center)
                .font(.system(size: fontSize))
        }.buttonStyle(ApostolatorSpecialButton(width: width, height: height, backgroundColor: backgroundColor, textColor: textColor))
            .background(RoundedRectangle(cornerRadius: radius).fill(isSelected ? .white : backgroundColor))
    }
}


struct ApostolatorButton: ButtonStyle {
    let width: CGFloat
    let height: CGFloat
    let backgroundColor: Color
    let textColor: Color
    func makeBody(configuration: Configuration) -> some View {
        MainButton(width: width, height: height, backgroundColor: backgroundColor, textColor: textColor, configuration: configuration)
    }
}

fileprivate struct MainButton: View {
    @Environment(\.isEnabled) private var isEnabled: Bool
    let width: CGFloat
    let height: CGFloat
    let backgroundColor: Color
    let textColor: Color
    
    let configuration: ButtonStyleConfiguration
    
    var body: some View {
        configuration.label
            .font(.body)
            .frame(width: width)
            .frame(height: height)
            .foregroundStyle(configuration.isPressed  ? backgroundColor : textColor)
            .background(configuration.isPressed == true ? Color.init(red: 210, green: 210, blue: 100, opacity: 0.1) : backgroundColor)
            .clipShape(Circle())
    }
}

struct ApostolatorSpecialButton: ButtonStyle {
    let width: CGFloat
    let height: CGFloat
    let backgroundColor: Color
    let textColor: Color
    func makeBody(configuration: Configuration) -> some View {
        MainButton(width: width, height: height, backgroundColor: backgroundColor, textColor: textColor, configuration: configuration)
    }
}

fileprivate struct SecondaryButton: View {
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


//#Preview {
//    StandardButton(text: "7", fontSize: 32, textColor: .white, backgroundColor: .orange,width: 144, height: 60, radius: 27 ,action: {
//        print("Hell111o")
//    })
//}


public struct ButtonModel: Identifiable {
    public let id: Int
    let text: String
    let fontSize: CGFloat
    let textColor: Color
    let backgroundColor: Color
    let width: CGFloat
    let height: CGFloat
    let radius: CGFloat
    public let action: () -> Void
    
    public init(id: Int, text: String, fontSize: CGFloat = 28, textColor: Color, backgroundColor: Color, width: CGFloat = 62, height: CGFloat = 62, radius: CGFloat = 100, action: @escaping () -> Void) {
        self.text = text
        self.fontSize = fontSize
        self.textColor = textColor
        self.backgroundColor = backgroundColor
        self.action = action
        self.width = width
        self.radius = radius
        self.height = height
        self.id = id
    }
}
