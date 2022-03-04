//
//  CreateDailyRecordViewController.swift
//  Recorday
//
//  Created by HyeJee Kim on 2022/03/02.
//

import UIKit
import CoreData

class CreateDailyRecordViewController: UIViewController {
    
    // MARK: - Outlet
    
    @IBOutlet weak var nextButton: UIButton!
    
    @IBOutlet weak var angryMoodButton: MoodButton!
    @IBOutlet weak var badMoodButton: MoodButton!
    @IBOutlet weak var expressionlessMoodButton: MoodButton!
    @IBOutlet weak var goodMoodButton: MoodButton!
    @IBOutlet weak var happyMoodButton: MoodButton!
    
    // MARK: - Property
    
    var selectedMood: Mood?
    
    // MARK: - Deinit
    
    deinit {
    }

    override func viewDidLoad() {
        super.viewDidLoad()
        self.generalSetUp()
    }
    
    private func generalSetUp() {
        nextButton.isEnabled = false
    }
    
    private func setUpMoodButtons() {
        // set mood
        angryMoodButton.mood = .angry
        badMoodButton.mood = .bad
        expressionlessMoodButton.mood = .expressionless
        goodMoodButton.mood = .good
        happyMoodButton.mood = .happy
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

extension CreateDailyRecordViewController: MoodButtonDelegate {
    
    func didSelect(of mood: Mood) {
        <#code#>
    }
    
    func didDeselect(of mood: Mood) {
        <#code#>
    }
    
}
