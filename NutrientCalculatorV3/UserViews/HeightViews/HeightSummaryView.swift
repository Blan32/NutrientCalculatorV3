//
//  HeightSummaryView.swift
//  NutrientCalculatorV3
//
//  Created by Kyle Blandford on 6/24/22.
//

import SwiftUI

struct HeightSummaryView: View {
    
    @EnvironmentObject private var viewModel: GlobalUserViewModel
    
    var body: some View {
        HStack {
            Text("Height: ")
                .bold()
            Text(viewModel.user.heightInFeetAndInches ? "\(viewModel.user.heightIn / 12) ft \(viewModel.user.heightIn % 12) in" : "\(viewModel.user.heightCm) cm")
        }
        .modifier(UserInfoViewModifier())
    }
}

struct HeightSummaryView_Previews: PreviewProvider {
    static var previews: some View {
        HeightSummaryView()
            .environmentObject(dev.globalViewModel)
    }
}