//
//  CheckInsListView.swift
//  NutrientCalculatorV3
//
//  Created by Kyle Blandford on 7/18/22.
//

import SwiftUI
import CoreData

struct WeighInsListView: View {
    
    @Environment(\.managedObjectContext) var moc
    @EnvironmentObject private var viewModel: EnvironmentViewModel
    @FetchRequest(sortDescriptors: [SortDescriptor(\.date, order: .reverse)]) var loggedWeighIns: FetchedResults<WeighIn>
    @FetchRequest(sortDescriptors: [SortDescriptor(\.date, order: .reverse)]) var loggedCheckIns: FetchedResults<CheckIn>
    @FetchRequest(sortDescriptors: []) var userHeightMetrics: FetchedResults<HeightMetrics>
    
    var body: some View {
        VStack {
            checkIns
            ForEach(userHeightMetrics) { metric in
                Text("\(metric.height)")
            }
        }
    }
}

struct CheckInsListView_Previews: PreviewProvider {
    static var previews: some View {
        WeighInsListView()
            .environmentObject(dev.environmentViewModel)
    }
}

extension WeighInsListView {
    
    private var checkIns: some View {
        VStack {
            ForEach(loggedCheckIns) { checkIn in
                NavigationLink {
                    Text("Hi")
                } label: {
                    VStack {
                        HStack {
                            
                            // MARK: !!! Make this date range of the checkin (currently just date)
                            
                            Text(checkIn.date?.numericDate ?? Date().numericDate)
                            Spacer()
                            HStack(spacing: 2) {
                                Text("Average Weight: \(checkIn.averageWeight, specifier: "%.1f")")
                                Text(viewModel.user.weightInPounds ? "lbs" : "kgs")
                            }
                        }
                        .padding(.horizontal, 30)
                        
                        HStack {
                            Text("Cal: \(checkIn.calories, specifier: "%.f")")
                                .padding(.horizontal, 9)
                                .frame(height: 30)
                                .background(
                                    RoundedRectangle(cornerRadius: 25)
                                        .fill(Color.calorieColor)
                            )
                            Text("F: \(checkIn.fats, specifier: "%.f")g")
                                .padding(.horizontal, 9)
                                .frame(height: 30)
                                .background(
                                    RoundedRectangle(cornerRadius: 25)
                                        .fill(Color.fatColor)
                                )
                            Text("C: \(checkIn.carbs, specifier: "%.f")g")
                                .padding(.horizontal, 9)
                                .frame(height: 30)
                                .background(
                                    RoundedRectangle(cornerRadius: 25)
                                        .fill(Color.carbColor)
                                )
                            Text("P: \(checkIn.protein, specifier: "%.f")g")
                                .padding(.horizontal, 9)
                                .frame(height: 30)
                                .background(
                                    RoundedRectangle(cornerRadius: 25)
                                        .fill(Color.proteinColor)
                                )
                        }
 
                        weighIns
                    }
                    .padding(.vertical)
                    
                    .background(
                        RoundedRectangle(cornerRadius: 25)
                            .stroke(Color.secondary.opacity(0.3), lineWidth: 2)
                    )
                    .padding(.horizontal, 8)
                }
            }
        }
    }
    
    private var weighIns: some View {
        ForEach(loggedWeighIns) { weighIn in
            HStack {
                Text("\(weighIn.date?.numericDate ?? Date().numericDate):")
                    .frame(width: 70)
                Text("\(weighIn.weight, specifier: "%.1f")")
                Spacer()
            }
            .padding(.horizontal)
            .frame(height: 30)
            .frame(maxWidth: .infinity)
            .background(
                RoundedRectangle(cornerRadius: 25)
                    .fill(Color.secondary.opacity(0.3))
            )
            .padding(.horizontal, 10)
        }
    }
}
