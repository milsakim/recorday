//
//  RecordListVC+UITableViewDataSource.swift
//  Recorday
//
//  Created by HyeJee Kim on 2022/03/03.
//

import UIKit

extension RecordListViewController: UITableViewDataSource {
    
    func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        print(#function)
        return self.dailyRecords.count
    }
    
    func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        print(#function)
        if let cell: DailyRecordTableViewCell = tableView.dequeueReusableCell(withIdentifier: "DailyRecordTableViewCell", for: indexPath) as? DailyRecordTableViewCell {
            cell.moodLabel.text = self.dailyRecords[indexPath.row].mood
            
            let date: Date = Date(timeIntervalSince1970: self.dailyRecords[indexPath.row].timeStamp)
            let dateFormatter: DateFormatter = DateFormatter()
            dateFormatter.dateFormat = "yyyy-MM-dd 'at' HH:mm"
            cell.timeLabel.text = dateFormatter.string(from: date)
           
            return cell
        }
        
        return UITableViewCell(style: .default, reuseIdentifier: nil)
    }
    
}
