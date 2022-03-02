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
    }
    
    @IBAction func createDailyRecord(_ sender: Any) {
        print(#function)
        
        let storyboard: UIStoryboard = UIStoryboard(name: "CreateDailyRecordViewController", bundle: .main)
        
        if let createDailyRecordVC: CreateDailyRecordViewController = storyboard.instantiateViewController(withIdentifier: "CreateDailyRecordViewController") as? CreateDailyRecordViewController {
//            createDailyRecordVC.modalPresentationStyle = .fullScreen
            self.present(createDailyRecordVC, animated: true, completion: nil)
        }
        else {
            print("fail")
        }
    }
    
}
