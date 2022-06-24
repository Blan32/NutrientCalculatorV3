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
            userHeight
            userWeight
            userAge
            userSex
            userSteps
            userWorkouts
            userActivity
            userGoal
            userInputMacrosAndCalories
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
    
    // MARK: User Height
    private var userHeight: some View {
        NavigationLink {
            HeightView()
                .navigationTitle("Height")
        } label: {
            HeightSummaryView()
        }
    }
    
    // MARK: User Weight
    private var userWeight: some View {
        NavigationLink {
            UpdateWeightView()
                .navigationTitle("Weight")
        } label: {
            WeightSummaryView()
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
    
    // MARK: User Goal / Goal Weight
    private var userGoal: some View {
        VStack {
            NavigationLink {
                GoalView()
                    .navigationTitle("Goal")
            } label: {
                GoalSummaryView()
            }
            
            if viewModel.user.goalType == .fatloss || viewModel.user.goalType == .muscleGrowth {
                NavigationLink {
                    GoalView()
                        .navigationTitle("Goal")
                } label: {
                    GoalWeightSummaryView()
                }
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
