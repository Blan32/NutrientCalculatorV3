//
//  OnboardingSummaryView.swift
//  NutrientCalculatorV3
//
//  Created by Kyle Blandford on 6/21/22.
//

import SwiftUI

struct OnboardingUserInfoSummaryView: View {
    
   

    @EnvironmentObject private var viewModel: GlobalUserViewModel
    
    var body: some View {
        ScrollView {
            HeightSummaryView()
            WeightSummaryView()
            AgeSummaryView()
            SexSummaryView()
            userActivity
            userGoal
            userInputMacrosAndCalories
            CaloriePreferenceSummaryView()
            AdjustedCalorieDaysSummaryView()
            Rectangle()
                .opacity(0.0)
                .frame(height: 80)
        }
    }
}

struct OnboardingSummaryView_Previews: PreviewProvider {
    static var previews: some View {
        OnboardingUserInfoSummaryView()
            .preferredColorScheme(.dark)
            .environmentObject(dev.globalViewModel)
    }
}


extension OnboardingUserInfoSummaryView {
    
    // MARK: User Activity Level
    private var userActivity: some View {
        VStack {
            StepSummaryView()
            WorkoutSummaryView()
            ActivitySummaryView()
        }
    }
    
    // MARK: User Goal / Goal Weight
    private var userGoal: some View {
        VStack {
            GoalSummaryView()
            if viewModel.user.goalType == .fatloss || viewModel.user.goalType == .muscleGrowth {
                GoalWeightSummaryView()
            }
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
