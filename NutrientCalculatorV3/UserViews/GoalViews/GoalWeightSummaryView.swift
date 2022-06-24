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
            Text(viewModel.user.weightInPounds ? viewModel.user.goalWeightLbs + " lbs" : viewModel.user.goalWeightKgs + " kgs")
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
