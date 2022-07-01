//
//  TrainingDayViewModifier.swift
//  NutrientCalculatorV3
//
//  Created by Kyle Blandford on 6/30/22.
//

import SwiftUI

struct TrainingDayViewModifier: ViewModifier {
    
    @Environment(\.colorScheme) var colorScheme
    @Binding var toggleOn: Bool
    
    func body(content: Content) -> some View {
        content
            .foregroundColor(toggleOn ? Color.inverseAccentColor : Color.accentColor)
            .font(.body)
            .padding(.leading, 40)
            .frame(width: UIScreen.main.bounds.width + 20, alignment: .leading)
            .frame(height: 60)
            .background(
                Capsule()
                    .fill(
                        toggleOn ?
                        colorScheme == .light ? Color.black.opacity(0.9) : Color.white.opacity(0.9)
                            :
                            colorScheme == .light ? Color.black.opacity(0.1) : Color.white.opacity(0.1)
                        )
                    .offset(x: -20)
            )
    }
}
