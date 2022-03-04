//
//  DailyRecordTableViewCell.swift
//  Recorday
//
//  Created by HyeJee Kim on 2022/03/03.
//

import UIKit

class DailyRecordTableViewCell: UITableViewCell {
    
    // MARK: - Outlet
    
    @IBOutlet weak var moodImageView: UIImageView!
    @IBOutlet weak var moodLabel: UILabel!
    @IBOutlet weak var timeLabel: UILabel!
    @IBOutlet weak var activityCollectionView: UICollectionView!
    
    // MARK: - Property
    
    var activityTitles: [String] = []
    
    override func awakeFromNib() {
        print("--- \(#function) ---")
        super.awakeFromNib()
        // Initialization code
        self.activityCollectionView.dataSource = self
    }

    override func setSelected(_ selected: Bool, animated: Bool) {
        super.setSelected(selected, animated: animated)

        // Configure the view for the selected state
    }
    
    override func prepareForReuse() {
        super.prepareForReuse()
        activityTitles.removeAll()
    }

}

extension DailyRecordTableViewCell: UICollectionViewDataSource {
    
    public func collectionView(_ collectionView: UICollectionView, numberOfItemsInSection section: Int) -> Int {
        print("--- \(#function) ---")
        return self.activityTitles.count
    }
    
    public func collectionView(_ collectionView: UICollectionView, cellForItemAt indexPath: IndexPath) -> UICollectionViewCell {
        print("--- \(#function): \(indexPath) ---")
        if let cell: ActivityCollectionViewCell = collectionView.dequeueReusableCell(withReuseIdentifier: "ActivityCollectionViewCell", for: indexPath) as? ActivityCollectionViewCell {
            cell.titleLabel.text = self.activityTitles[indexPath.item]
            return cell
        }
        
        return UICollectionViewCell()
    }
    
}
