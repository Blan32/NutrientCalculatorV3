//
//  GoalWeightSummaryView.swift
//  NutrientCalculatorV3
//
//  Created by Kyle Blandford on 6/24/22.
//

import SwiftUI

struct GoalWeightSummaryView: View {
    
    @EnvironmentObject private var viewModel: EnvironmentViewModel

    var body: some View {
        HStack {
            Text("Goal Weight: ")
                .bold()
            Spacer()
            
            Text(viewModel.user.weightInPounds ? "\(viewModel.user.goalWeight)" + " lbs" : "\(viewModel.user.goalWeight)" + " kgs")
                .padding(.trailing, 50)
        }
        .modifier(UserInfoViewModifier())
    }
}

struct GoalWeightSummaryView_Previews: PreviewProvider {
    static var previews: some View {
        GoalWeightSummaryView()
            .environmentObject(dev.environmentViewModel)
    }
}
