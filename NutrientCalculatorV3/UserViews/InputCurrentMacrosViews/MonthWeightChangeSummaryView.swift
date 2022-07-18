//
//  30DayWeightChangeSummaryView.swift
//  NutrientCalculatorV3
//
//  Created by Kyle Blandford on 6/24/22.
//

import SwiftUI

struct MonthWeightChangeSummaryView: View {
    
    @EnvironmentObject private var viewModel: EnvironmentViewModel

    var body: some View {
        HStack{
            Text("Prior Weight Change: ")
                .bold()
            Spacer()
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
                .padding(.trailing, 50)
        }
        .modifier(UserInfoViewModifier())
    }
}

struct MonthWeightChangeSummaryView_Previews: PreviewProvider {
    static var previews: some View {
        MonthWeightChangeSummaryView()
            .environmentObject(dev.environmentViewModel)
    }
}
