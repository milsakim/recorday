//
//  RecordListVC+TagFilterViewDelegate.swift
//  Recorday
//
//  Created by HyeeJee Kim on 2022/05/20.
//

import UIKit

extension RecordListViewController: TagFilterViewDelegate {
    
    func didSelectTag(_ selectedTags: [String]) {
        print("--- selected tags: \(selectedTags) ---")
        self.viewModel?.tagTitles = selectedTags
    }
    
}
