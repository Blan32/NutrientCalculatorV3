//
//  TrainingDaysSummaryView.swift
//  NutrientCalculatorV3
//
//  Created by Kyle Blandford on 6/30/22.
//

import SwiftUI

struct AdjustedCalorieDaysSummaryView: View {
    
    @EnvironmentObject private var viewModel: EnvironmentViewModel
    
    var body: some View {
        HStack(spacing: 5) {
            Text("High Cal Days: ")
                .bold()
            Spacer()

            Text("M")
                .opacity(viewModel.user.monday ? 1.0 : 0.2)
                .frame(width: 20)
            Text("T")
                .opacity(viewModel.user.tuesday ? 1.0 : 0.2)
                .frame(width: 20)
            Text("W")
                .opacity(viewModel.user.wednesday ? 1.0 : 0.2)
                .frame(width: 20)
            Text("Th")
                .opacity(viewModel.user.thursday ? 1.0 : 0.2)
                .frame(width: 20)
            Text("F")
                .opacity(viewModel.user.friday ? 1.0 : 0.2)
                .frame(width: 20)
            Text("S")
                .opacity(viewModel.user.saturday ? 1.0 : 0.2)
                .frame(width: 20)
            Text("Su")
                .opacity(viewModel.user.sunday ? 1.0 : 0.2)
                .frame(width: 20)
        }
        .padding(.trailing, 50)
        .modifier(UserInfoViewModifier())
    }
}

struct TrainingDaysSummaryView_Previews: PreviewProvider {
    static var previews: some View {
        AdjustedCalorieDaysSummaryView()
            .environmentObject(dev.environmentViewModel)
    }
}
