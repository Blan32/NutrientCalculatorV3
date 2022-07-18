//
//  WeightTextFieldViewModifier.swift
//  NutrientCalculatorV3
//
//  Created by Kyle Blandford on 7/18/22.
//

import SwiftUI

struct WeightTextFieldViewModifier: ViewModifier {
    
    @Environment(\.colorScheme) var colorScheme
    
    func body(content: Content) -> some View {
        content
            .font(.body)
            .padding()
            .padding(.horizontal, 20)
            .background(
                Capsule()
                    .fill(colorScheme == .light ? Color.black.opacity(0.1) : Color.white.opacity(0.1))
                    .padding(.horizontal)
            )
    }
}
