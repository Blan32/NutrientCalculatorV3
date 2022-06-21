//
//  PriorMacros.swift
//  NutrientCalculatorV3
//
//  Created by Kyle Blandford on 6/20/22.
//

import SwiftUI

struct CurrentMacrosView: View {
    
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
                
//                if focusedTextField != nil {
//                    Text("Calories must be input manually if entering only one or two macros.")
//                        .bold()
//                        .foregroundColor(Color.red)
//                        .padding(.top)
//                        .padding(.horizontal)
//                }
                
                Text("Enter Current Macros:")
                    .font(.caption)
                    .foregroundColor(.secondary)
                    .bold()
                    .padding(.top, 30)
                
                inputMacros
                
                if focusedTextField == nil {
                    weightChangeLastMonth
                        .padding(.top, 50)
                }

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
        CurrentMacrosView()
            .environmentObject(dev.globalViewModel)
    }
}

extension CurrentMacrosView {
    
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
        VStack {
            
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
            Text("How much has your weight changed in the last month following these calories/macros?")
            
            HStack(spacing: 2) {
                Spacer()
                
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
                
                Text("lbs")
                
                Spacer()
            }
            .padding(.vertical)
            .foregroundColor(viewModel.user.inputWeightChange > 0 ? Color.green : viewModel.user.inputWeightChange < 0 ? Color.red : Color.primary)
            
            Slider(value: $viewModel.user.inputWeightChange, in: -25.0...25.0, step: 0.5)
        }
        .padding(.horizontal, 20)
    }
}
