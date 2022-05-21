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
        navigationItem.leftBarButtonItem?.tintColor = UIColor(named: "accent-color")
        
        navigationItem.backButtonTitle = ""
    }
    
    func setupCollectionView() {
        moodCollectionView.dataSource = self
        moodCollectionView.delegate = self
        moodCollectionView.register(UINib(nibName: "MoodCollectionViewCell", bundle: nil), forCellWithReuseIdentifier: MoodCollectionViewCell.reuseID)
    }
    
    func setupDatePicker() {
        datePicker.maximumDate = Date()
    }
    
    func setupDailyRecordMetadata() {
        guard let (currentDate, currentTime) = parseDate(from: Date()) else {
            return
        }
        
        dailyRecordMetadata = DailyRecordMetadata(moodID: Mood.moods[5].id, dateTimestamp: currentDate, timeTimestamp: currentTime)
    }
    
}
