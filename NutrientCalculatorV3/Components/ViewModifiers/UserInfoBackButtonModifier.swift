//
//  UserInfoBackButtonModifier.swift
//  NutrientCalculatorV3
//
//  Created by Kyle Blandford on 6/28/22.
//

import SwiftUI

struct UserInfoBackButtonModifier: ViewModifier {
        
    func body(content: Content) -> some View {
        content
            .buttonStyle(.bordered)
            .buttonBorderShape(.capsule)
            .tint(.red)
            .background(Capsule().fill(Color.inverseAccentColor))
            .padding()
    }
}
