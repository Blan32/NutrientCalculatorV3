//
//  HeightSummaryView.swift
//  NutrientCalculatorV3
//
//  Created by Kyle Blandford on 6/24/22.
//

import SwiftUI

struct HeightSummaryView: View {
    
    @EnvironmentObject private var viewModel: EnvironmentViewModel
    
    var body: some View {
        HStack {
            Text("Height: ")
                .bold()
            Spacer()
            Text(viewModel.coreDataUser.first!.heightInInches ? "\(Int(viewModel.coreDataUser.first!.heightIn / 12)) ft \(Int(viewModel.coreDataUser.first!.heightIn % 12)) in" : "\(Int(viewModel.coreDataUser.first!.heightCm)) cm")
                .padding(.trailing, 50)
        }
        .modifier(UserInfoViewModifier())
    }
}

struct HeightSummaryView_Previews: PreviewProvider {
    static var previews: some View {
        HeightSummaryView()
            .environmentObject(dev.environmentViewModel)
    }
}
