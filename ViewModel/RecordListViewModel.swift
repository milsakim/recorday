//
//  RecordListViewModel.swift
//  Recorday
//
//  Created by HyeeJee Kim on 2022/05/19.
//

import UIKit
import CoreData

protocol RecordListViewModeleDelegate: AnyObject {
    func didUpdateData()
}

class RecordListViewModel {
    
    // MARK: - Property
    
    var tagTitles: [String] = [] {
        didSet {
            fetchChanges()
        }
    }
    var days: [Day] = []
    var dailyRecords: [Double: [DailyRecord]] = [:]
    var context: NSManagedObjectContext {
        AppDelegate.sharedAppDelegate.coreDataManager.managedContext
    }
    
    weak var delegate: RecordListViewModeleDelegate?
    
    // MARK: - Initialization
    
    init() {
        NotificationCenter.default.addObserver(self, selector: #selector(persistentStoreRemoteChange), name: .NSPersistentStoreRemoteChange, object: AppDelegate.sharedAppDelegate.coreDataManager.persistentContainer.persistentStoreCoordinator)
        NotificationCenter.default.addObserver(self, selector: #selector(mainContextDidSave), name: .NSManagedObjectContextDidSave, object: context)
    }
    
    @objc func persistentStoreRemoteChange(_ notification: NSNotification) {
        DispatchQueue.main.async {
            self.fetchChanges()
        }
    }
    
    @objc func mainContextDidSave(_ notification: NSNotification) {
        DispatchQueue.main.async {
            self.fetchChanges()
        }
    }
    
    func fetchChanges() {
        if tagTitles.isEmpty {
            let fetchRequest: NSFetchRequest<Day> = Day.fetchRequest()
            fetchRequest.sortDescriptors = [NSSortDescriptor(keyPath: \Day.timestamp, ascending: false)]
            fetchRequest.predicate = NSPredicate(format: "dailyRecords.@count > 0")
            
            do {
                self.days = try context.fetch(fetchRequest)
                
                for day in days {
                    if let records: [DailyRecord] = day.dailyRecords?.sortedArray(using: [NSSortDescriptor(keyPath: \DailyRecord.timestamp, ascending: false)]) as? [DailyRecord] {
                        dailyRecords[day.timestamp] = records
                    }
                }
            }
            catch {
                print("Failed to fetch \"Day\" data")
            }
        }
        else {
            let fetchRequest: NSFetchRequest<Tag> = Tag.fetchRequest()
            fetchRequest.predicate = NSPredicate(format: "title IN %@", tagTitles)

            do {
                let tags: [Tag] = try context.fetch(fetchRequest)
                
                var daySet: Set<Day> = []
                var tempDailyRecord: [Double: Set<DailyRecord>] = [:]
                
                for tag in tags {
                    if let relatedDailyRecords: [DailyRecord] = tag.dailyRecords?.allObjects as? [DailyRecord] {
                        relatedDailyRecords.forEach({ dailyRecord in
                            if let day: Day = dailyRecord.day {
                                daySet.insert(day)
                                tempDailyRecord[day.timestamp, default: []].insert(dailyRecord)
                            }
                        })
                    }
                }
                
                self.days = daySet.sorted(by: { $0.timestamp > $1.timestamp })
                print("--- days: \(days.map({ $0.timestamp })) ---")
                self.dailyRecords.removeAll()
                for day in days {
                    if let temp = tempDailyRecord[day.timestamp]?.sorted(by: { $0.timestamp > $1.timestamp }) {
                        print("--- day \(day.timestamp): \(temp.count) ---")
                        self.dailyRecords[day.timestamp] = temp
                    }
                }
            }
            catch {
                print("Failed to fetch \"Day\" data")
            }
        }
        
        self.delegate?.didUpdateData()
    }
    
}
