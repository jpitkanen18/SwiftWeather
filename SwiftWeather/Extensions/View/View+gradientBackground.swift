//
//  View+gradientBackground.swift
//  SwiftWeather
//
//  Created by Jese on 19.3.2025.
//

import SwiftUI

extension View {
  func gradientBackground(spacer: CGFloat = 0) -> some View {
    modifier(GradientBackground(spacer: spacer))
  }
}

private struct GradientBackground: ViewModifier {
  var spacer: CGFloat

  func body(content: Content) -> some View {
      ZStack {
          BackgroundGradient().ignoresSafeArea()
          content
      }
  }
}

struct BackgroundGradient: View {

    let gradient = Gradient(colors: [Color.gradientOrange, Color.darkBlue])

    var body: some View {
        Rectangle()
        .fill(LinearGradient(
            gradient: gradient,
            startPoint: .init(x: 0.16, y: 0.14),
            endPoint: .init(x: 0.84, y: 0.86)
        ))
        .edgesIgnoringSafeArea(.all)
    }
}

#Preview {
    ZStack {
        BackgroundGradient().ignoresSafeArea()
        Text("Hello, World!")
    }
}
