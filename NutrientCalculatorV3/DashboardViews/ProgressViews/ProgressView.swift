//
//  ProgressView.swift
//  NutrientCalculatorV3
//
//  Created by Kyle Blandford on 7/18/22.
//

import SwiftUI
import CoreData

struct ProgressView: View {
    
    @EnvironmentObject private var viewModel: EnvironmentViewModel
    @FocusState private var focusedTextField: Bool
    @State private var weight: String = ""
    @State private var date: Date =  Date()
    
    
    
    var body: some View {
        ScrollView {
            addWeight
            WeighInsListView()

            
        }
        .toolbar {
            ToolbarItemGroup(placement: .keyboard) {
                HStack {
                    KeyboardDismissButton(focusedTextField: $focusedTextField)
                    Spacer()
                }
            }
        }
    }
}

struct ProgressView_Previews: PreviewProvider {
    
    static var previews: some View {
        ProgressView()
            .environmentObject(dev.environmentViewModel)
    }
}

extension ProgressView {
    
    private var addWeight: some View {
        VStack {
            TextField("New Weight", text: $weight)
                .focused($focusedTextField)
                .modifier(WeightTextFieldViewModifier())
                .keyboardType(.decimalPad)
            
            DatePicker("Date", selection: $date, displayedComponents: .date)
                .padding(5)
                .padding(.horizontal)
            
            Button {
                viewModel.manager.addWeighIn(date: date, weight: Double(weight) ?? 0.0)
                focusedTextField = false
            } label: {
                Text("Update Weight")
                    .frame(maxWidth: .infinity)
                    .frame(height: 30)
            }
            .modifier(UserInfoSubmitButtonModifier())
        }
    }
}
