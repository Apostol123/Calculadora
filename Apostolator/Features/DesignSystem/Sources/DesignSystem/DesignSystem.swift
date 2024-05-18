// The Swift Programming Language
// https://docs.swift.org/swift-book
import SwiftUI

struct StandardButton: View {
    let text: String
    let fontSize: CGFloat
    let textColor: Color
    let backgroundColor: Color
    let width: CGFloat = 62
    let height: CGFloat = 62
    let action: () -> Void
    
    var body: some View {
        Button {
            action()
        } label: {
            Text(text)
                .multilineTextAlignment(.center)
                .font(.system(size: fontSize))
        }.buttonStyle(ApostolatorButton(width: width, height: height))
            .foregroundStyle(textColor)
            .background(RoundedRectangle(cornerRadius: 100).fill(backgroundColor))
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
    StandardButton(text: "7", fontSize: 32, textColor: .white, backgroundColor: .orange, action: {
        print("Hell111o")
    })
}
