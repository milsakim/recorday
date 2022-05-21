//
//  OnBoardingViewController.swift
//  Recorday
//
//  Created by HyeeJee Kim on 2022/05/16.
//

import UIKit
import CloudKit

class OnBoardingViewController: UIViewController {
    
    // MARK: - Property
    
    static let reuseID: String = "OnBoardingViewController"
    
    // MARK: - Outlet
    
    @IBOutlet weak var toggleSwitch: UISwitch!
    
    // MARK: - View Life Cycle
    
    override func viewDidLoad() {
        super.viewDidLoad()
    }

    @IBAction func buttonTapped(_ sender: Any) {
        defer {
            UserDefaults.standard.set(true, forKey: UserDefaultsKey.isLaunchedBefore)
        }
        
        guard let window: UIWindow = self.view.window else {
            return
        }
        
        if self.toggleSwitch.isOn {
            let storyboard: UIStoryboard = UIStoryboard(name: "RecordListViewController", bundle: .main)
            
            if let recordListVC: RecordListViewController = storyboard.instantiateViewController(withIdentifier: RecordListViewController.storyboardID) as? RecordListViewController {
                window.rootViewController = UINavigationController(rootViewController: recordListVC)
            }
        }
        else {
            let storyboard: UIStoryboard = UIStoryboard(name: "RecordListViewController", bundle: .main)
            
            if let recordListVC: RecordListViewController = storyboard.instantiateViewController(withIdentifier: RecordListViewController.storyboardID) as? RecordListViewController {
                window.rootViewController = UINavigationController(rootViewController: recordListVC)
            }
        }
    }
    
    func checkUserSignedInToiCloud() {
        CKContainer.default().accountStatus { (accountStatus, error) in
            switch accountStatus {
            case .available:
//                return true
                print("")
            default:
//                return false
                print("")
            }
        }
    }
    
}
