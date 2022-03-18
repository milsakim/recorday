//
//  RecordListVC+UITableViewDataSource.swift
//  Recorday
//
//  Created by HyeJee Kim on 2022/03/03.
//

import UIKit
import CoreData

extension RecordListViewController: UITableViewDataSource {
    
    func numberOfSections(in tableView: UITableView) -> Int {
        print("--- \(#function) ---")
        
        guard let fetchController = self.fetchedResultsController else {
            return 0
        }
        
        return fetchController.sections?.count ?? 0
    }
    
    func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        print(#function)
        
        guard let fetchController = self.fetchedResultsController else {
            return 0
        }
        
        return fetchController.sections?[section].numberOfObjects ?? 0
    }
    
    func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        print("--- \(#function): \(indexPath) ---")
        
        guard let fetchController = self.fetchedResultsController,
              let cell: DailyRecordTableViewCell = tableView.dequeueReusableCell(withIdentifier: "DailyRecordTableViewCell", for: indexPath) as? DailyRecordTableViewCell else {
            return UITableViewCell(style: .default, reuseIdentifier: nil)
        }
        
        let dailyRecord: DailyRecord = fetchController.object(at: indexPath)
        
        cell.setMood(of: dailyRecord.mood)
        
        if indexPath.row == 0 {
            cell.setContinuousLines(as: .first)
        }
        else if let sections = fetchController.sections, indexPath.row == sections[indexPath.section].numberOfObjects - 1 {
            cell.setContinuousLines(as: .last)
        }
        
        // set up date & time
        let timeStamp: TimeInterval = fetchController.object(at: indexPath).date + fetchController.object(at: indexPath).time
        cell.timeLabel.text = self.dateFormatter.string(from: Date(timeIntervalSince1970: timeStamp))
        
        cell.activitiesLabelBackgroundView.layer.cornerRadius = 10.0
        
        
        // set up activities
        if let activities = fetchController.object(at: indexPath).activities?.compactMap({ $0 as? Activity }) {
            cell.activityTitles = activities.compactMap({ $0.title }).sorted()
        }
        
        return cell
    }
    
    func tableView(_ tableView: UITableView, titleForHeaderInSection section: Int) -> String? {
        guard let sectionInfo = self.fetchedResultsController?.sections?[section] else {
            return nil
        }
        
        if let timeInterval: TimeInterval = Double(sectionInfo.name) {
            let sectionDate: Date = Date(timeIntervalSince1970: timeInterval)
            let formatter: DateFormatter = DateFormatter()
            formatter.dateFormat = "yyyy/MM/dd"
            return formatter.string(from: sectionDate)
        }
        
        return nil
    }
    
}
