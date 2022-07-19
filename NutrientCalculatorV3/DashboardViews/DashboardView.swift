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
    @EnvironmentObject private var viewModel: EnvironmentViewModel
    @FetchRequest(sortDescriptors: [SortDescriptor(\.date, order: .reverse)]) var loggedCheckIns: FetchedResults<CheckIn>
    
    @State var calorieProgress: Double = 0.75
    @State var fatsProgress: Double = 0.6
    @State var carbsProgress: Double = 0.8
    @State var proteinProgress: Double = 0.85
    
    var isTrainingDay: Bool = true
    
    var body: some View {
        NavigationView {
            ScrollView {
                todaysMacros
                progressTowardsGoal
                
                HStack(spacing: 1) {
                    weeklyMacroAverages
                    mealsLoggedToday
                }
            }
            .navigationTitle("Dashboard")
            .navigationBarItems(
                trailing:
                    NavigationLink {
                        AccountView()
                            .navigationTitle("Account")
                    } label: {
                        Image(systemName: "person")
                    }
                    .isDetailLink(false)
            )
        }
    }
}

struct DashboardView_Previews: PreviewProvider {
    static var previews: some View {
        DashboardView()
            .environmentObject(dev.environmentViewModel)
    }
}


extension DashboardView {
    
    private var todaysMacros: some View {
        VStack {
            Text("Macros")
                .bold()
                .frame(maxWidth: .infinity, alignment: .leading)
                .padding(.horizontal, 25)
            
            IndividualMacroView(
                title: "Calories",
                macroAmount: loggedCheckIns.last?.calories ?? 0,
                showGramsG: false,
                fillColor: Color.calorieColor,
                progress: calorieProgress,
                trainingDay: isTrainingDay)
            
            IndividualMacroView(
                title: "Fats",
                macroAmount: loggedCheckIns.last?.fats ?? 0,
                showGramsG: true,
                fillColor: Color.fatColor,
                progress: fatsProgress,
                trainingDay: isTrainingDay)
            
            IndividualMacroView(
                title: "Carbs",
                macroAmount: loggedCheckIns.last?.carbs ?? 0,
                showGramsG: true,
                fillColor: Color.carbColor,
                progress: carbsProgress,
                trainingDay: isTrainingDay)
            
            IndividualMacroView(
                title: "Protein",
                macroAmount: loggedCheckIns.last?.protein ?? 0,
                showGramsG: true,
                fillColor: Color.proteinColor,
                progress: proteinProgress,
                trainingDay: isTrainingDay)
        }
        .padding(.vertical)
        .background(sectionBorder.padding(.horizontal, 8))
    }
    
    private var progressTowardsGoal: some View {
        NavigationLink {
            WeightProgressView()
                .navigationTitle("Progress")
        } label: {
            VStack {
                Text("Progress")
                    .bold()
                    .frame(maxWidth: .infinity, alignment: .leading)
                    .padding(.horizontal, 25)
                
                Spacer()
            }
            .frame(height: 150)
            .padding(.top)
            .background(sectionBorder.padding(.horizontal, 8))
        }
    }
    
    private var weeklyMacroAverages: some View {
        VStack {
            Text("Avg Macros Hit")
                .bold()
                .frame(maxWidth: UIScreen.main.bounds.width * 0.5, alignment: .leading)
                .padding(.horizontal, 25)
            
            RoundedRectangle(cornerRadius: 25)
                .fill(Color.clear)
                .frame(width: 150, height: 150)
        }
        .padding(.vertical)
        .background(
            sectionBorder
                .padding(.leading, 6)
                .padding(.trailing, 3)
        )
    }
    
    private var mealsLoggedToday: some View {
        VStack {
            Text("Meals Logged")
                .bold()
                .frame(maxWidth: UIScreen.main.bounds.width * 0.5, alignment: .leading)
                .padding(.horizontal, 25)
            
            RoundedRectangle(cornerRadius: 25)
                .fill(Color.clear)
                .frame(width: 150, height: 150)
        }
        .padding(.vertical)
        .background(
            sectionBorder
                .padding(.leading, 3)
                .padding(.trailing, 6)
        )
    }
    
    private var sectionBorder: some View {
        RoundedRectangle(cornerRadius: 25)
            .stroke(Color.secondary.opacity(0.3), lineWidth: 2)
            
    }
}
