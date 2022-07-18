//
//  WeightSummaryView.swift
//  NutrientCalculatorV3
//
//  Created by Kyle Blandford on 6/24/22.
//

import SwiftUI

struct WeightSummaryView: View {
    
    @EnvironmentObject private var viewModel: EnvironmentViewModel
    
    var body: some View {
        HStack {
            Text("Starting Weight: ")
                .bold()
            Spacer()
            Text(viewModel.user.weightInPounds ? viewModel.user.inputWeightLbs + " lbs" : viewModel.user.inputWeightLbs + " kgs")
                .padding(.trailing, 50)
        }
        .modifier(UserInfoViewModifier())
    }
}

struct WeightSummaryView_Previews: PreviewProvider {
    static var previews: some View {
        WeightSummaryView()
            .environmentObject(dev.environmentViewModel)
    }
}
