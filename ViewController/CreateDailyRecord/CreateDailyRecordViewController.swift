//
//  CreateDailyRecordViewController.swift
//  Recorday
//
//  Created by HyeJee Kim on 2022/03/02.
//

import UIKit
import CoreData

class CreateDailyRecordViewController: UIViewController {
    
    // MARK: - Outlet
    
    @IBOutlet weak var moodTextField: UITextField!
    @IBOutlet weak var activitiesTextField: UITextField!
    @IBOutlet weak var weatherTextField: UITextField!
    
    // MARK: - Property
    
    var persistentContainer: NSPersistentContainer?
    
    // MARK: - Deinit
    
    deinit {
        if persistentContainer != nil {
            persistentContainer = nil
        }
    }

    override func viewDidLoad() {
        super.viewDidLoad()
//        createTestData()
    }
    
    @IBAction func addButtonTapped(_ sender: Any) {
        print("--- \(#function) ---")
        
        let dailyRecord: DailyRecord = DailyRecord(context: AppDelegate.sharedAppDelegate.coreDataManager.managedContext)
        dailyRecord.id = UUID()
        dailyRecord.timeStamp = Date().timeIntervalSince1970
        dailyRecord.mood = moodTextField.text
        dailyRecord.weather = weatherTextField.text
        dailyRecord.note = "This is sample note for \(dailyRecord.id?.uuidString ?? "No ID")"
        
        if let activityStrings: [String] = activitiesTextField.text?.split(separator: " ").map({ String($0) }) {
            for activityString in activityStrings {
                let activityFetchRequest: NSFetchRequest<Activity> = Activity.fetchRequest()
                activityFetchRequest.predicate = NSPredicate(format: "title == %@", activityString)
                
                do {
                    let fetchResult: [Activity] = try AppDelegate.sharedAppDelegate.coreDataManager.managedContext.fetch(activityFetchRequest)
                    if fetchResult.isEmpty {
                        let activity: Activity = Activity(context: AppDelegate.sharedAppDelegate.coreDataManager.managedContext)
                        activity.id = UUID()
                        activity.title = activityString
                        
                        dailyRecord.addToActivities(activity)
                        activity.addToDailyRecords(dailyRecord)
                    }
                    else {
                        dailyRecord.addToActivities(fetchResult[0])
                        fetchResult[0].addToDailyRecords(dailyRecord)
                    }
                }
                catch {
                    print("--- Fetch error: \(error) ---")
                }
            }
        }
        
        do {
            try AppDelegate.sharedAppDelegate.coreDataManager.managedContext.save()
            
            if let tabBarController = self.presentingViewController as? UITabBarController, let presentingViewController = tabBarController.viewControllers?[0] as? RecordListViewController {
                presentingViewController.dismiss(animated: true, completion: { presentingViewController.fetchChanges() })
            }
        }
        catch {
            print("--- Failed to save contest: \(error) ---")
        }
    }

    @IBAction func cancelButtonTapped(_ sender: Any) {
        guard let navigationController = self.navigationController else {
            return
        }
        
        if let presentingViewController = navigationController.presentingViewController {
            presentingViewController.dismiss(animated: true, completion: nil)
        }
    }
    
}
