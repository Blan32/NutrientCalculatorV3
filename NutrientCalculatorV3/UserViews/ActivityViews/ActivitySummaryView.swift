//
//  ActivitySummaryView.swift
//  NutrientCalculatorV3
//
//  Created by Kyle Blandford on 6/24/22.
//

import SwiftUI

struct ActivitySummaryView: View {
    
    @EnvironmentObject private var viewModel: EnvironmentViewModel
    
    var body: some View {
        HStack {
            Text("Overall Activity Level: ")
                .bold()
            Spacer()
            Text(viewModel.user.activityLevel.rawValue)
                .foregroundColor(viewModel.user.activityLevel.intensityColor())
                .padding(.trailing, 50)
        }
        .modifier(UserInfoViewModifier())
    }
}

struct ActivitySummaryView_Previews: PreviewProvider {
    static var previews: some View {
        ActivitySummaryView()
            .environmentObject(dev.environmentViewModel)
    }
}
