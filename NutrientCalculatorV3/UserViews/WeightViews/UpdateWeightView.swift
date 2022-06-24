//
//  WeightSummaryOnboardingView.swift
//  NutrientCalculatorV3
//
//  Created by Kyle Blandford on 6/24/22.
//

import SwiftUI

struct UpdateWeightView: View {
    
    @Environment(\.presentationMode) var presentationMode
    @EnvironmentObject private var viewModel: GlobalUserViewModel
    
    var body: some View {
        VStack {
            Text("Input your current weight.")
                .frame(maxWidth: .infinity, alignment: .leading)
                .padding()
                .padding(.bottom, 10)
            
            WeightMeasurementTypeView()
            UpdateWeightTextFieldView()
            
            Spacer()
            
            HStack {
                backButton
                submitButton
            }
        }
        .navigationBarBackButtonHidden(true)
    }
}

struct WeightSummaryOnboardingView_Previews: PreviewProvider {
    static var previews: some View {
        UpdateWeightView()
            .environmentObject(dev.globalViewModel)
    }
}

extension UpdateWeightView {
    
    private var backButton: some View {
        Button {
            if viewModel.user.weightInPounds {
                viewModel.user.weightInPounds = true
            }
            viewModel.user.updateInputWeight = ""
            presentationMode.wrappedValue.dismiss()
        } label: {
            Text("Go Back")
                .frame(height: 30)
                .frame(maxWidth: .infinity)
        }
        .buttonStyle(.bordered)
        .buttonBorderShape(.capsule)
        .tint(.red)
        .background(Capsule().fill(Color.inverseAccentColor))
        .padding()
    }
    
    private var submitButton: some View {
        Button {
            if viewModel.isValidUpdateWeight() {
                viewModel.user.inputWeight = viewModel.user.updateInputWeight
                presentationMode.wrappedValue.dismiss()
            }
        } label: {
            Text("Update")
                .frame(height: 30)
                .frame(maxWidth: .infinity)
        }
        .modifier(UserInfoBottomButtonModifier())
    }
}
