//
//  GoalSummaryView.swift
//  NutrientCalculatorV3
//
//  Created by Kyle Blandford on 6/24/22.
//

import SwiftUI

struct GoalSummaryView: View {
    
    @EnvironmentObject private var viewModel: EnvironmentViewModel

    var body: some View {
        HStack {
            Text("Goal: ")
                .bold()
            Spacer()
            Text(viewModel.user.goalType.rawValue)
                .padding(.trailing, 50)
        }
        .modifier(UserInfoViewModifier())
    }
}

struct GoalSummaryView_Previews: PreviewProvider {
    static var previews: some View {
        GoalSummaryView()
            .environmentObject(dev.environmentViewModel)
    }
}
