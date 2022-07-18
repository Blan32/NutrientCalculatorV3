//
//  CaloriePreferenceView.swift
//  NutrientCalculatorV3
//
//  Created by Kyle Blandford on 6/30/22.
//

import SwiftUI

struct CaloriePreferenceView: View {
    
    @Environment(\.presentationMode) var presentationMode
    @EnvironmentObject private var viewModel: EnvironmentViewModel
    var updateCaloriePreference: Bool
    
    var body: some View {
        VStack {
            Text("How would you prefer we set your calories?")
                .padding()
            
            CaloriePreferencePickerView()
            Spacer()
            
            if updateCaloriePreference {
                HStack {
                    backButton
                    submitButton
                }
            }
        }
        .navigationBarBackButtonHidden(updateCaloriePreference ? true : false)
        .navigationBarItems(
            leading:
                Image(systemName: "chevron.left")
                    .opacity(updateCaloriePreference ? 1.0 : 0.0)
                    .onTapGesture {
                        backButtonPressed()
                    }
        )
    }
}

struct CaloriePreferenceView_Previews: PreviewProvider {
    static var previews: some View {
        CaloriePreferenceView(updateCaloriePreference: true)
            .environmentObject(dev.environmentViewModel)
    }
}


extension CaloriePreferenceView {
    
    
    // MARK: Back Button
    private var backButton: some View {
        Button {
            backButtonPressed()
        } label: {
            Text("Go Back")
                .frame(height: 30)
                .frame(maxWidth: .infinity)
        }
        .modifier(UserInfoBackButtonModifier())
    }
    
    // MARK: Submit Button
    private var submitButton: some View {
        Button {
            submitButtonPressed()
        } label: {
            Text("Update")
                .frame(height: 30)
                .frame(maxWidth: .infinity)
        }
        .modifier(UserInfoSubmitButtonModifier())
    }
    
    // MARK: func BackButtonPressed
    private func backButtonPressed() {
        presentationMode.wrappedValue.dismiss()
    }
    
    // MARK: func SubmitButtonPressed
    private func submitButtonPressed() {
        viewModel.saveProfile()
        presentationMode.wrappedValue.dismiss()
    }
}
