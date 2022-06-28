//
//  StepSummaryView.swift
//  NutrientCalculatorV3
//
//  Created by Kyle Blandford on 6/24/22.
//

import SwiftUI

struct StepSummaryView: View {
    
    @EnvironmentObject private var viewModel: GlobalUserViewModel
    
    var body: some View {
        HStack {
            Text("Steps Per Day: ")
                .bold()
            Spacer()
            Text(viewModel.user.stepsPerDay.rawValue)
                .foregroundColor(viewModel.user.stepsPerDay.stepIntensityColor())
                .padding(.trailing, 50)
        }
        .modifier(UserInfoViewModifier())
    }
}

struct StepSummaryView_Previews: PreviewProvider {
    static var previews: some View {
        StepSummaryView()
            .environmentObject(dev.globalViewModel)
    }
}
