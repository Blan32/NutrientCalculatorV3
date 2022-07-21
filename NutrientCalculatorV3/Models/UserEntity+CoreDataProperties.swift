//
//  UserEntity+CoreDataProperties.swift
//  NutrientCalculatorV3
//
//  Created by Kyle Blandford on 7/19/22.
//
//

import Foundation
import CoreData


extension UserEntity {

    @nonobjc public class func fetchRequest() -> NSFetchRequest<UserEntity> {
        return NSFetchRequest<UserEntity>(entityName: "UserEntity")
    }
    
    @NSManaged public var startDate: Date?
    
    @NSManaged public var checkIns: NSOrderedSet?
    @NSManaged public var weighIns: NSOrderedSet?
    
    @NSManaged public var heightInFeetAndInches: Bool
    @NSManaged public var heightCm: Int64
    @NSManaged public var heightIn: Int64
    @NSManaged public var height: Int64
    
    @NSManaged public var weightInPounds: Bool
    @NSManaged public var inputWeightKgs: String?
    @NSManaged public var inputWeightLbs: String?
    @NSManaged public var startingWeight: Double
    @NSManaged public var currentWeight: Double
    
    @NSManaged public var age: Int64
    @NSManaged public var birthday: Date?
    
    @NSManaged public var sex: String?
    
    @NSManaged public var stepsPerDay: String?
    @NSManaged public var trainingSessionsPerWeek: String?
    @NSManaged public var totalIntensityScore: Int64
    @NSManaged public var activityLevel: String?
    
    @NSManaged public var goalType: String?
    @NSManaged public var inputGoalWeightKgs: String?
    @NSManaged public var inputGoalWeightLbs: String?
    @NSManaged public var goalWeight: Double
    
    @NSManaged public var inputFats: String?
    @NSManaged public var inputCarbs: String?
    @NSManaged public var inputProtein: String?
    @NSManaged public var inputCalories: String?
    @NSManaged public var inputWeightChange: Double
    @NSManaged public var weeklyInputWeightChange: Double
    
    @NSManaged public var dynamicCalories: Bool
    @NSManaged public var dynamicCalorieVariance: Double
    @NSManaged public var dynamicCalorieVarianceDescription: String?
    
    @NSManaged public var monday: Bool
    @NSManaged public var tuesday: Bool
    @NSManaged public var wednesday: Bool
    @NSManaged public var thursday: Bool
    @NSManaged public var friday: Bool
    @NSManaged public var saturday: Bool
    @NSManaged public var sunday: Bool
    
    @NSManaged public var maleBMR: Double
    @NSManaged public var femaleBMR: Double
    @NSManaged public var activityMultiplier: Double
    @NSManaged public var inputCalorieMultiplier: Double
    @NSManaged public var maintenanceCalories: Double
    @NSManaged public var startingCalories: Double
    
    @NSManaged public var fats: Double
    @NSManaged public var carbs: Double
    @NSManaged public var protein: Double
}

// MARK: Generated accessors for checkIns
extension UserEntity {

    @objc(insertObject:inCheckInsAtIndex:)
    @NSManaged public func insertIntoCheckIns(_ value: CheckIn, at idx: Int)

    @objc(removeObjectFromCheckInsAtIndex:)
    @NSManaged public func removeFromCheckIns(at idx: Int)

    @objc(insertCheckIns:atIndexes:)
    @NSManaged public func insertIntoCheckIns(_ values: [CheckIn], at indexes: NSIndexSet)

    @objc(removeCheckInsAtIndexes:)
    @NSManaged public func removeFromCheckIns(at indexes: NSIndexSet)

    @objc(replaceObjectInCheckInsAtIndex:withObject:)
    @NSManaged public func replaceCheckIns(at idx: Int, with value: CheckIn)

    @objc(replaceCheckInsAtIndexes:withCheckIns:)
    @NSManaged public func replaceCheckIns(at indexes: NSIndexSet, with values: [CheckIn])

    @objc(addCheckInsObject:)
    @NSManaged public func addToCheckIns(_ value: CheckIn)

    @objc(removeCheckInsObject:)
    @NSManaged public func removeFromCheckIns(_ value: CheckIn)

    @objc(addCheckIns:)
    @NSManaged public func addToCheckIns(_ values: NSOrderedSet)

    @objc(removeCheckIns:)
    @NSManaged public func removeFromCheckIns(_ values: NSOrderedSet)

}

// MARK: Generated accessors for weighIns
extension UserEntity {

    @objc(insertObject:inWeighInsAtIndex:)
    @NSManaged public func insertIntoWeighIns(_ value: WeighIn, at idx: Int)

    @objc(removeObjectFromWeighInsAtIndex:)
    @NSManaged public func removeFromWeighIns(at idx: Int)

    @objc(insertWeighIns:atIndexes:)
    @NSManaged public func insertIntoWeighIns(_ values: [WeighIn], at indexes: NSIndexSet)

    @objc(removeWeighInsAtIndexes:)
    @NSManaged public func removeFromWeighIns(at indexes: NSIndexSet)

    @objc(replaceObjectInWeighInsAtIndex:withObject:)
    @NSManaged public func replaceWeighIns(at idx: Int, with value: WeighIn)

    @objc(replaceWeighInsAtIndexes:withWeighIns:)
    @NSManaged public func replaceWeighIns(at indexes: NSIndexSet, with values: [WeighIn])

    @objc(addWeighInsObject:)
    @NSManaged public func addToWeighIns(_ value: WeighIn)

    @objc(removeWeighInsObject:)
    @NSManaged public func removeFromWeighIns(_ value: WeighIn)

    @objc(addWeighIns:)
    @NSManaged public func addToWeighIns(_ values: NSOrderedSet)

    @objc(removeWeighIns:)
    @NSManaged public func removeFromWeighIns(_ values: NSOrderedSet)

}

extension UserEntity : Identifiable {

}
