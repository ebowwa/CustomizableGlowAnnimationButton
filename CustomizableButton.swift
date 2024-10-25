// CustomizableButton.swift
import SwiftUI

struct CustomizableButton: View {
    let icon: String   // Can be an SF Symbol or an emoji
    let gradientStart: Color
    let gradientEnd: Color
    let borderColor: Color
    let iconColor: Color
    let buttonSize: CGFloat
    let iconSize: CGFloat
    let isSFSymbol: Bool  // New flag to indicate if it's an SF Symbol
    
    @State private var isAnimating = false
    @State private var shadowRadius: CGFloat = 5.0
    @State private var glow: CGFloat = 0.0
    
    var body: some View {
        ZStack {
            // Circular button with gradient background
            Circle()
                .fill(
                    RadialGradient(gradient: Gradient(colors: [gradientStart, gradientEnd]),
                                   center: .center, startRadius: 5, endRadius: buttonSize / 2)
                )
                .frame(width: buttonSize, height: buttonSize)
                .shadow(color: borderColor.opacity(0.5), radius: shadowRadius, x: 0, y: 0) // Adding shadow
                .overlay(
                    Group {
                        if isSFSymbol {
                            Image(systemName: icon) // For SF Symbol
                                .resizable()
                                .aspectRatio(contentMode: .fit)
                        } else {
                            Text(icon) // For emojis
                                .font(.system(size: iconSize))
                        }
                    }
                        .foregroundColor(iconColor)
                        .frame(width: iconSize, height: iconSize)
                        .scaleEffect(isAnimating ? 1.2 : 1.0) // Pulsating effect on press
                        .shadow(color: iconColor.opacity(glow), radius: glow, x: 0, y: 0) // Glow effect
                )
        }
        .onTapGesture {
            performButtonAction()
        }
        .animation(.easeInOut(duration: 0.8), value: isAnimating)
    }
    
    private func performButtonAction() {
        withAnimation {
            isAnimating.toggle()
            shadowRadius = isAnimating ? 15.0 : 5.0
            glow = isAnimating ? 10.0 : 0.0
        }
    }
}
/**
struct CustomizableButton_Previews: PreviewProvider {
    static var previews: some View {
        VStack {
            CustomizableButton(
                icon: "antenna.radiowaves.left.and.right",  // SF Symbol
                gradientStart: .blue,
                gradientEnd: .purple,
                borderColor: .blue,
                iconColor: .white,
                buttonSize: 120,
                iconSize: 50,
                isSFSymbol: true
            )
            CustomizableButton(
                icon: "📶",  // Emoji icon
                gradientStart: .green,
                gradientEnd: .yellow,
                borderColor: .green,
                iconColor: .white,
                buttonSize: 120,
                iconSize: 50,
                isSFSymbol: false
            )
        }
        .padding()
    }
}
*/
