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
    let staySelected: Bool
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
        self.staySelected = model.staySelected
    }
    
    
    public var body: some View {
        Button {
            action()
        } label: {
            Text(text)
                .multilineTextAlignment(.center)
                .font(.system(size: fontSize))
        }.buttonStyle(ApostolatorButton(width: width, height: height, backgroundColor: backgroundColor, textColor: textColor, isSelected: isSelected, radius: radius, staySelected: staySelected))
    }
}

struct ApostolatorButton: ButtonStyle {
    let width: CGFloat
    let height: CGFloat
    let backgroundColor: Color
    let textColor: Color
    let isSelected: Bool
    let radius: CGFloat
    let staySelected: Bool
    func makeBody(configuration: Configuration) -> some View {
        MainButton(width: width, height: height, backgroundColor: backgroundColor, textColor: textColor, isSelected: isSelected, radius: radius, staySelected: staySelected, configuration: configuration)
    }
}

fileprivate struct MainButton: View {
    @Environment(\.isEnabled) private var isEnabled: Bool
    let width: CGFloat
    let height: CGFloat
    let backgroundColor: Color
    let textColor: Color
    let isSelected: Bool
    let radius: CGFloat
    let staySelected: Bool
    
    let configuration: ButtonStyleConfiguration
    
    var isActive: Bool {
        staySelected ? isSelected : configuration.isPressed
    }
        let activeColor = Color(red: 210, green: 210, blue: 100, opacity: 0.1)
        
        
    var body: some View {
         configuration.label
            .font(.body)
            .frame(width: width)
            .frame(height: height)
            .foregroundStyle(isActive ? backgroundColor : textColor)
            .background(RoundedRectangle(cornerRadius: radius).fill(isActive ? activeColor : backgroundColor))
    
    }
}


//#Preview {
//    StandardButton(text: "7", fontSize: 32, textColor: .white, backgroundColor: .orange,width: 144, height: 60, radius: 27 ,action: {
//        print("Hell111o")
//    })
//}


public struct ButtonModel: Identifiable {
    public let id: Int
    public let text: String
    let fontSize: CGFloat
    let textColor: Color
    let backgroundColor: Color
    let width: CGFloat
    let height: CGFloat
    let radius: CGFloat
    let staySelected: Bool
    public let action: () -> Void
    
    public init(id: Int, text: String, fontSize: CGFloat = 28, textColor: Color, backgroundColor: Color, width: CGFloat = 62, height: CGFloat = 62, radius: CGFloat = 100, staySelected: Bool = false, action: @escaping () -> Void) {
        self.text = text
        self.fontSize = fontSize
        self.textColor = textColor
        self.backgroundColor = backgroundColor
        self.action = action
        self.width = width
        self.radius = radius
        self.height = height
        self.id = id
        self.staySelected = staySelected
    }
}
