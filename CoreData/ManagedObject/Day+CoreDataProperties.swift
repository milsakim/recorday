//
//  Day+CoreDataProperties.swift
//  Recorday
//
//  Created by HyeeJee Kim on 2022/05/04.
//
//

import Foundation
import CoreData


extension Day {

    @nonobjc public class func fetchRequest() -> NSFetchRequest<Day> {
        return NSFetchRequest<Day>(entityName: "Day")
    }

    @NSManaged public var timestamp: Double
    @NSManaged public var weatherID: String?
    @NSManaged public var weatherIconID: String?
    @NSManaged public var dailyRecords: NSSet?

}

// MARK: Generated accessors for dailyRecords
extension Day {

    @objc(addDailyRecordsObject:)
    @NSManaged public func addToDailyRecords(_ value: DailyRecord)

    @objc(removeDailyRecordsObject:)
    @NSManaged public func removeFromDailyRecords(_ value: DailyRecord)

    @objc(addDailyRecords:)
    @NSManaged public func addToDailyRecords(_ values: NSSet)

    @objc(removeDailyRecords:)
    @NSManaged public func removeFromDailyRecords(_ values: NSSet)

}

extension Day : Identifiable {

}
