//
//  WeightTextFieldView.swift
//  NutrientCalculatorV3
//
//  Created by Kyle Blandford on 6/13/22.
//

import SwiftUI

struct WeightTextFieldView: View {
    
    @Environment(\.colorScheme) var colorScheme
    @EnvironmentObject private var viewModel: GlobalUserViewModel
    @FocusState private var focusedTextField: Bool
    
    var body: some View {
        VStack {
            HStack {
                TextField("Current Weight", text: $viewModel.user.inputWeight)
                    .keyboardType(.decimalPad)
                    .focused($focusedTextField)
                Text(viewModel.user.weightInPounds ? "lbs" : "kgs")
            }
            .font(.body)
            .padding()
            .padding(.horizontal, 20)
            .background(
                Capsule()
                    .fill(colorScheme == .light ? Color.black.opacity(0.1) : Color.white.opacity(0.1))
                    .padding(.horizontal)
            )
        }
        .toolbar {
            ToolbarItemGroup(placement: .keyboard) {
                HStack {
                    KeyboardDismissButton(focusedTextField: $focusedTextField)
                    Spacer()
                }
            }
        }
    }
}

struct WeightTextFieldView_Previews: PreviewProvider {
    static var previews: some View {
        WeightTextFieldView()
            .environmentObject(dev.globalViewModel)
    }
}

