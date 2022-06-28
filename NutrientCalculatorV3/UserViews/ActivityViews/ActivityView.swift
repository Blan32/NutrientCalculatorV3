//
//  ActivityView.swift
//  NutrientCalculatorV3
//
//  Created by Kyle Blandford on 6/14/22.
//

import SwiftUI

struct ActivityView: View {
    
    @Environment(\.presentationMode) var presentationMode
    @EnvironmentObject private var viewModel: GlobalUserViewModel
    @State var updateActivity: Bool
    
    //MARK: View
    var body: some View {
        VStack {
            stepsPerDay
            workoutsPerWeek
            activityRating
            Spacer()
            
            if updateActivity {
                HStack {
                    backButton
                    submitButton
                }
            }
        }
        .navigationBarBackButtonHidden(updateActivity ? true : false)
        .navigationBarItems(
            leading:
                Image(systemName: "chevron.left")
                    .opacity(updateActivity ? 1.0 : 0.0)
                    .onTapGesture {
                        backButtonPressed()
                    }
        )
    }
}

struct ActivityView_Previews: PreviewProvider {
    static var previews: some View {
        ActivityView(updateActivity: true)
            .environmentObject(dev.globalViewModel)
    }
}

extension ActivityView {
    
    //MARK: Steps Per Day
    private var stepsPerDay: some View {
        VStack {
            Text("How many steps do you take each day?")
            .frame(maxWidth: .infinity, alignment: .leading)
            .padding()
            
            StepPickerView(updateActivity: updateActivity)
        }
    }
    
    //MARK: Workouts Per Week
    private var workoutsPerWeek: some View {
        VStack {
            Text("How many workout sessions do you have each week?")
            .frame(maxWidth: .infinity, alignment: .leading)
            .padding()
            
            WorkoutAmountPickerView(updateActivity: updateActivity)
        }
    }
    
    //MARK: Activity Rating
    private var activityRating: some View {
        VStack {
            Text("Total Activity Rating: ")
                .padding(.horizontal)
                .padding(.top)
            Text(updateActivity ? "\(viewModel.user.updateActivityLevel.rawValue)" : "\(viewModel.user.activityLevel.rawValue)")
                .bold()
                .foregroundColor(updateActivity ? viewModel.user.updateActivityLevel.intensityColor() : viewModel.user.activityLevel.intensityColor())
                .padding(.top, 1)
        }
    }
    
    // MARK: func Back Button Pressed
    private func backButtonPressed() {
        presentationMode.wrappedValue.dismiss()
    }
    
    // MARK: Back Button View
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
    
    // MARK: Submit Button View
    private var submitButton: some View {
        Button {
            viewModel.user.stepsPerDay = viewModel.user.updateStepsPerDay
            viewModel.user.trainingSessionsPerWeek = viewModel.user.updateTrainingSessionsPerWeek
            viewModel.saveProfile()
            presentationMode.wrappedValue.dismiss()
        } label: {
            Text("Update")
                .frame(height: 30)
                .frame(maxWidth: .infinity)
        }
        .modifier(UserInfoSubmitButtonModifier())
    }
}
