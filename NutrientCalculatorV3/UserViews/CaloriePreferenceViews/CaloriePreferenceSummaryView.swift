//
//  CaloriePreferenceSummaryView.swift
//  NutrientCalculatorV3
//
//  Created by Kyle Blandford on 6/30/22.
//

import SwiftUI

struct CaloriePreferenceSummaryView: View {
    
    @EnvironmentObject private var viewModel: EnvironmentViewModel
    
    var body: some View {
        HStack {
            Text("Calorie Preference: ")
                .bold()
            Spacer()

            Text(viewModel.user.dynamicCalories ? "Dynamic" : "Static")
            
            if viewModel.user.dynamicCalories {
                Text("(+\(viewModel.user.dynamicCalorieVariance, specifier: "%.f")%)")
                    .foregroundColor(dynamicCalorieVarianceDescriptionTextColor)
            }
        }
        .padding(.trailing, 50)
        .modifier(UserInfoViewModifier())
    }
}

struct CaloriePreferenceSummaryView_Previews: PreviewProvider {
    static var previews: some View {
        CaloriePreferenceSummaryView()
            .environmentObject(dev.environmentViewModel)
    }
}

extension CaloriePreferenceSummaryView {
    
    private var dynamicCalorieVarianceDescriptionTextColor: Color {
        if viewModel.user.dynamicCalorieVarianceDescription == "Low" {
            return Color.blue
        } else if viewModel.user.dynamicCalorieVarianceDescription == "Moderate" {
            return Color.green
        } else if viewModel.user.dynamicCalorieVarianceDescription == "High" {
            return Color.red
        } else {
            return Color.accentColor
        }
    }
}
