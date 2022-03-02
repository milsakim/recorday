//
//  RecordListViewController.swift
//  Recorday
//
//  Created by HyeJee Kim on 2022/03/01.
//

import UIKit

class RecordListViewController: UIViewController {

    override func viewDidLoad() {
        super.viewDidLoad()

        // Do any additional setup after loading the view.
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
