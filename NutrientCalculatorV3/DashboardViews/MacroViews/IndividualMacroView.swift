//
//  IndividualMacroView.swift
//  NutrientCalculatorV3
//
//  Created by Kyle Blandford on 7/4/22.
//

import SwiftUI

struct IndividualMacroView: View {
    
    @EnvironmentObject private var viewModel: EnvironmentViewModel
    
    // MARK: EVENTUALLY we will want to change this to show the amount of macros consumed / total day's macros instead of the ranges so that progress updates properly
    
    var title: String
    var macroAmount: Double
    var showGramsG: Bool
    var fillColor: Color
    var progress: Double
    let length: Double = UIScreen.main.bounds.width
    
    var trainingDay: Bool
    var dayOfTheWeek = Date()
    
    var body: some View {
        HStack {
            HStack(spacing: 1) {
                Text(title + ":")
                    .bold()
                    .padding(.leading, 35)
                    .padding(.trailing, 8)
                Text("\(macroAmount, specifier: "%.f")")
                Text(showGramsG ? "g" : "")
            }
            Spacer()
            HStack(spacing: 1) {
                Text("(\(Int(macroAmount * 0.95)) - \(Int(macroAmount * 1.05)))")
                Text(showGramsG ? "g" : "")
            }
            .padding(.trailing, 35)
        }
        .frame(height: 35, alignment: .leading)
        .frame(maxWidth: length)
        .background(
            ZStack(alignment: .leading) {
                Capsule()
                    .fill(fillColor.opacity(0.5))
                    .padding(.horizontal)
                
                Capsule()
                    .fill(fillColor)
                    .padding(.horizontal)
                    .frame(width: length * progress, alignment: .leading)
            }
        )
    }
    
    private func getMacroAmount(macroAmount: Double, trainingDay: Bool, dynamicCalories: Bool, dynamicCalorieVariance: Double) {
        
    }
}

struct IndividualMacroView_Previews: PreviewProvider {
    static var previews: some View {
        IndividualMacroView(title: "Fats", macroAmount: 222.7, showGramsG: true, fillColor: Color.fatColor, progress: 0.75, trainingDay: true)
            .preferredColorScheme(.dark)
            .environmentObject(dev.environmentViewModel)
    }
}
