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
    @IBOutlet weak var datePicker: UIDatePicker!
    
    // MARK: - Property
    
    var selectedMoodIndex: IndexPath? {
        didSet {
            self.nextButton.isEnabled = true
            
            if let selectedMoodIndex = selectedMoodIndex {
//                dailyRecord?.mood = Mood.moods[selectedMoodIndex.item].id
                dailyRecordMetadata?.moodID = Mood.moods[selectedMoodIndex.item].id
            }
        }
    }

    var dailyRecordMetadata: DailyRecordMetadata?
    
    // MARK: - Deinit
    
    deinit {
        print("--- deinit MoodSelectionViewController ---")
    }
    
    override func viewDidLoad() {
        super.viewDidLoad()
        self.commonInit()
    }
    
    private func commonInit() {
        nextButton.isEnabled = false
        setupNaviation()
        setupCollectionView()
        setupDatePicker()
        setupDailyRecordMetadata()
    }
    
}
