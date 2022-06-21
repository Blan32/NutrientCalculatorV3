//
//  KeyboardDismissButton.swift
//  NutrientCalculatorV3
//
//  Created by Kyle Blandford on 6/21/22.
//

import SwiftUI

struct KeyboardDismissButton: View {
    
    @FocusState.Binding var focusedTextField: Bool
    
    var body: some View {
        Button {
            focusedTextField = false
        } label: {
            Image(systemName: "keyboard.chevron.compact.down")
        }
    }
}

