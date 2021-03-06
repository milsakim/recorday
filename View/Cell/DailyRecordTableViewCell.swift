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
    @IBOutlet weak var notes: UILabel!
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
            
            notes.text = activitiesString
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
        self.topContinuousLine.isHidden = false
        self.topContinuousLine.isHidden = false
    }
    
}

extension DailyRecordTableViewCell {
    
    public enum CellType {
        case first
        case last
    }
    
    public func setMood(of id: String?) {
        if let id: String = id, let mood: Mood = Mood.moods.filter({ $0.id == id }).first {
            self.moodLabel.text = mood.emoji
            self.moodLabelBackgroundView.backgroundColor = mood.color
        }
        else {
            self.moodLabel.text = Mood.moods[Mood.moods.count - 1].emoji
            self.moodLabelBackgroundView.backgroundColor = Mood.moods[Mood.moods.count - 1].color
        }
    }
    
    public func setContinuousLines(as type: CellType) {
        switch type {
        case .first:
            self.topContinuousLine.isHidden = true
        case .last:
            self.bottonContinuousLine.isHidden = true
        }
    }
    
}
