//
//  CreateDailyRecordViewController.swift
//  Recorday
//
//  Created by HyeJee Kim on 2022/03/02.
//

import UIKit

class CreateDailyRecordViewController: UIViewController {
    
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
        
    }

}
