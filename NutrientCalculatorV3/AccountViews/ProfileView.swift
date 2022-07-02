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
            userGoal
            userCaloriePreference
            userTrainingDays
                .padding(.bottom)
            
            Button {
                viewModel.signOut()
            } label: {
                Text("Sign Out")
                    .frame(height: 30)
                    .frame(maxWidth: .infinity)
            }
            .modifier(UserInfoBackButtonModifier())
            
                
        }
        .padding(.top, 8)
        .onAppear {
            viewModel.retrieveUser()
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
            HeightView(updateHeight: true)
                .navigationTitle("Height")
        } label: {
            HeightSummaryView()
        }
    }
    
    // MARK: User Age
    private var userAge: some View {
        NavigationLink {
            AgeView(updateAge: true)
                .navigationTitle("Birthday")
        } label: {
            AgeSummaryView()
        }
    }
    
    // MARK: User Sex
    private var userSex: some View {
        NavigationLink {
            SexView(updateSex: true)
                .navigationTitle("Sex")
        } label: {
            SexSummaryView()
        }
    }
    
    // MARK: User Steps
    private var userSteps: some View {
        NavigationLink {
            ActivityView(updateActivity: true)
                .navigationTitle("Activity")
        } label: {
            StepSummaryView()
        }
    }
    
    // MARK: User Workouts
    private var userWorkouts: some View {
        NavigationLink {
            ActivityView(updateActivity: true)
                .navigationTitle("Activity")
        } label: {
            WorkoutSummaryView()
        }
    }
    
    // MARK: User Activity Level
    private var userActivity: some View {
        NavigationLink {
            ActivityView(updateActivity: true)
                .navigationTitle("Activity")
        } label: {
            ActivitySummaryView()
        }
    }
    
    // MARK: User Goal / Goal Weight
    private var userGoal: some View {
        VStack {
            NavigationLink {
                GoalView(updateGoalWeight: true)
                    .navigationTitle("Goal")
            } label: {
                GoalSummaryView()
            }
            
            if viewModel.user.goalType == .fatloss || viewModel.user.goalType == .muscleGrowth {
                NavigationLink {
                    GoalView(updateGoalWeight: true)
                        .navigationTitle("Goal")
                } label: {
                    GoalWeightSummaryView()
                }
            }
        }
    }
    
    // MARK: User Calorie Preference
    private var userCaloriePreference: some View {
        NavigationLink {
            CaloriePreferenceView(updateCaloriePreference: true)
                .navigationTitle("Calorie Preference")
        } label: {
            CaloriePreferenceSummaryView()
        }
    }

    // MARK: User Training Days
    private var userTrainingDays: some View {
        NavigationLink {
            TrainingDaysView(updateTrainingDays: true)
                .navigationTitle("Calorie Preference")
        } label: {
            TrainingDaysSummaryView()
        }
    }
}
