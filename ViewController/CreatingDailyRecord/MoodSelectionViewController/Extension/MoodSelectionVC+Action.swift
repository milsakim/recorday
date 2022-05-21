//
//  MoodSelectionVC+Action.swift
//  Recorday
//
//  Created by HyeJee Kim on 2022/03/07.
//

import UIKit
import CoreData

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
        
        if let selectingActivitiesViewController: NoteViewController = storyboard.instantiateViewController(withIdentifier: "SelectingActivitiesViewController") as? NoteViewController {
            selectingActivitiesViewController.dailyRecordMetadata = dailyRecordMetadata
            navigationController.pushViewController(selectingActivitiesViewController, animated: true)
        }
    }
    
    @IBAction func datePickerValueChanged(_ sender: Any) {
        print("--- \(#function) ---")
        
        guard let datePicker: UIDatePicker = sender as? UIDatePicker, let parsedDate: (date: TimeInterval, time: TimeInterval) = parseDate(from: datePicker.date) else {
            return
        }
        
        dailyRecordMetadata?.dateTimestamp = parsedDate.date
        dailyRecordMetadata?.timeTimestamp = parsedDate.time
    }
    
    func parseDate(from date: Date) -> (TimeInterval, TimeInterval)? {
        let dateFormatter: DateFormatter = DateFormatter()
        dateFormatter.dateFormat = "yyyy-MM-dd"
        
        guard let parsedDate: Date = dateFormatter.date(from: dateFormatter.string(from: date)) else {
            return nil
        }
        
        return (parsedDate.timeIntervalSince1970, date.timeIntervalSince1970 - parsedDate.timeIntervalSince1970)
    }
    
}
