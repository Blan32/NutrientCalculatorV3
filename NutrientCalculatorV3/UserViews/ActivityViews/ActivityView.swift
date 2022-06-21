//
//  ActivityView.swift
//  NutrientCalculatorV3
//
//  Created by Kyle Blandford on 6/14/22.
//

import SwiftUI

struct ActivityView: View {
    
    @EnvironmentObject private var viewModel: GlobalUserViewModel
    
    //MARK: View
    var body: some View {
        VStack {
            stepsPerDay
            workoutsPerWeek
            activityRating
            Spacer()
        }
    }
}

struct ActivityView_Previews: PreviewProvider {
    static var previews: some View {
        ActivityView()
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
            
            StepPicker()
        }
    }
    
    //MARK: Workouts Per Week
    private var workoutsPerWeek: some View {
        VStack {
            Text("How many workout sessions do you have each week?")
            .frame(maxWidth: .infinity, alignment: .leading)
            .padding()
            
            WorkoutAmountPicker()
        }
    }
    
    //MARK: Activity Rating
    private var activityRating: some View {
        VStack {
            Text("Total Activity Rating: ")
                .padding(.horizontal)
                .padding(.top)
            Text("\(viewModel.user.activityLevel.rawValue)")
                .bold()
                .foregroundColor(viewModel.user.activityLevel.intensityColor())
                .padding(.top, 1)
        }
    }
}
