//
//  RecordListViewController.swift
//  Recorday
//
//  Created by HyeJee Kim on 2022/03/01.
//

import UIKit
import CoreData

class RecordListViewController: UIViewController {
    
    // MARK: - Property
    
    var dailyRecords: [DailyRecord] = []
    
    // MARK: - Outlet
    
    @IBOutlet weak var tableView: UITableView!
    
    // MARK: - Deinit
    
    deinit {
        if !dailyRecords.isEmpty {
            dailyRecords.removeAll()
        }
        print(#function)
    }
    
    // MARK: - View Life Cycle
    
    override func viewDidLoad() {
        super.viewDidLoad()
        print(#function)
        self.generalSetUp()
    }
    
    // MARK: - Set Up RecordListViewController
    
    func generalSetUp() {
        self.setUpTableView()
        
        if let fetchResult = AppDelegate.sharedAppDelegate.coreDataManager.fetchDailyRecords() {
            self.dailyRecords = fetchResult
        }

        NotificationCenter.default.addObserver(self, selector: #selector(fetchChanges), name: .NSPersistentStoreRemoteChange, object: AppDelegate.sharedAppDelegate.coreDataManager.persistentContainer.persistentStoreCoordinator)
    }
    
    @IBAction func createDailyRecord(_ sender: Any) {
        print(#function)
        
        let storyboard: UIStoryboard = UIStoryboard(name: "CreatingDailyRecord", bundle: .main)
        
        if let createDailyRecordVC: UINavigationController = storyboard.instantiateViewController(withIdentifier: "CreateDailyRecordNav") as? UINavigationController {
            createDailyRecordVC.modalPresentationStyle = .fullScreen
            self.present(createDailyRecordVC, animated: true, completion: nil)
        }
    }
    
    @IBAction func reloadDataButtonTapped(_ sender: Any) {
        print("--- \(#function) ---")
        
        for dailyRecord in dailyRecords {
            AppDelegate.sharedAppDelegate.coreDataManager.persistentContainer.viewContext.delete(dailyRecord)
        }
        
        do {
            try AppDelegate.sharedAppDelegate.coreDataManager.persistentContainer.viewContext.save()
            dailyRecords = []
            DispatchQueue.main.async {
                self.tableView.reloadData()
            }
        }
        catch {
            print("--- Fail to delete ---")
        }
    }
    
    @objc func fetchChanges() {
        print("--- \(#function) ---")
        DispatchQueue.main.async {
//            let newFetchResult = self.fetchDailyRecords()
            print("--- \(#function): main queue ---")
            if let newFetchResult: [DailyRecord] = AppDelegate.sharedAppDelegate.coreDataManager.fetchDailyRecords() {
                self.dailyRecords = newFetchResult
                self.tableView.reloadData()
            }
        }
    }
    
}
