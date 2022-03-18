//
//  RecordListVC+Action.swift
//  Recorday
//
//  Created by HyeJee Kim on 2022/03/07.
//

import UIKit
import CoreData

extension RecordListViewController {
    
    @IBAction func createDailyRecord(_ sender: Any) {
        print(#function)
        
        let storyboard: UIStoryboard = UIStoryboard(name: "CreatingDailyRecord", bundle: .main)
        
        if let createDailyRecordVC: UINavigationController = storyboard.instantiateViewController(withIdentifier: "CreateDailyRecordNav") as? UINavigationController {
            createDailyRecordVC.modalPresentationStyle = .fullScreen
            self.present(createDailyRecordVC, animated: true, completion: nil)
        }
    }
    
    @objc func fetchChanges() {
        print("--- \(#function) ---")
        DispatchQueue.main.async {
            print("--- \(#function): main queue ---")
            self.tableView.reloadData()
        }
    }
    
}
