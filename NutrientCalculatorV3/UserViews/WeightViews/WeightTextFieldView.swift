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
    var body: some View {
        VStack {
            HStack {
                if viewModel.user.weightInPounds {
                    TextField("Current Weight", text: $viewModel.user.weightLbs)
                    Text("lbs")
                        
                } else {
                    TextField("Current Weight", text: $viewModel.user.weightKgs)
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
