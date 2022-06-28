//
//  BirthdayPicker.swift
//  NutrientCalculatorV3
//
//  Created by Kyle Blandford on 6/14/22.
//

import SwiftUI

struct BirthdayPickerView: View {
    
    @EnvironmentObject private var viewModel: GlobalUserViewModel
    @State var updateAge: Bool
    
    let startDate: Date = Calendar.current.date(byAdding: .year, value: -100, to: Date()) ?? Date()
    let endDate: Date = Calendar.current.date(byAdding: .year, value: -13, to: Date()) ?? Date()
    
    var body: some View {
        VStack {
            if updateAge {
                updateBirthdayPicker
            } else {
                birthdayPicker
            }
        }
    }
}

struct BirthdayPicker_Previews: PreviewProvider {
    static var previews: some View {
        BirthdayPickerView(updateAge: true)
            .environmentObject(dev.globalViewModel)
    }
}

extension BirthdayPickerView {
    
    private var birthdayPicker: some View {
        DatePicker("Birthday", selection: $viewModel.user.birthday, in: startDate...endDate, displayedComponents: [.date])
            .datePickerStyle(.wheel)
            .labelsHidden()
    }
    
    private var updateBirthdayPicker: some View {
        DatePicker("Birthday", selection: $viewModel.user.updateBirthday, in: startDate...endDate, displayedComponents: [.date])
            .datePickerStyle(.wheel)
            .labelsHidden()
    }
}
