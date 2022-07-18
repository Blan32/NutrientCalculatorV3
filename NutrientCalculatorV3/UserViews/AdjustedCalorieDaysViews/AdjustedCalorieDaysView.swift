//
//  TrainingDaysView.swift
//  NutrientCalculatorV3
//
//  Created by Kyle Blandford on 6/30/22.
//

import SwiftUI

struct AdjustedCalorieDaysView: View {
    
    @Environment(\.presentationMode) var presentationMode
    @EnvironmentObject private var viewModel: EnvironmentViewModel
    var updateTrainingDays: Bool
    
    var body: some View {
        VStack {
            Text("Select your higher calorie days (such as training/social days).")
                .frame(maxWidth: .infinity, alignment: .leading)
                .padding()
            
            AdjustedCalorieDaysPickerView(
                toggleOnMonday: viewModel.user.monday,
                toggleOnTuesday: viewModel.user.tuesday,
                toggleOnWednesday: viewModel.user.wednesday,
                toggleOnThursday: viewModel.user.thursday,
                toggleOnFriday: viewModel.user.friday,
                toggleOnSaturday: viewModel.user.saturday,
                toggleOnSunday: viewModel.user.sunday
            )
            Spacer()
            
            if updateTrainingDays {
                HStack {
                    backButton
                    submitButton
                }
            }
        }
        .navigationBarBackButtonHidden(updateTrainingDays ? true : false)
        .navigationBarItems(
            leading:
                Image(systemName: "chevron.left")
                    .opacity(updateTrainingDays ? 1.0 : 0.0)
                    .onTapGesture {
                        backButtonPressed()
                    }
        )
    }
}

struct TrainingDaysView_Previews: PreviewProvider {
    static var previews: some View {
        AdjustedCalorieDaysView(updateTrainingDays: true)
            .environmentObject(dev.environmentViewModel)
    }
}

extension AdjustedCalorieDaysView {
    
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
