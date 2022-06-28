//
//  WorkoutSummaryView.swift
//  NutrientCalculatorV3
//
//  Created by Kyle Blandford on 6/24/22.
//

import SwiftUI

struct WorkoutSummaryView: View {
    
    @EnvironmentObject private var viewModel: GlobalUserViewModel

    var body: some View {
        HStack {
            Text("Workouts Per Week: ")
                .bold()
            Spacer()
            Text(viewModel.user.trainingSessionsPerWeek.rawValue)
                .foregroundColor(viewModel.user.trainingSessionsPerWeek.workoutIntensityColor())
                .padding(.trailing, 50)
        }
        .modifier(UserInfoViewModifier())
    }
}

struct WorkoutSummaryView_Previews: PreviewProvider {
    static var previews: some View {
        WorkoutSummaryView()
            .environmentObject(dev.globalViewModel)
    }
}
