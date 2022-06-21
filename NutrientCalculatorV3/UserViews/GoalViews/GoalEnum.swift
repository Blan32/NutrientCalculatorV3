//
//  GoalEnum.swift
//  NutrientCalculatorV3
//
//  Created by Kyle Blandford on 6/16/22.
//

import Foundation

enum Goal: String, CaseIterable, Codable {
    case fatloss = "Fat Loss"
    case muscleGrowth = "Muscle Growth"
    case maintenance = "Maintenance"
}
