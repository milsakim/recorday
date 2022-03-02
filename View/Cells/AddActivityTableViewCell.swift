//
//  AddActivityTableViewCell.swift
//  Recorday
//
//  Created by HyeJee Kim on 2022/03/02.
//

import UIKit

class AddActivityTableViewCell: UITableViewCell {
    
    // MARK: - Outlet
    
    @IBOutlet weak var stackView: UIStackView!
    

    override func awakeFromNib() {
        super.awakeFromNib()
        print(#function)
    }

    override func setSelected(_ selected: Bool, animated: Bool) {
        super.setSelected(selected, animated: animated)

        // Configure the view for the selected state
    }

}
