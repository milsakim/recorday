//
//  RecordListVC+UITableViewDelegate.swift
//  Recorday
//
//  Created by HyeeJee Kim on 2022/04/19.
//

import UIKit
import CoreData

extension RecordListViewController: UITableViewDelegate {
    
    func tableView(_ tableView: UITableView, viewForHeaderInSection section: Int) -> UIView? {
        guard let viewModel: RecordListViewModel = self.viewModel,
              let headerView: DailyRecordListHeaderView = tableView.dequeueReusableHeaderFooterView(withIdentifier: DailyRecordListHeaderView.reuseID) as? DailyRecordListHeaderView else {
            return nil
        }
        
        let sectionDate: Date = Date(timeIntervalSince1970: viewModel.days[section].timestamp)
        let formatter: DateFormatter = DateFormatter()
        formatter.dateFormat = "yyyy/MM/dd"
        headerView.dateLabel?.text = formatter.string(from: sectionDate)
        
        if let iconID: String = viewModel.days[section].weatherIconID {
            headerView.weatherImageView?.image = UIImage(named: iconID)
        }
        
        return headerView
    }
    
    func tableView(_ tableView: UITableView, didSelectRowAt indexPath: IndexPath) {
        guard let viewModel: RecordListViewModel = self.viewModel,
              let navigationController: UINavigationController = navigationController else {
            return
        }
        
        // create EditingDailyRecordVC instance
        let storyboard: UIStoryboard = UIStoryboard(name: "EditingDailyRecordViewController", bundle: .main)
        
        guard let editingDailyRecordVC: EditingDailyRecordViewController = storyboard.instantiateViewController(withIdentifier: "EditingDailyRecordViewController") as? EditingDailyRecordViewController else {
            return
        }
        
        // pass reference selected daily record(managed object) to EditingDailyRecordVC instance
        let dayID: Double = viewModel.days[indexPath.section].timestamp
        editingDailyRecordVC.dailyRecord = viewModel.dailyRecords[dayID]?[indexPath.row]
        
        // push to navigation controller stack
        navigationController.pushViewController(editingDailyRecordVC, animated: true)
    }
    
    func tableView(_ tableView: UITableView, trailingSwipeActionsConfigurationForRowAt indexPath: IndexPath) -> UISwipeActionsConfiguration? {
        guard let viewModel: RecordListViewModel = self.viewModel else {
            return nil
        }
        
        let deleteAction: UIContextualAction = UIContextualAction(style: .destructive, title: nil) { action, view, completion in
            self.showAlert { action in
                if action {
                    let dayID: Double = viewModel.days[indexPath.section].timestamp
                    
                    if let dailyRecordToDelete: DailyRecord = viewModel.dailyRecords[dayID]?[indexPath.row] {
                        let context: NSManagedObjectContext = AppDelegate.sharedAppDelegate.coreDataManager.managedContext
                        context.delete(dailyRecordToDelete)
                        
                        do {
                            if context.hasChanges {
                                try context.save()
                            }
                        }
                        catch {
                            print("--- Failed to save context ---")
                        }
                    }
                }
                else {
                    completion(false)
                }
            }
        }
        deleteAction.image = UIImage(systemName: "trash")
        
        let configuration: UISwipeActionsConfiguration = UISwipeActionsConfiguration(actions: [deleteAction])
        return configuration
    }
    
}
