//
//  DailyRecordTableViewCell.swift
//  Recorday
//
//  Created by HyeJee Kim on 2022/03/03.
//

import UIKit

class DailyRecordTableViewCell: UITableViewCell {
    
    // MARK: - Outlet

    @IBOutlet weak var moodLabelBackgroundView: UIView!
    @IBOutlet weak var timeLabel: UILabel!
    @IBOutlet weak var activitiesLabel: UILabel!
    @IBOutlet weak var activitiesLabelBackgroundView: UIView!
    @IBOutlet weak var moodLabel: UILabel!
    @IBOutlet weak var topContinuousLine: UIView!
    @IBOutlet weak var bottonContinuousLine: UIView!
    // MARK: - Property
    
    var activityTitles: [String] = [] {
        didSet {
            var activitiesString: String = ""
            
            for (index, activity) in activityTitles.enumerated() {
                activitiesString += "#\(activity)"
                
                if index != (activityTitles.count - 1){
                    activitiesString += " · "
                }
            }
            
            activitiesLabel.text = activitiesString
        }
    }
    
    override func awakeFromNib() {
        super.awakeFromNib()
        moodLabelBackgroundView.layer.cornerRadius = 25
    }

    override func setSelected(_ selected: Bool, animated: Bool) {
        super.setSelected(selected, animated: animated)

        // Configure the view for the selected state
    }
    
    override func prepareForReuse() {
        super.prepareForReuse()
        self.activityTitles.removeAll()
    }
    
}

extension DailyRecordTableViewCell {
    
    public func setMood(of id: String?) {
        guard let id: String = id,
              let mood: Mood = Mood.moods.filter({ $0.id == id }).first else {
            return
        }
        
        self.moodLabel.text = mood.emoji
        self.moodLabelBackgroundView.backgroundColor = mood.color
    }
    
}
