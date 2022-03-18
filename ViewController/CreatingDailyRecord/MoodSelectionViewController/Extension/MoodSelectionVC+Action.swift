//
//  MoodSelectionVC+Action.swift
//  Recorday
//
//  Created by HyeJee Kim on 2022/03/07.
//

import UIKit

// MARK: - Action

extension MoodSelectionViewController {
    
    @IBAction func cancelButtonTapped(_ sender: Any) {
        if AppDelegate.sharedAppDelegate.coreDataManager.managedContext.hasChanges {
            AppDelegate.sharedAppDelegate.coreDataManager.managedContext.rollback()
        }
        
        dismiss(animated: true, completion: nil)
    }
    
    @IBAction func nextButtonTapped(_ sender: Any) {
        print("--- \(#function) ---")
        
        guard let navigationController: UINavigationController = self.navigationController else {
            return
        }
        
        let storyboard: UIStoryboard = UIStoryboard(name: "CreatingDailyRecord", bundle: nil)
        
        if let selectingActivitiesViewController: SelectingActivitiesViewController = storyboard.instantiateViewController(withIdentifier: "SelectingActivitiesViewController") as? SelectingActivitiesViewController {
            print("--- Daily Record: \(dailyRecord) ---")
            selectingActivitiesViewController.dailyRecord = dailyRecord
            navigationController.pushViewController(selectingActivitiesViewController, animated: true)
        }
    }
    
}
