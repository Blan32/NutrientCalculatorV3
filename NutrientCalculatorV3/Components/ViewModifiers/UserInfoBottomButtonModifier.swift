//
//  BottomButtonModifier.swift
//  NutrientCalculatorV3
//
//  Created by Kyle Blandford on 6/13/22.
//

import SwiftUI

struct UserInfoBottomButtonModifier: ViewModifier {
        
    func body(content: Content) -> some View {
        content
            .buttonStyle(.bordered)
            .buttonBorderShape(.capsule)
            .tint(.buttonColor)
            .background(Capsule().fill(Color.inverseAccentColor))
            .padding()
    }
}

