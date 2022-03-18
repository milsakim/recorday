//
//  SelectingActivitiesViewController.swift
//  Recorday
//
//  Created by HyeJee Kim on 2022/03/04.
//

import UIKit

class SelectingActivitiesViewController: UIViewController {
    
    // MARK: - Outlet
    
    @IBOutlet weak var tableView: UITableView!
    
    
    // MARK: - Property
    
    var dailyRecord: DailyRecord?
    
    let sectionTitles: [String] = ["Activities", "Note"]
    
    // MARK: - Deinitializer
    
    deinit {
        if dailyRecord != nil {
            dailyRecord = nil
        }
        
        print("--- deinit SelectingActivitiesViewController ---")
    }
    
    // MARK: - View Life Cycle
    
    override func viewDidLoad() {
        super.viewDidLoad()
        commonInit()
    }
    
    override func touchesBegan(_ touches: Set<UITouch>, with event: UIEvent?) {
        super.touchesBegan(touches, with: event)
        print("--- \(#function) ---")
    }
    
    private func commonInit() {
        self.setupNavigation()
        self.setupTableView()
        
        let notificationCenter = NotificationCenter.default
        notificationCenter.addObserver(self, selector: #selector(adjustForKeyboard), name: UIResponder.keyboardWillHideNotification, object: nil)
        notificationCenter.addObserver(self, selector: #selector(adjustForKeyboard), name: UIResponder.keyboardWillChangeFrameNotification, object: nil)
    }
    
    @objc func adjustForKeyboard(notification: Notification) {
        guard let keyboardValue = notification.userInfo?[UIResponder.keyboardFrameEndUserInfoKey] as? NSValue else { return }
        
        let keyboardScreenEndFrame = keyboardValue.cgRectValue
        let keyboardViewEndFrame = view.convert(keyboardScreenEndFrame, from: view.window)
        
        if notification.name == UIResponder.keyboardWillHideNotification {
            tableView.contentInset = .zero
        }
        else {
            tableView.contentInset = UIEdgeInsets(top: 0, left: 0, bottom: keyboardViewEndFrame.height - view.safeAreaInsets.bottom, right: 0)
        }
        
        tableView.scrollIndicatorInsets = tableView.contentInset
//        tableView.setContentOffset(CGPoint(x: 0, y: tableView.contentSize.height - tableView.bounds.size.height + tableView.contentInset.bottom), animated: true)
//        let selectedRange = tableView.selectedRange
//        tableView.scrollToRow(at: IndexPath(row: 0, section: 0), at: .top, animated: true)
//        tableView.scrollRectToVisible(CGRect(x: 0, y: tableView.contentSize.height, width: tableView.bounds.width, height: 100), animated: true)
        /*
        if let cell: ActivityInputTableViewCell = tableView.cellForRow(at: IndexPath(row: 0, section: 0)) as? ActivityInputTableViewCell {
            let selectedRange = cell.activityInputTextView.selectedRange
            cell.activityInputTextView.scrollRangeToVisible(selectedRange)
        }
        */
    }

}

extension SelectingActivitiesViewController: ActivityInputTableViewCellDelegate {
    
    func textViewHeightDidChange(to height: CGFloat) {
        print("--- \(#function) ---")
        print(tableView.contentSize)
        self.tableView.beginUpdates()
        self.tableView.endUpdates()
        print(tableView.contentSize)
//        tableView.setContentOffset(CGPoint(x: 0, y: tableView.contentSize.height - tableView.bounds.size.height + tableView.contentInset.bottom), animated: true)
//        tableView.scrollRectToVisible(CGRect(x: 0, y: tableView.contentSize.height, width: tableView.bounds.width, height: 100), animated: true)
//        tableView.scrollToRow(at: IndexPath(row: 0, section: 0), at: .middle, animated: true)
    }
    
}
