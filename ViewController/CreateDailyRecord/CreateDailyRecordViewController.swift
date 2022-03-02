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
        print(#function)
        
        guard let appDelegate: AppDelegate = UIApplication.shared.delegate as? AppDelegate else {
            print("Fail to reference app delegate")
            return
        }
        
        print("Success to reference app delegate")
        
        // Create daily record
        if let dailyRecordEntity: NSEntityDescription = NSEntityDescription.entity(forEntityName: "DailyRecord", in: appDelegate.persistentContainer.viewContext),
           let activityEntity: NSEntityDescription = NSEntityDescription.entity(forEntityName: "Activity", in: appDelegate.persistentContainer.viewContext) {
            let activity: NSManagedObject = NSManagedObject(entity: activityEntity, insertInto: appDelegate.persistentContainer.viewContext)
            activity.setValue(activitiesTextField.text, forKey: "title")
            activity.setValue(UUID(), forKey: "id")
            
            let dailyRecord: NSManagedObject = NSManagedObject(entity: dailyRecordEntity, insertInto: appDelegate.persistentContainer.viewContext)
            dailyRecord.setValue(UUID(), forKey: "id")
            dailyRecord.setValue(Date().timeIntervalSince1970, forKey: "timeStamp")
            dailyRecord.setValue(moodTextField.text, forKey: "mood")
            dailyRecord.setValue(weatherTextField.text, forKey: "weather")
            
            
            dailyRecord.setValue(NSSet(object: activity), forKey: "activities")
            activity.setValue(NSSet(object: dailyRecord), forKey: "dailyRecords")
        }
        
        do {
            try appDelegate.persistentContainer.viewContext.save()
        } catch {
            print("Fail to save: \(error)")
        }
    }
    
    func createTestData() {
        print(#function)
        
        guard let appDelegate: AppDelegate = UIApplication.shared.delegate as? AppDelegate else {
            print("Fail to reference app delegate")
            return
        }
        
        print("Success to reference app delegate")
        
        if let dailyRecordEntity: NSEntityDescription = NSEntityDescription.entity(forEntityName: "DailyRecord", in: appDelegate.persistentContainer.viewContext),
           let activityEntity: NSEntityDescription = NSEntityDescription.entity(forEntityName: "Activity", in: appDelegate.persistentContainer.viewContext) {
            let earlySleep: NSManagedObject = NSManagedObject(entity: activityEntity, insertInto: appDelegate.persistentContainer.viewContext)
            earlySleep.setValue("Early Sleep", forKey: "title")
            earlySleep.setValue(UUID(), forKey: "id")
            let drinkCoffee: NSManagedObject = NSManagedObject(entity: activityEntity, insertInto: appDelegate.persistentContainer.viewContext)
            drinkCoffee.setValue("Drink Coffee", forKey: "title")
            drinkCoffee.setValue(UUID(), forKey: "id")
            
            let dailyRecord: NSManagedObject = NSManagedObject(entity: dailyRecordEntity, insertInto: appDelegate.persistentContainer.viewContext)
            dailyRecord.setValue(UUID(), forKey: "id")
            dailyRecord.setValue(Date().timeIntervalSince1970, forKey: "timeStamp")
            dailyRecord.setValue("joyful", forKey: "mood")
            dailyRecord.setValue("sunny", forKey: "weather")
            
            
            dailyRecord.setValue(NSSet(array: [earlySleep, drinkCoffee]), forKey: "activities")
            earlySleep.setValue(NSSet(object: dailyRecord), forKey: "dailyRecords")
            drinkCoffee.setValue(NSSet(object: dailyRecord), forKey: "dailyRecords")
        }
        
        do {
            try appDelegate.persistentContainer.viewContext.save()
        } catch {
            print("Fail to save: \(error)")
        }
    }

}
