//
//  RecordListVC+FetchedResultsControllerDelegaet.swift
//  Recorday
//
//  Created by HyeeJee Kim on 2022/03/10.
//

import CoreData

extension RecordListViewController: NSFetchedResultsControllerDelegate {
    
    func controllerDidChangeContent(_ controller: NSFetchedResultsController<NSFetchRequestResult>) {
        print("--- \(#function): \(Thread.current.isMainThread) ---")
        self.tableView.reloadData()
    }
    
}
