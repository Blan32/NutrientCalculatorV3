//
//  HeightView.swift
//  NutrientCalculatorV3
//
//  Created by Kyle Blandford on 7/21/22.
//

import SwiftUI
import CoreData

struct HeightView: View {
    
    @Environment(\.presentationMode) var presentationMode
    @EnvironmentObject private var viewModel: EnvironmentViewModel
    
    @State var updateHeight: Bool
    @State var heightInInches: Bool
    @State var heightIn: Int
    @State var heightCm: Int
    
    private var user: [TheUser]
    
    init(viewModel: EnvironmentViewModel, updateHeight: Bool, moc: NSManagedObjectContext) {
        self.user = viewModel.coreDataUser
        self._updateHeight = State(wrappedValue: updateHeight)
        self._heightInInches = State(wrappedValue: user.first?.heightInInches ?? true)
        self._heightIn = State(wrappedValue: Int(user.first?.heightIn ?? 0))
        self._heightCm = State(wrappedValue: Int(user.first?.heightCm ?? 0))
        
        UISegmentedControl.appearance().selectedSegmentTintColor = UIColor(Color.accentColor) //changes selected background
        
        let attributes: [NSAttributedString.Key:Any] = [
            .foregroundColor : UIColor(Color.inverseAccentColor)
        ]
        UISegmentedControl.appearance().setTitleTextAttributes(attributes, for: .selected) //changes selected foreground
    }
    
    // MARK: View
    var body: some View {
        VStack {
            Text("Select your height.")
                .frame(maxWidth: .infinity, alignment: .leading)
                .padding()
                .padding(.bottom, 20)
            
            heightMeasurementTypePicker
                .padding(.bottom)
            
            heightPicker
            
            Spacer()
            
            if updateHeight {
                HStack {
                    backButton
                    submitButton
                }
            }
        }
        .onDisappear {
            if !updateHeight {
                viewModel.updateHeight(entity: user.first!, heightInInches: heightInInches, heightIn: Int64(heightIn), heightCm: Int64(heightCm))
            }
        }
    }
}

struct HeightView_Previews: PreviewProvider {
    static var previews: some View {
        HeightView(viewModel: dev.environmentViewModel, updateHeight: true, moc: dev.environmentViewModel.manager.context)
            .environmentObject(dev.environmentViewModel)
    }
}

extension HeightView {
    
    // MARK: heightMeasurementPicker
    private var heightMeasurementTypePicker: some View {
        Picker(selection: $heightInInches) {
            Text("Feet and Inches")
                .tag(true)
            Text("Centimeters")
                .tag(false)
        } label: {
            Text("Imperial vs. Metric System")
        }
        .pickerStyle(SegmentedPickerStyle())
        .foregroundColor(Color.buttonColor)
        .padding()
    }
    
    // MARK: heightPicker
    private var heightPicker: some View {
        VStack {
            Text(heightInInches ? "Height: \(heightIn / 12) ft \(heightIn % 12) in" : "Height: \(heightCm) cm")
                .bold()
                .font(.title2)
            if heightInInches {
                heightInInchesPicker
            } else {
                heightInCmPicker
            }
        }
    }
    
    // MARK: heightInInchesPicker
    private var heightInInchesPicker: some View {
        Picker(selection: $heightIn) {
            ForEach(0..<97) { inch in
                Text("\(inch / 12)' \(inch % 12)\"")
                    .bold()
                    .tag("\(inch)")
            }
        } label: {
            Text("Height in inches")
        }
        .pickerStyle(WheelPickerStyle())
    }
    
    // MARK: heightInCmPicker
    private var heightInCmPicker: some View {
        Picker(selection: $heightCm) {
            ForEach(0..<245) { cm in
                Text("\(cm) cm")
                    .bold()
                    .tag("\(cm)")
            }
        } label: {
            Text("Height in inches")
        }
        .pickerStyle(WheelPickerStyle())
    }
    
    // MARK: Back Button
    private var backButton: some View {
        Button {
            backButtonPressed()
        } label: {
            Text("Go Back")
                .frame(height: 30)
                .frame(maxWidth: .infinity)
        }
        .modifier(UserInfoBackButtonModifier())
    }
    
    // MARK: Submit Button
    private var submitButton: some View {
        Button {
            submitButtonPressed()
        } label: {
            Text("Update")
                .frame(height: 30)
                .frame(maxWidth: .infinity)
        }
        .modifier(UserInfoSubmitButtonModifier())
    }
    
    // MARK: func BackButtonPressed
    private func backButtonPressed() {
        presentationMode.wrappedValue.dismiss()
    }
    
    // MARK: func SubmitButtonPressed
    private func submitButtonPressed() {
        viewModel.updateHeight(entity: user.first!, heightInInches: heightInInches, heightIn: Int64(heightIn), heightCm: Int64(heightCm))
        presentationMode.wrappedValue.dismiss()
    }
}
