//
//  AccountInfoViewModifier.swift
//  NutrientCalculatorV3
//
//  Created by Kyle Blandford on 6/24/22.
//

import SwiftUI

struct AccountInfoViewModifier: ViewModifier {
    
    @Environment(\.colorScheme) var colorScheme
    
    func body(content: Content) -> some View {
        content
            .frame(width: UIScreen.main.bounds.width + 20)
            .frame(height: 60)
            .background(
                Capsule()
                    .fill(colorScheme == .light ? Color.black.opacity(0.1) : Color.white.opacity(0.1))
                    .offset(x: 20)
            )
    }
}
