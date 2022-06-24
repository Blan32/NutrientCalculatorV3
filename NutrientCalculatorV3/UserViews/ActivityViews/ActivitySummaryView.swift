//
//  ActivitySummaryView.swift
//  NutrientCalculatorV3
//
//  Created by Kyle Blandford on 6/24/22.
//

import SwiftUI

struct ActivitySummaryView: View {
    
    @EnvironmentObject private var viewModel: GlobalUserViewModel
    
    var body: some View {
        HStack {
            Text("Overall Activity Level: ")
                .bold()
            Text(viewModel.user.activityLevel.rawValue)
                .foregroundColor(viewModel.user.trainingSessionsPerWeek.workoutIntensityColor())
        }
        .modifier(UserInfoViewModifier())
    }
}

struct ActivitySummaryView_Previews: PreviewProvider {
    static var previews: some View {
        ActivitySummaryView()
            .environmentObject(dev.globalViewModel)
    }
}
