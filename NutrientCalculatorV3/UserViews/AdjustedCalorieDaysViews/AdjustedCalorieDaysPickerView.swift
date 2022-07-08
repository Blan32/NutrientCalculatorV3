//
//  TrainingDaysPickerView.swift
//  NutrientCalculatorV3
//
//  Created by Kyle Blandford on 6/30/22.
//

import SwiftUI

struct AdjustedCalorieDaysPickerView: View {
    
    @Environment(\.colorScheme) var colorScheme
    @EnvironmentObject private var viewModel: GlobalUserViewModel
    
    var updateTrainingDays: Bool
    
    @State var toggleOnMonday: Bool
    @State var toggleOnTuesday: Bool
    @State var toggleOnWednesday: Bool
    @State var toggleOnThursday: Bool
    @State var toggleOnFriday: Bool
    @State var toggleOnSaturday: Bool
    @State var toggleOnSunday: Bool
    
    var body: some View {
        VStack {
            monday
            tuesday
            wednesday
            thursday
            friday
            saturday
            sunday
        }
    }
}

struct TrainingDaysPickerView_Previews: PreviewProvider {
    static var previews: some View {
        AdjustedCalorieDaysPickerView(
            updateTrainingDays: true,
            toggleOnMonday: dev.globalViewModel.user.monday,
            toggleOnTuesday: dev.globalViewModel.user.tuesday,
            toggleOnWednesday: dev.globalViewModel.user.wednesday,
            toggleOnThursday: dev.globalViewModel.user.thursday,
            toggleOnFriday: dev.globalViewModel.user.friday,
            toggleOnSaturday: dev.globalViewModel.user.saturday,
            toggleOnSunday: dev.globalViewModel.user.sunday
        )
            .preferredColorScheme(.dark)
            .environmentObject(dev.globalViewModel)
    }
}


extension AdjustedCalorieDaysPickerView {
    
    // MARK: Monday
    private var monday: some View {
        Text("Monday")
            .modifier(AdjustedCalorieDaysViewModifier(toggleOn: $toggleOnMonday))
            .onTapGesture {
                withAnimation(.spring()) {
                    updateTrainingDays ? viewModel.user.updateMonday.toggle() : viewModel.user.monday.toggle()
                    toggleOnMonday.toggle()
                }
            }
    }
    
    // MARK: Tuesday
    private var tuesday: some View {
        Text("Tuesday")
            .modifier(AdjustedCalorieDaysViewModifier(toggleOn: $toggleOnTuesday))
            .onTapGesture {
                withAnimation(.spring()) {
                    updateTrainingDays ? viewModel.user.updateTuesday.toggle() : viewModel.user.tuesday.toggle()
                    toggleOnTuesday.toggle()
                }
            }
    }
    
    // MARK: Wednesday
    private var wednesday: some View {
        Text("Wednesday")
            .modifier(AdjustedCalorieDaysViewModifier(toggleOn: $toggleOnWednesday))
            .onTapGesture {
                withAnimation(.spring()) {
                    updateTrainingDays ? viewModel.user.updateWednesday.toggle() : viewModel.user.wednesday.toggle()
                    toggleOnWednesday.toggle()
                }
            }
    }
    
    // MARK: Thursday
    private var thursday: some View {
        Text("Thursday")
            .modifier(AdjustedCalorieDaysViewModifier(toggleOn: $toggleOnThursday))
            .onTapGesture {
                withAnimation(.spring()) {
                    updateTrainingDays ? viewModel.user.updateThursday.toggle() : viewModel.user.thursday.toggle()
                    toggleOnThursday.toggle()
                }
            }
    }
    
    // MARK: Friday
    private var friday: some View {
        Text("Friday")
            .modifier(AdjustedCalorieDaysViewModifier(toggleOn: $toggleOnFriday))
            .onTapGesture {
                withAnimation(.spring()) {
                    updateTrainingDays ? viewModel.user.updateFriday.toggle() : viewModel.user.friday.toggle()
                    toggleOnFriday.toggle()
                }
            }
    }
    
    // MARK: Saturday
    private var saturday: some View {
        Text("Saturday")
            .modifier(AdjustedCalorieDaysViewModifier(toggleOn: $toggleOnSaturday))
            .onTapGesture {
                withAnimation(.spring()) {
                    updateTrainingDays ? viewModel.user.updateSaturday.toggle() : viewModel.user.saturday.toggle()
                    toggleOnSaturday.toggle()
                }
            }
    }
    
    // MARK: Sunday
    private var sunday: some View {
        Text("Sunday")
            .modifier(AdjustedCalorieDaysViewModifier(toggleOn: $toggleOnSunday))
            .onTapGesture {
                withAnimation(.spring()) {
                    updateTrainingDays ? viewModel.user.updateSunday.toggle() : viewModel.user.sunday.toggle()
                    toggleOnSunday.toggle()
                }
            }
    }
}