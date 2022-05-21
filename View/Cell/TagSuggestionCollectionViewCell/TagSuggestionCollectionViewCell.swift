//
//  TagSuggestionCollectionViewCell.swift
//  Recorday
//
//  Created by HyeeJee Kim on 2022/05/08.
//

import UIKit

class TagSuggestionCollectionViewCell: UICollectionViewCell {

    static let reuseID: String = "TagSuggestionCollectionViewCell"
    
    // MARK: - Outlet
    
    @IBOutlet weak var labelBackgroundView: UIView!
    @IBOutlet weak var label: UILabel!
    
    // MARK: - Property
    
    override var isSelected: Bool {
        didSet {
            self.configureUI(isSelected: isSelected)
        }
    }
    
    // MARK: - Set Up
    
    override func awakeFromNib() {
        super.awakeFromNib()
        self.backgroundColor = .clear
        self.labelBackgroundView.layer.cornerRadius = 10
        self.label.font = UIFont(name: "Pretendard-Regular", size: 15)
    }
    
    override func prepareForReuse() {
        super.prepareForReuse()
        self.label.text = nil
        configureUI(isSelected: false)
    }
    
    // MARK: - Hadle Selecting
    
    func configureUI(isSelected: Bool) {
        if isSelected {
            self.labelBackgroundView.backgroundColor = UIColor(named: "accent-color")
            self.labelBackgroundView.layer.borderWidth = 1
            self.labelBackgroundView.layer.borderColor = UIColor(named: "main-color")?.cgColor
            
            self.label.textColor = UIColor(named: "main-color")
        }
        else {
            self.labelBackgroundView.backgroundColor = UIColor(named: "main-color")
            self.label.textColor =  UIColor(named: "accent-color")
        }
    }

}
