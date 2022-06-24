//
//  PriorMacros.swift
//  NutrientCalculatorV3
//
//  Created by Kyle Blandford on 6/20/22.
//

import SwiftUI

struct InputCurrentMacrosView: View {
    
    @EnvironmentObject private var viewModel: GlobalUserViewModel
    @FocusState private var focusedTextField: FormTextField?

    enum FormTextField {
        case fats
        case carbs
        case protein
        case calories
    }
    
    //MARK: View
    var body: some View {
        NavigationView {
            VStack {
                if focusedTextField == nil {
                    Text("Please input your current calorie and macro data if possible. If you have not tracked these recently then leave them blank.")
                        .padding(.top)
                        .padding(.horizontal)
                }
                
                Text("Enter Current Macros:")
                    .font(.caption)
                    .foregroundColor(.secondary)
                    .bold()
                    .padding(.top, focusedTextField == nil ? 30 : 5)
                
                inputMacros
                
                weightChangeLastMonth
                    .padding(.top, focusedTextField == nil ?  50 : 0)
                
                Spacer()
            }
            .navigationBarHidden(true)
            .toolbar {
                ToolbarItemGroup(placement: .keyboard) {
                    keyboardDownButton
                    Spacer()
                    keyboardNextButton
                }
            }
        }
    }
}

struct PriorMacros_Previews: PreviewProvider {
    static var previews: some View {
        InputCurrentMacrosView()
            .environmentObject(dev.globalViewModel)
    }
}

extension InputCurrentMacrosView {
    
    //MARK: Keyboard Buttons
    private var keyboardDownButton: some View {
        Button {
            focusedTextField = nil
        } label: {
            Image(systemName: "keyboard.chevron.compact.down")
        }
    }
    
    private var keyboardNextButton: some View {
        Button {
            if focusedTextField == .fats {
                focusedTextField = .carbs
            } else if focusedTextField == .carbs {
                focusedTextField = .protein
            } else if focusedTextField == .protein {
                focusedTextField = .calories
            } else {
                focusedTextField = nil
            }
        } label: {
            Text(focusedTextField == .calories ? "Done" : "Next")
        }
    }
    
    //MARK: InputMacros
    private var inputMacros: some View {
        VStack(spacing: 8) {
            
            //MARK: Fats
            HStack {
                Text("Fats:")
                    .bold()
                    .frame(width: 75, height: 30, alignment: .leading)
                    .padding(.horizontal)
                    .background(
                        Capsule()
                            .fill(Color.fatColor)
                    )
                
                TextField("Avg Fats", text: $viewModel.user.inputFats)
                    .padding(.leading)
                    .frame(width: UIScreen.main.bounds.width * 0.35, height: 30, alignment: .leading)
                    .background(
                        Capsule()
                            .stroke(Color.fatColor, lineWidth: 3)
                    )
                    .keyboardType(.decimalPad)
                    .focused($focusedTextField, equals: .fats)
                
                Text("g")
            }
            
            //MARK: Carbs
            HStack {
                Text("Carbs:")
                    .bold()
                    .frame(width: 75, height: 30, alignment: .leading)
                    .padding(.horizontal)
                    .background(
                        Capsule()
                            .fill(Color.carbColor)
                    )
                
                TextField("Avg Carbs", text: $viewModel.user.inputCarbs)
                    .padding(.leading)
                    .frame(width: UIScreen.main.bounds.width * 0.35, height: 30, alignment: .leading)
                    .background(
                        Capsule()
                            .stroke(Color.carbColor, lineWidth: 3)
                    )
                    .keyboardType(.decimalPad)
                    .focused($focusedTextField, equals: .carbs)
                
                Text("g")
            }
            
            //MARK: Protein
            HStack {
                Text("Protein:")
                    .bold()
                    .frame(width: 75, height: 30, alignment: .leading)
                    .padding(.horizontal)
                    .background(
                        Capsule()
                            .fill(Color.proteinColor)
                    )
                
                TextField("Avg Protein", text: $viewModel.user.inputProtein)
                    .padding(.leading)
                    .frame(width: UIScreen.main.bounds.width * 0.35, height: 30, alignment: .leading)
                    .background(
                        Capsule()
                            .stroke(Color.proteinColor, lineWidth: 3)
                    )
                    .keyboardType(.decimalPad)
                    .focused($focusedTextField, equals: .protein)
                
                Text("g")
            }
            
            //MARK: Calories
            HStack {
                Text("Calories:")
                    .bold()
                    .frame(width: 75, height: 30, alignment: .leading)
                    .padding(.horizontal)
                    .background(
                        Capsule()
                            .fill(Color.calorieColor)
                    )
                
                // If any macros are entered, the text will show the calculated calories until user enters actual calories in the textField
                // If all macros are entered inputCalories will be calculated automatically whether they are entered or not (happens in viewModel)
                TextField(viewModel.user.inputFats != "" || viewModel.user.inputCarbs != "" || viewModel.user.inputProtein != "" ? viewModel.calculateInputCalories() : "Avg Calories", text: $viewModel.user.inputCalories)
                    .padding(.leading)
                    .frame(width: UIScreen.main.bounds.width * 0.35, height: 30, alignment: .leading)
                    .background(
                        Capsule()
                            .stroke(Color.calorieColor, lineWidth: 3)
                    )
                    .keyboardType(.decimalPad)
                    .focused($focusedTextField, equals: .calories)
                
                Text("g")
                    .opacity(0.0)
            }
        }
    }
    
    //MARK: weightChangeLastMonth
    private var weightChangeLastMonth: some View {
        VStack {
            HStack(spacing: 2) {
                Spacer()
                
                Text("Weight Change In Past Month:")
                    .font(.caption)
                    .foregroundColor(.secondary)
                    .bold()
                
                if viewModel.user.inputWeightChange > 0 {
                    Text("+")
                        .bold()
                } else if viewModel.user.inputWeightChange < 0 {
                    Text("-")
                        .bold()
                } else {
                    Text("=")
                        .opacity(0.0)
                }
                
                Text(String(format: "%.1f", abs(viewModel.user.inputWeightChange)))
                    .bold()
                
                Text(viewModel.user.weightInPounds ? "lbs" : "kgs")
                
                Spacer()
            }
            .padding(.vertical, focusedTextField == nil ? 8 : 5)
            .foregroundColor(viewModel.user.inputWeightChange > 0 ? Color.green : viewModel.user.inputWeightChange < 0 ? Color.red : Color.primary)
            
            Slider(value: $viewModel.user.inputWeightChange, in: -25.0...25.0, step: 0.5)
        }
        .padding(.horizontal, 20)
    }
}
