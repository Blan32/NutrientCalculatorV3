//
//  30DayWeightChangeSummaryView.swift
//  NutrientCalculatorV3
//
//  Created by Kyle Blandford on 6/24/22.
//

import SwiftUI

struct MonthWeightChangeSummaryView: View {
    
    @EnvironmentObject private var viewModel: GlobalUserViewModel

    var body: some View {
        HStack{
            Text("Prior 30-Day Weight Change: ")
                .bold()
            HStack(spacing: 3) {
                if viewModel.user.inputWeightChange > 0 {
                    Text("+")
                        .bold()
                        .foregroundColor(Color.green)
                } else if viewModel.user.inputWeightChange < 0 {
                    Text("-")
                        .bold()
                        .foregroundColor(Color.red)
                } else {
                    Text("=")
                        .opacity(0.0)
                }
                Text("\(abs(viewModel.user.inputWeightChange), specifier: "%.1f")")
                    .foregroundColor(viewModel.user.inputWeightChange > 0 ? Color.green : viewModel.user.inputWeightChange < 0 ? Color.red : Color.primary)
            }
            Text(viewModel.user.weightInPounds ? "lbs" : "kgs")
                .foregroundColor(viewModel.user.inputWeightChange > 0 ? Color.green : viewModel.user.inputWeightChange < 0 ? Color.red : Color.primary)
        }
        .modifier(UserInfoViewModifier())
    }
}

struct MonthWeightChangeSummaryView_Previews: PreviewProvider {
    static var previews: some View {
        MonthWeightChangeSummaryView()
            .environmentObject(dev.globalViewModel)
    }
}