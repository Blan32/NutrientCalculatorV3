//
//  DashboardView.swift
//  NutrientCalculatorV3
//
//  Created by Kyle Blandford on 7/4/22.
//

import SwiftUI
import CoreData

struct DashboardView: View {
    
    @Environment(\.managedObjectContext) var moc
    @FetchRequest(sortDescriptors: [SortDescriptor(\.date, order: .reverse)]) var checkIn: FetchedResults<CheckIn>
    @EnvironmentObject private var viewModel: GlobalUserViewModel
    
    @State var calorieProgress: Double = 0.75
    @State var fatsProgress: Double = 0.6
    @State var carbsProgress: Double = 0.8
    @State var proteinProgress: Double = 0.85
    
    var isTrainingDay: Bool = true
    
    var body: some View {
        NavigationView {
            ScrollView {
                IndividualMacroView(
                    title: "Calories",
                    macroAmount: checkIn.last?.calories ?? 0,
                    showGramsG: false,
                    fillColor: Color.calorieColor,
                    progress: calorieProgress,
                    trainingDay: isTrainingDay)
                
                IndividualMacroView(
                    title: "Fats",
                    macroAmount: checkIn.last?.fats ?? 0,
                    showGramsG: true,
                    fillColor: Color.fatColor,
                    progress: fatsProgress,
                    trainingDay: isTrainingDay)
                
                IndividualMacroView(
                    title: "Carbs",
                    macroAmount: checkIn.last?.carbs ?? 0,
                    showGramsG: true,
                    fillColor: Color.carbColor,
                    progress: carbsProgress,
                    trainingDay: isTrainingDay)
                
                IndividualMacroView(
                    title: "Protein",
                    macroAmount: checkIn.last?.protein ?? 0,
                    showGramsG: true,
                    fillColor: Color.proteinColor,
                    progress: proteinProgress,
                    trainingDay: isTrainingDay)
                

            }
            .navigationTitle("Dashboard")
        }
    }
}

struct DashboardView_Previews: PreviewProvider {
    static var previews: some View {
        DashboardView()
            .environmentObject(dev.globalViewModel)
    }
}
