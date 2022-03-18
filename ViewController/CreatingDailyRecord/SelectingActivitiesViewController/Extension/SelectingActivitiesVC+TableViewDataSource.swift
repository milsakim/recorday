//
//  SelectingActivitiesVC+TableViewDataSource.swift
//  Recorday
//
//  Created by HyeJee Kim on 2022/03/07.
//

import UIKit

extension SelectingActivitiesViewController: UITableViewDataSource {
    
    func numberOfSections(in tableView: UITableView) -> Int {
        return 1
    }
    
    func tableView(_ tableView: UITableView, titleForHeaderInSection section: Int) -> String? {
        return self.sectionTitles[section]
    }
    
    func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        return 1
    }
    
    func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        switch indexPath.section {
        case 0:
            let cell: ActivityInputTableViewCell = tableView.dequeueReusableCell(withIdentifier: ActivityInputTableViewCell.reuseID, for: indexPath) as! ActivityInputTableViewCell
            cell.delegate = self
            return cell
        case 1:
            return tableView.dequeueReusableCell(withIdentifier: "NoteCell", for: indexPath)
        default:
            return UITableViewCell()
        }
    }

}
