//
//  BirthdayPicker.swift
//  NutrientCalculatorV3
//
//  Created by Kyle Blandford on 6/14/22.
//

import SwiftUI

struct BirthdayPicker: View {
    
    @EnvironmentObject private var viewModel: GlobalUserViewModel
    
    var body: some View {
        VStack {
            Text("Age: \(viewModel.user.age ?? 30)")
                .font(.title2)
                .bold()
            
            DatePicker("Birthday", selection: $viewModel.user.birthday, displayedComponents: [.date])
                .datePickerStyle(.wheel)
                .labelsHidden()            
        }
    }
}

struct BirthdayPicker_Previews: PreviewProvider {
    static var previews: some View {
        BirthdayPicker()
            .environmentObject(dev.globalViewModel)
    }
}
