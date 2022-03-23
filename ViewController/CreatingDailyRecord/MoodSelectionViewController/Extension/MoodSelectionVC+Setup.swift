//
//  MoodSelectionVC+Setup.swift
//  Recorday
//
//  Created by HyeJee Kim on 2022/03/07.
//

import UIKit
import CoreData

// MARK: - Set Up

extension MoodSelectionViewController {
    
    func setupNaviation() {
        guard navigationController != nil else {
            return
        }
        
        // large title
        navigationController?.navigationBar.prefersLargeTitles = true
        navigationItem.largeTitleDisplayMode = .always
        navigationItem.title = "How are you?"
        
        // left bar button item
        navigationItem.leftBarButtonItem = UIBarButtonItem(image: UIImage(named: "cancel-button"), style: .plain, target: self, action: #selector(cancelButtonTapped))
        navigationItem.leftBarButtonItem?.tintColor = .red
        
        navigationItem.backButtonTitle = ""
    }
    
    func setupCollectionView() {
        moodCollectionView.dataSource = self
        moodCollectionView.delegate = self
        moodCollectionView.register(UINib(nibName: "MoodCollectionViewCell", bundle: nil), forCellWithReuseIdentifier: MoodCollectionViewCell.resueID)
    }
    
    func setupDatePicker() {
        datePicker.maximumDate = Date()
    }

    func createDailyRecord() {
        if self.dailyRecord == nil {
            if let entity: NSEntityDescription = NSEntityDescription.entity(forEntityName: "DailyRecord", in: AppDelegate.sharedAppDelegate.coreDataManager.managedContext) {
                self.dailyRecord = DailyRecord(entity: entity, insertInto: AppDelegate.sharedAppDelegate.coreDataManager.managedContext)
                self.dailyRecord?.id = UUID()
            }
        }
    }
    
}
