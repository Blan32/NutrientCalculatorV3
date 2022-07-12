//
//  CaloriePreferenceSummaryView.swift
//  NutrientCalculatorV3
//
//  Created by Kyle Blandford on 6/30/22.
//

import SwiftUI

struct CaloriePreferenceSummaryView: View {
    
    @EnvironmentObject private var viewModel: GlobalUserViewModel
    
    var body: some View {
        HStack {
            Text("Calorie Preference: ")
                .bold()
            Spacer()

            Text(viewModel.user.dynamicCalories ? "Dynamic" : "Static")
            
            if viewModel.user.dynamicCalories {
                Text("(+\(viewModel.user.dynamicCalorieVariance, specifier: "%.f")%)")
                    .foregroundColor(viewModel.user.dynamicCalorieVarianceDescriptionTextColor)
            }
        }
        .padding(.trailing, 50)
        .modifier(UserInfoViewModifier())
    }
}

struct CaloriePreferenceSummaryView_Previews: PreviewProvider {
    static var previews: some View {
        CaloriePreferenceSummaryView()
            .environmentObject(dev.globalViewModel)
    }
}
