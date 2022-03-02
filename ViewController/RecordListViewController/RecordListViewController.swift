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
    
    var persistentContainer: NSPersistentContainer?
    
    // MARK: - Deinit
    
    deinit {
        if persistentContainer != nil {
            persistentContainer = nil
        }
    }

    override func viewDidLoad() {
        super.viewDidLoad()
        print(#function)
        if persistentContainer != nil {
            print("persistentContainer is not nil")
        }
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
