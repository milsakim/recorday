//
//  MoodSelectionViewController.swift
//  Recorday
//
//  Created by HyeJee Kim on 2022/03/02.
//

import UIKit
import CoreData

class MoodSelectionViewController: UIViewController {
    
    // MARK: - Outlet
    
    @IBOutlet weak var nextButton: UIButton!
    
    @IBOutlet weak var angryMoodButton: MoodButton!
    @IBOutlet weak var badMoodButton: MoodButton!
    @IBOutlet weak var expressionlessMoodButton: MoodButton!
    @IBOutlet weak var goodMoodButton: MoodButton!
    @IBOutlet weak var happyMoodButton: MoodButton!
    
    // MARK: - Property
    
    var selectedMood: Mood? {
        willSet {
            if let selectedMood = selectedMood {
                switch selectedMood {
                case .angry:
                    angryMoodButton.isSelected = false
                case .bad:
                    badMoodButton.isSelected = false
                case .expressionless:
                    expressionlessMoodButton.isSelected = false
                case .good:
                    goodMoodButton.isSelected = false
                case .happy:
                    happyMoodButton.isSelected = false
                }
            }
        }
        
        didSet {
            if selectedMood != nil {
                self.nextButton.isEnabled = true
            }
            else {
                self.nextButton.isEnabled = false
            }
        }
    }
    
    // MARK: - Deinit
    
    deinit {
    }

    override func viewDidLoad() {
        super.viewDidLoad()
        self.generalSetUp()
    }
    
    private func generalSetUp() {
        nextButton.isEnabled = false
        self.setUpMoodButtons()
    }
    
    private func setUpMoodButtons() {
        // set mood
        angryMoodButton.mood = .angry
        badMoodButton.mood = .bad
        expressionlessMoodButton.mood = .expressionless
        goodMoodButton.mood = .good
        happyMoodButton.mood = .happy
        
        // set delegate
        angryMoodButton.delegate = self
        badMoodButton.delegate = self
        expressionlessMoodButton.delegate = self
        goodMoodButton.delegate = self
        happyMoodButton.delegate = self
    }
    
    @IBAction func cancelButtonTapped(_ sender: Any) {
        guard let navigationController = self.navigationController else {
            return
        }
        
        if let presentingViewController = navigationController.presentingViewController {
            presentingViewController.dismiss(animated: true, completion: nil)
        }
    }
    
}

// MARK: - Mood Button Delegate

extension MoodSelectionViewController: MoodButtonDelegate {
    
    func didSelect(of mood: Mood) {
        print("--- \(#function): \(mood) ---")
        
        if self.selectedMood != nil {
            self.selectedMood = nil
        }
        
        switch mood {
        case .angry:
            self.selectedMood = .angry
        case .bad:
            self.selectedMood = .bad
        case .expressionless:
            self.selectedMood = .expressionless
        case .good:
            self.selectedMood = .good
        case .happy:
            self.selectedMood = .happy
        }
    }
    
    func didDeselect(of mood: Mood) {
        print("--- \(#function): \(mood) ---")
        switch mood {
        case .angry:
            if self.selectedMood == .angry {
                self.selectedMood = nil
            }
        case .bad:
            if self.selectedMood == .bad {
                self.selectedMood = nil
            }
        case .expressionless:
            if self.selectedMood == .expressionless {
                self.selectedMood = nil
            }
        case .good:
            if self.selectedMood == .good {
                self.selectedMood = nil
            }
        case .happy:
            if self.selectedMood == .happy {
                self.selectedMood = nil
            }
        }
    }
    
}
