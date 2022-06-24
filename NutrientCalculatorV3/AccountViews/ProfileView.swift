//
//  ProfileView.swift
//  NutrientCalculatorV3
//
//  Created by Kyle Blandford on 6/24/22.
//

import SwiftUI

struct ProfileView: View {
    
    @EnvironmentObject private var viewModel: GlobalUserViewModel
    
    var body: some View {
        ScrollView {
            userHeight
            userAge
            userSex
            userSteps
            userWorkouts
            userActivity
            if viewModel.user.inputCalories != "" {
                userInputMacrosAndCalories
            }
            Rectangle()
                .opacity(0.0)
                .frame(height: 80)
        }
    }
}

struct ProfileView_Previews: PreviewProvider {
    static var previews: some View {
        ProfileView()
            .preferredColorScheme(.dark)
            .environmentObject(dev.globalViewModel)
    }
}


extension ProfileView {
    
    // MARK: User Height
    private var userHeight: some View {
        NavigationLink {
            HeightView()
                .navigationTitle("Height")
        } label: {
            HeightSummaryView()
        }
    }
    
    // MARK: User Age
    private var userAge: some View {
        NavigationLink {
            AgeView()
                .navigationTitle("Birthday")
        } label: {
            AgeSummaryView()
        }
    }
    
    // MARK: User Sex
    private var userSex: some View {
        NavigationLink {
            SexView()
                .navigationTitle("Sex")
        } label: {
            SexSummaryView()
        }
    }
    
    // MARK: User Steps
    private var userSteps: some View {
        NavigationLink {
            ActivityView()
                .navigationTitle("Activity")
        } label: {
            StepSummaryView()
        }
    }
    
    // MARK: User Workouts
    private var userWorkouts: some View {
        NavigationLink {
            ActivityView()
                .navigationTitle("Activity")
        } label: {
            WorkoutSummaryView()
        }
    }
    
    // MARK: User Activity Level
    private var userActivity: some View {
        NavigationLink {
            ActivityView()
                .navigationTitle("Activity")
        } label: {
            ActivitySummaryView()
        }
    }
    
    // MARK: User Input Macros / Calories
    private var userInputMacrosAndCalories: some View {
        VStack {
            InputCurrentMacrosSummaryView()
            MonthWeightChangeSummaryView()
        }
    }
}
