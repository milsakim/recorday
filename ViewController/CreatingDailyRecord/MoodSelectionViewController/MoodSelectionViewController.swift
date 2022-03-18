//
//  MoodSelectionViewController.swift
//  Recorday
//
//  Created by HyeJee Kim on 2022/03/02.
//

import UIKit

class MoodSelectionViewController: UIViewController {
    
    // MARK: - Outlet
    
    @IBOutlet weak var nextButton: UIButton!
    
    @IBOutlet weak var moodCollectionView: UICollectionView!
    
    // MARK: - Property
    
    var selectedMoodIndex: IndexPath? {
        didSet {
            self.nextButton.isEnabled = true
            
            if let selectedMoodIndex = selectedMoodIndex {
                dailyRecord?.mood = Mood.moods[selectedMoodIndex.item].id
            }
        }
    }
    
    var dailyRecord: DailyRecord?
    
    let moods: [String] = []
    
    // MARK: - Deinit
    
    deinit {
        if dailyRecord != nil {
            dailyRecord = nil
        }
        
        print("--- deinit MoodSelectionViewController ---")
    }
    
    override func viewDidLoad() {
        super.viewDidLoad()
        self.generalSetUp()
    }
    
    private func generalSetUp() {
        nextButton.isEnabled = false
        setupNaviation()
        setupCollectionView()
        createDailyRecord()
    }
    
}
