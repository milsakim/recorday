//
//  EditingDailyRecordViewController.swift
//  Recorday
//
//  Created by HyeeJee Kim on 2022/04/19.
//

import UIKit

class EditingDailyRecordViewController: UIViewController {
    
    // MARK: - Property
    
    var dailyRecord: DailyRecord?

    override func viewDidLoad() {
        super.viewDidLoad()

        // Do any additional setup after loading the view.
        
        if let dailyRecord = dailyRecord {
            print(dailyRecord)
        }
        else {
            print("nil")
        }
    }
    

    /*
    // MARK: - Navigation

    // In a storyboard-based application, you will often want to do a little preparation before navigation
    override func prepare(for segue: UIStoryboardSegue, sender: Any?) {
        // Get the new view controller using segue.destination.
        // Pass the selected object to the new view controller.
    }
    */

}
