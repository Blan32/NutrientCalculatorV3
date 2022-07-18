//
//  NutrientCalculatorV3App.swift
//  NutrientCalculatorV3
//
//  Created by Kyle Blandford on 6/10/22.
//

import SwiftUI

@main
struct NutrientCalculatorV3App: App {
    
    @StateObject private var dataManager = CoreDataManager.instance
    @StateObject private var viewModel = EnvironmentViewModel()
    
    var body: some Scene {
        WindowGroup {
            DashboardTabView()
                .environmentObject(viewModel)
                .environment(\.managedObjectContext, dataManager.container.viewContext)
        }
    }
}
