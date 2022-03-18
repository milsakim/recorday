//
//  MoodCollectionViewCell.swift
//  Recorday
//
//  Created by HyeeJee Kim on 2022/03/15.
//

import UIKit

class MoodCollectionViewCell: UICollectionViewCell {
    
    // MARK: - Outlet
    
    @IBOutlet weak var moodLabel: UILabel!
    
    // MARK: - Property
    
    static let resueID: String = "MoodCollectionViewCell"
    
    // MARK: - Initialization
    
    override func awakeFromNib() {
        super.awakeFromNib()
        layer.cornerRadius = 10.0
        layer.borderWidth = 4.0
    }
    
    func fillBackground(with color: UIColor?) {
        backgroundColor = color
    }
    
    func removeBackgroundFill() {
        print("--- \(#function) ---")
        backgroundColor = .systemBackground
    }

}
