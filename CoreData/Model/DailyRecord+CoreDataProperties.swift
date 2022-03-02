//
//  DailyRecord+CoreDataProperties.swift
//  Recorday
//
//  Created by HyeJee Kim on 2022/03/02.
//
//

import Foundation
import CoreData


extension DailyRecord {

    @nonobjc public class func fetchRequest() -> NSFetchRequest<DailyRecord> {
        return NSFetchRequest<DailyRecord>(entityName: "DailyRecord")
    }

    @NSManaged public var id: UUID?
    @NSManaged public var timeStamp: Double
    @NSManaged public var mood: String?
    @NSManaged public var weather: String?
    @NSManaged public var activities: NSSet?

}

// MARK: Generated accessors for activities
extension DailyRecord {

    @objc(addActivitiesObject:)
    @NSManaged public func addToActivities(_ value: Activity)

    @objc(removeActivitiesObject:)
    @NSManaged public func removeFromActivities(_ value: Activity)

    @objc(addActivities:)
    @NSManaged public func addToActivities(_ values: NSSet)

    @objc(removeActivities:)
    @NSManaged public func removeFromActivities(_ values: NSSet)

}

extension DailyRecord : Identifiable {

}
