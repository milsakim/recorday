//
//  RecordListVC+UICollectionView.swift
//  Recorday
//
//  Created by HyeeJee Kim on 2022/05/17.
//

import UIKit

extension RecordListViewController: UICollectionViewDataSource {
    
    func collectionView(_ collectionView: UICollectionView, numberOfItemsInSection section: Int) -> Int {
        return 5
    }
    
    func collectionView(_ collectionView: UICollectionView, cellForItemAt indexPath: IndexPath) -> UICollectionViewCell {
        guard let cell: MoodCollectionViewCell = collectionView.dequeueReusableCell(withReuseIdentifier: MoodCollectionViewCell.reuseID, for: indexPath) as? MoodCollectionViewCell else {
            fatalError()
        }
        
        switch indexPath.item {
        case 0:
            cell.moodImageView.image = UIImage(named: "0")
        case 1:
            cell.moodImageView.image = UIImage(named: "100")
        case 2:
            cell.moodImageView.image = UIImage(named: "200")
        case 3:
            cell.moodImageView.image = UIImage(named: "300")
        default:
            cell.moodImageView.image = UIImage(named: "400")
        }
        
        return cell
    }
    
}

extension RecordListViewController: UICollectionViewDelegate {
    
    func collectionView(_ collectionView: UICollectionView, didSelectItemAt indexPath: IndexPath) {
        let storyboard: UIStoryboard = UIStoryboard(name: "CreatingDailyRecord", bundle: .main)
        
        guard let vc: NoteViewController = storyboard.instantiateViewController(withIdentifier: NoteViewController.reuseID) as? NoteViewController else {
            return
        }
        
        let currentTimestamp: Double = Date().timeIntervalSince1970
        let currentDateTimestamp: Double = self.getDateTimestamp(from: currentTimestamp) ?? 0
        let currentTimeTimestamp: Double = currentTimestamp - currentDateTimestamp
        
        switch indexPath.item {
        case 0:
            vc.dailyRecordMetadata = DailyRecordMetadata(moodID: "0", dateTimestamp: currentDateTimestamp, timeTimestamp: currentTimeTimestamp)
        case 1:
            vc.dailyRecordMetadata = DailyRecordMetadata(moodID: "100", dateTimestamp: currentDateTimestamp, timeTimestamp: currentTimeTimestamp)
        case 2:
            vc.dailyRecordMetadata = DailyRecordMetadata(moodID: "200", dateTimestamp: currentDateTimestamp, timeTimestamp: currentTimeTimestamp)
        case 3:
            vc.dailyRecordMetadata = DailyRecordMetadata(moodID: "300", dateTimestamp: currentDateTimestamp, timeTimestamp: currentTimeTimestamp)
        case 4:
            vc.dailyRecordMetadata = DailyRecordMetadata(moodID: "400", dateTimestamp: currentDateTimestamp, timeTimestamp: currentTimeTimestamp)
        default:
            return
        }
        
        vc.isModalInPresentation = true
        self.present(vc, animated: true)
    }
    
}
