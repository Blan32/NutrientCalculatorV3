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
                if viewModel.user.weightInPounds {
                    TextField("Current Weight", text: $viewModel.user.weightLbs)
                        .keyboardType(.decimalPad)
                        .focused($focusedTextField)
                    Text("lbs")
                    
                } else {
                    TextField("Current Weight", text: $viewModel.user.weightKgs)
                        .keyboardType(.decimalPad)
                        .focused($focusedTextField)
                    Text("kgs")
                }
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
        ZStack {
            WeightTextFieldView()
        }
        .environmentObject(dev.globalViewModel)
    }
}

