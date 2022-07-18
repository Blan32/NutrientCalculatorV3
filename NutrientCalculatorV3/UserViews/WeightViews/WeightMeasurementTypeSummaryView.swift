//
//  WeightMeasurementTypeSummaryView.swift
//  NutrientCalculatorV3
//
//  Created by Kyle Blandford on 7/12/22.
//

import SwiftUI

struct WeightMeasurementTypeSummaryView: View {
    
    @EnvironmentObject private var viewModel: EnvironmentViewModel
    
    var body: some View {
        HStack {
            Text("Weight Type: ")
                .bold()
            Spacer()
            Text(viewModel.user.weightInPounds ? "Pounds" : "Kilograms")
                .padding(.trailing, 50)
        }
        .modifier(UserInfoViewModifier())
    }
}

struct WeightMeasurementTypeSummaryView_Previews: PreviewProvider {
    static var previews: some View {
        WeightMeasurementTypeSummaryView()
            .environmentObject(dev.environmentViewModel)
    }
}
