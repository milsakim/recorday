//
//  Activity+CoreDataProperties.swift
//  Recorday
//
//  Created by HyeJee Kim on 2022/03/03.
//
//

import Foundation
import CoreData


extension Activity {

    @nonobjc public class func fetchRequest() -> NSFetchRequest<Activity> {
        return NSFetchRequest<Activity>(entityName: "Activity")
    }

    @NSManaged public var title: String?
    @NSManaged public var id: UUID?
    @NSManaged public var dailyRecords: NSSet?

}

// MARK: Generated accessors for dailyRecords
extension Activity {

    @objc(addDailyRecordsObject:)
    @NSManaged public func addToDailyRecords(_ value: DailyRecord)

    @objc(removeDailyRecordsObject:)
    @NSManaged public func removeFromDailyRecords(_ value: DailyRecord)

    @objc(addDailyRecords:)
    @NSManaged public func addToDailyRecords(_ values: NSSet)

    @objc(removeDailyRecords:)
    @NSManaged public func removeFromDailyRecords(_ values: NSSet)

}

extension Activity : Identifiable {

}
