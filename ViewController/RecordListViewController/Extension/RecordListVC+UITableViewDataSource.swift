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
//        return days.count
        return viewModel?.days.count ?? 0
    }
    
    func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        guard let timestamp: Double = self.viewModel?.days[section].timestamp else {
            return 0
        }
        
        return viewModel?.dailyRecords[timestamp]?.count ?? 0
    }
    
    func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        guard let cell: DailyRecordCell = tableView.dequeueReusableCell(withIdentifier: DailyRecordCell.reuseID, for: indexPath) as? DailyRecordCell else {
            return UITableViewCell(style: .default, reuseIdentifier: nil)
        }
        
        let dayID: Double = viewModel?.days[indexPath.section].timestamp ?? 0
        
        guard let dailyRecords: [DailyRecord] = viewModel?.dailyRecords[dayID], indexPath.row < dailyRecords.count else {
            fatalError("")
        }
        
        cell.setMood(of: dailyRecords[indexPath.row].mood)
        
        // set up date & time
        let timeStamp: TimeInterval = dayID + dailyRecords[indexPath.row].timestamp
        cell.timeLabel.text = self.dateFormatter.string(from: Date(timeIntervalSince1970: timeStamp))
        
        // set up note
        if let note: String = dailyRecords[indexPath.row].note {
            cell.setNote(note)
        }
        
        return cell
    }

}
