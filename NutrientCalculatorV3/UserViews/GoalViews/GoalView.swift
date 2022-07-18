//
//  GoalView.swift
//  NutrientCalculatorV3
//
//  Created by Kyle Blandford on 6/16/22.
//

import SwiftUI

struct GoalView: View {
    
    @Environment(\.presentationMode) var presentationMode
    @EnvironmentObject private var viewModel: EnvironmentViewModel
    @State var updateGoalWeight: Bool
    
    var body: some View {
            VStack {
                Text("Select your goal.")
                    .frame(maxWidth: .infinity, alignment: .leading)
                    .padding()
                    .padding(.bottom, 10)
                
                GoalPickerView(updateGoalWeight: updateGoalWeight)
                Spacer()
                
                if updateGoalWeight {
                    HStack {
                        backButton
                        submitButton
                    }
                }
            }
            .navigationBarBackButtonHidden(updateGoalWeight ? true : false)
            .navigationBarItems(
                leading:
                    Image(systemName: "chevron.left")
                        .opacity(updateGoalWeight ? 1.0 : 0.0)
                        .onTapGesture {
                            backButtonPressed()
                        }
            )
    }
}

struct GoalView_Previews: PreviewProvider {
    static var previews: some View {
        GoalView(updateGoalWeight: true)
            .environmentObject(dev.environmentViewModel)
    }
}

extension GoalView {
    
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
        guard viewModel.isValidUpdateGoalWeight() else { return }
        if viewModel.user.weightInPounds {
            viewModel.setInputGoalWeightKgs()
        } else {
            viewModel.setInputGoalWeightLbs()
        }
        viewModel.saveProfile()
        presentationMode.wrappedValue.dismiss()
    }
}
