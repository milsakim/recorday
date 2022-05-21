//
//  DailyRecord+CoreDataProperties.swift
//  Recorday
//
//  Created by HyeeJee Kim on 2022/04/27.
//
//

import Foundation
import CoreData


extension DailyRecord {

    @nonobjc public class func fetchRequest() -> NSFetchRequest<DailyRecord> {
        return NSFetchRequest<DailyRecord>(entityName: "DailyRecord")
    }

    @NSManaged public var id: UUID
    @NSManaged public var mood: String?
    @NSManaged public var note: String?
    @NSManaged public var timestamp: Double
    @NSManaged public var tags: NSSet?
    @NSManaged public var day: Day?

}

// MARK: Generated accessors for tags
extension DailyRecord {

    @objc(addTagsObject:)
    @NSManaged public func addToTags(_ value: Tag)

    @objc(removeTagsObject:)
    @NSManaged public func removeFromTags(_ value: Tag)

    @objc(addTags:)
    @NSManaged public func addToTags(_ values: NSSet)

    @objc(removeTags:)
    @NSManaged public func removeFromTags(_ values: NSSet)

}

extension DailyRecord : Identifiable {

}
