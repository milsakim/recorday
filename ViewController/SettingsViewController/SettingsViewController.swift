//
//  SettingsViewController.swift
//  Recorday
//
//  Created by HyeeJee Kim on 2022/04/26.
//

import UIKit

class SettingsViewController: UIViewController {
    
    // MARK: - Initialization
    
    required init?(coder: NSCoder) {
        super.init(coder: coder)
        self.tabBarItem = UITabBarItem(title: "Settings", image: UIImage(systemName: "doc.on.doc"), selectedImage: UIImage(systemName: "doc.on.doc"))
    }
    
    override func viewDidLoad() {
        super.viewDidLoad()
    }
    
    @IBAction func iCloudSyncToggled(_ sender: Any) {
        guard let toggleSwitch: UISwitch = sender as? UISwitch else {
            return
        }
        
        NSUbiquitousKeyValueStore.default.set(toggleSwitch.isOn, forKey: UserDefaultsKey.isICloudSyncEnabled)
        
        let appDelegate = UIApplication.shared.delegate as! AppDelegate
        appDelegate.coreDataManager.setUpContainer(with: toggleSwitch.isOn)
    }
    
}
