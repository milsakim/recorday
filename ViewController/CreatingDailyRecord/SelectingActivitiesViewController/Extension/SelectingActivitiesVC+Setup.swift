//
//  SelectingActivitiesVC+Setup.swift
//  Recorday
//
//  Created by HyeJee Kim on 2022/03/07.
//

import UIKit

extension SelectingActivitiesViewController {
    
    func setupNavigation() {
        guard self.navigationController != nil else {
            return
        }
        
        let cancelButton: UIBarButtonItem = UIBarButtonItem(title: "Cancel", style: .plain, target: self, action: #selector(cancelAction))
        navigationItem.setRightBarButton(cancelButton, animated: false)
        
        if let dailyRecord = dailyRecord, let moodID = dailyRecord.mood {
            let moods: [Mood] = Mood.moods.filter({ $0.id == moodID })
            
            if !moods.isEmpty {
                navigationItem.title = moods[0].emoji
//                navigationController?.navigationBar.tintColor = moods[0].color
//                navigationController?.navigationBar.barTintColor = moods[0].color
            }
        }
        
        navigationItem.largeTitleDisplayMode = .never
        
    }
    
    func setupTableView() {
        tableView.dataSource = self
        tableView.rowHeight = UITableView.automaticDimension
        tableView.estimatedRowHeight = 100
        tableView.register(UINib(nibName: "ActivityInputTableViewCell", bundle: nil), forCellReuseIdentifier: ActivityInputTableViewCell.reuseID)
    }
    
}
