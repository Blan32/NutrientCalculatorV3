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
            userWeightMeasurementType
            userHeight
            userAge
            userSex
            userActivity
            userGoal
            userCaloriePreference
                .padding(.bottom, viewModel.user.dynamicCalories ? 0 : 10)
            if viewModel.user.dynamicCalories {
                userHighCalDays
                    .padding(.bottom)
            }
            
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
    
    
    // MARK: Weight Measurement Type
    private var userWeightMeasurementType: some View {
        NavigationLink {
            WeightView(updateWeight: true)
            .navigationTitle("Weight Type")
        } label: {
            WeightMeasurementTypeSummaryView()
        }
    }

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
    
    // MARK: Activity
    private var userActivity: some View {
        
        VStack {
            // MARK: User Steps
            NavigationLink {
                ActivityView(updateActivity: true)
                    .navigationTitle("Activity")
            } label: {
                StepSummaryView()
            }
            
            // MARK: User Workouts
            NavigationLink {
                ActivityView(updateActivity: true)
                    .navigationTitle("Activity")
            } label: {
                WorkoutSummaryView()
            }
            
            // MARK: User Activity Level
            NavigationLink {
                ActivityView(updateActivity: true)
                    .navigationTitle("Activity")
            } label: {
                ActivitySummaryView()
            }
            
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
    private var userHighCalDays: some View {
        NavigationLink {
            AdjustedCalorieDaysView(updateTrainingDays: true)
                .navigationTitle("High Calorie Days")
        } label: {
            AdjustedCalorieDaysSummaryView()
        }
    }
}
