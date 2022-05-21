//
//  MoodCollectionViewCell.swift
//  Recorday
//
//  Created by HyeeJee Kim on 2022/03/15.
//

import UIKit

class MoodCollectionViewCell: UICollectionViewCell {
    
    // MARK: - Outlet
    
    @IBOutlet weak var moodImageView: UIImageView!
    
    // MARK: - Property
    
    static let reuseID: String = "MoodCollectionViewCell"
    
    // MARK: - Initialization
    
    override func awakeFromNib() {
        super.awakeFromNib()
    }

}
