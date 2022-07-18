//
//  TrainingDaysPickerView.swift
//  NutrientCalculatorV3
//
//  Created by Kyle Blandford on 6/30/22.
//

import SwiftUI

struct AdjustedCalorieDaysPickerView: View {
    
    @Environment(\.colorScheme) var colorScheme
    @EnvironmentObject private var viewModel: EnvironmentViewModel
        
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
            toggleOnMonday: dev.environmentViewModel.user.monday,
            toggleOnTuesday: dev.environmentViewModel.user.tuesday,
            toggleOnWednesday: dev.environmentViewModel.user.wednesday,
            toggleOnThursday: dev.environmentViewModel.user.thursday,
            toggleOnFriday: dev.environmentViewModel.user.friday,
            toggleOnSaturday: dev.environmentViewModel.user.saturday,
            toggleOnSunday: dev.environmentViewModel.user.sunday
        )
            .preferredColorScheme(.dark)
            .environmentObject(dev.environmentViewModel)
    }
}


extension AdjustedCalorieDaysPickerView {
    
    // MARK: Monday
    private var monday: some View {
        Text("Monday")
            .modifier(AdjustedCalorieDaysViewModifier(toggleOn: $toggleOnMonday))
            .onTapGesture {
                withAnimation(.spring()) {
                    viewModel.user.monday.toggle()
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
                    viewModel.user.tuesday.toggle()
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
                    viewModel.user.wednesday.toggle()
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
                    viewModel.user.thursday.toggle()
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
                    viewModel.user.friday.toggle()
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
                    viewModel.user.saturday.toggle()
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
                    viewModel.user.sunday.toggle()
                    toggleOnSunday.toggle()
                }
            }
    }
}
