//
//  GoalWeightSummaryView.swift
//  NutrientCalculatorV3
//
//  Created by Kyle Blandford on 6/24/22.
//

import SwiftUI

struct GoalWeightSummaryView: View {
    
    @EnvironmentObject private var viewModel: GlobalUserViewModel

    var body: some View {
        HStack {
            Text("Goal Weight: ")
                .bold()
            Spacer()
            
            if viewModel.user.updateGoalWeight == "" {
                Text(viewModel.user.weightInPounds ? viewModel.user.inputGoalWeight + " lbs" : viewModel.user.inputGoalWeight + " kgs")
                    .padding(.trailing, 50)
            } else {
                Text(viewModel.user.weightInPounds ? viewModel.user.updateGoalWeight + " lbs" : viewModel.user.updateGoalWeight + " kgs")
                    .padding(.trailing, 50)
            }
            
        }
        .modifier(UserInfoViewModifier())
    }
}

struct GoalWeightSummaryView_Previews: PreviewProvider {
    static var previews: some View {
        GoalWeightSummaryView()
            .environmentObject(dev.globalViewModel)
    }
}
