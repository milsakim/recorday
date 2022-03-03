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
            cell.idLabel.text = self.dailyRecords[indexPath.row].id?.uuidString ?? "No ID"
            cell.moodLabel.text = self.dailyRecords[indexPath.row].mood
            cell.activitiesLabel.text = self.dailyRecords[indexPath.row].activities?.compactMap({ $0 as? Activity }).reduce(into: "", { $0 += "\($1.title ?? "No tag") "})
            cell.weatherLabel.text = self.dailyRecords[indexPath.row].weather
            return cell
        }
        
        return UITableViewCell(style: .default, reuseIdentifier: nil)
    }
    
}
