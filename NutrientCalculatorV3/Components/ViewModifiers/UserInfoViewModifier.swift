//
//  UserInfoViewModifier.swift
//  NutrientCalculatorV3
//
//  Created by Kyle Blandford on 6/23/22.
//

import SwiftUI

struct UserInfoViewModifier: ViewModifier {
    
    @Environment(\.colorScheme) var colorScheme
    
    func body(content: Content) -> some View {
        content
            .font(.body)
            .padding(.leading, 40)
            .frame(width: UIScreen.main.bounds.width + 20, alignment: .leading)
            .frame(height: 60)
            .background(
                Capsule()
                    .fill(colorScheme == .light ? Color.black.opacity(0.1) : Color.white.opacity(0.1))
                    .offset(x: -20)
            )
    }
}

