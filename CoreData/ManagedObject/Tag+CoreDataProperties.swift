//
//  Tag+CoreDataProperties.swift
//  Recorday
//
//  Created by HyeeJee Kim on 2022/04/27.
//
//

import Foundation
import CoreData


extension Tag {

    @nonobjc public class func fetchRequest() -> NSFetchRequest<Tag> {
        return NSFetchRequest<Tag>(entityName: "Tag")
    }

    @NSManaged public var id: UUID?
    @NSManaged public var title: String?
    @NSManaged public var dailyRecords: NSSet?

}

// MARK: Generated accessors for dailyRecords
extension Tag {

    @objc(addDailyRecordsObject:)
    @NSManaged public func addToDailyRecords(_ value: DailyRecord)

    @objc(removeDailyRecordsObject:)
    @NSManaged public func removeFromDailyRecords(_ value: DailyRecord)

    @objc(addDailyRecords:)
    @NSManaged public func addToDailyRecords(_ values: NSSet)

    @objc(removeDailyRecords:)
    @NSManaged public func removeFromDailyRecords(_ values: NSSet)

}

extension Tag : Identifiable {

}
