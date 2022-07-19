//
//  Date+Ext.swift
//  NutrientCalculatorV3
//
//  Created by Kyle Blandford on 7/19/22.
//

import Foundation

extension Date {
    
    var numericDate: String {
        self.formatted(
            .dateTime
                .year(.twoDigits)
                .month(.defaultDigits)
                .day(.twoDigits)
        )
    }
}
