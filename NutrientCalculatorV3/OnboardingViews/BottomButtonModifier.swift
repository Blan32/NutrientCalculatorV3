//
//  BottomButtonModifier.swift
//  NutrientCalculatorV3
//
//  Created by Kyle Blandford on 6/13/22.
//

import SwiftUI

struct BottomButtonModifier: ViewModifier {
        
    func body(content: Content) -> some View {
        content
            .buttonStyle(.bordered)
            .buttonBorderShape(.capsule)
            .tint(.buttonColor)
            .padding()
    }
}

