//
//  SelectingActiviesVC+Action.swift
//  Recorday
//
//  Created by HyeJee Kim on 2022/03/07.
//

import UIKit
import CoreData

extension SelectingActivitiesViewController {
    
    @objc func cancelAction() {
        print("--- \(#function) ---")
        
        if AppDelegate.sharedAppDelegate.coreDataManager.managedContext.hasChanges {
            print("--- has changes ---")
            AppDelegate.sharedAppDelegate.coreDataManager.managedContext.rollback()
        }
        
        self.dismiss(animated: true, completion: nil)
    }
    
    @IBAction func saveButtonTapped(_ sender: Any) {
        print("--- \(#function) ---")
        
//        self.dailyRecord?.timeStamp = Date().timeIntervalSince1970
        
        let currentDate: Date = Date()
        let dateFormatter: DateFormatter = DateFormatter()
        dateFormatter.dateFormat = "yyyy-MM-dd"
        let dateString: String = dateFormatter.string(from: currentDate)
        
        if let dateTimeStamp: TimeInterval = dateFormatter.date(from: dateString)?.timeIntervalSince1970 {
            self.dailyRecord?.date = dateTimeStamp
            self.dailyRecord?.time = currentDate.timeIntervalSince1970 - dateTimeStamp
        }
        
        if let activityInputCell: ActivityInputTableViewCell = tableView.cellForRow(at: IndexPath(row: 0, section: 0)) as? ActivityInputTableViewCell {
            let activityTitles: [String] = activityInputCell.activityInputTextView.text.split(separator: " ").map({ String($0) })
            
            for activityTitle in activityTitles {
                let fetchRequest: NSFetchRequest<Activity> = Activity.fetchRequest()
                fetchRequest.predicate = NSPredicate(format: "title == %@", activityTitle)
                
                do {
                    let fetchedActivities: [Activity] = try AppDelegate.sharedAppDelegate.coreDataManager.managedContext.fetch(fetchRequest)
                    
                    if fetchedActivities.isEmpty {
                        if let dailyRecord = self.dailyRecord,
                           let entity: NSEntityDescription = NSEntityDescription.entity(forEntityName: "Activity", in: AppDelegate.sharedAppDelegate.coreDataManager.managedContext) {
                            let activity: Activity = Activity(entity: entity, insertInto: AppDelegate.sharedAppDelegate.coreDataManager.managedContext)
                            activity.id = UUID()
                            activity.title = activityTitle
                            activity.addToDailyRecords(dailyRecord)
                            dailyRecord.addToActivities(activity)
                        }
                    }
                    else {
                        if let dailyRecord = self.dailyRecord {
                            fetchedActivities[0].addToDailyRecords(dailyRecord)
                            dailyRecord.addToActivities(fetchedActivities[0])
                        }
                    }
                }
                catch {
                    print("--- Fetch Failed: \(error) ---")
                }
            }
        }
        
        // save context
        do {
            try AppDelegate.sharedAppDelegate.coreDataManager.managedContext.save()
            self.dismiss(animated: true, completion: nil)
        }
        catch {
            print("### Failed to save context: \(error) ###")
        }
    }
    
}
