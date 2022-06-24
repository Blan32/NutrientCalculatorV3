//
//  WeightSummaryView.swift
//  NutrientCalculatorV3
//
//  Created by Kyle Blandford on 6/24/22.
//

import SwiftUI

struct WeightSummaryView: View {
    
    @EnvironmentObject private var viewModel: GlobalUserViewModel
    
    var body: some View {
        HStack {
            Text("Starting Weight: ")
                .bold()
            if viewModel.user.weightInPounds {
                if viewModel.user.updateInputWeight == "" {
                    Text(viewModel.user.inputWeight + " lbs")
                } else {
                    Text(viewModel.user.updateInputWeight + " lbs")
                }
            } else {
                if viewModel.user.updateInputWeight == "" {
                    Text(viewModel.user.inputWeight + " kgs")
                } else {
                    Text(viewModel.user.updateInputWeight + " kgs")
                }
            }
            
//            if viewModel.user.weightInPounds {
//                if viewModel.user.updateInputWeight == "" {
//                    Text("\(Double(viewModel.user.inputWeight) ?? 0)" + " lbs")
//                } else {
//                    Text("\(Double(viewModel.user.updateInputWeight) ?? 0)" + " lbs")
//                }
//            } else {
//                if viewModel.user.updateInputWeight == "" {
//                    Text("\(Double(viewModel.user.inputWeight) ?? 0)" + " kgs")
//                } else {
//                    Text("\(Double(viewModel.user.updateInputWeight) ?? 0)" + " kgs")
//                }
//            }
        }
        .modifier(UserInfoViewModifier())
    }
}

struct WeightSummaryView_Previews: PreviewProvider {
    static var previews: some View {
        WeightSummaryView()
            .environmentObject(dev.globalViewModel)
    }
}
