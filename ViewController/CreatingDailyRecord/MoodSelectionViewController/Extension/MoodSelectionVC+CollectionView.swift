//
//  MoodSelectionVC+CollectionView.swift
//  Recorday
//
//  Created by HyeeJee Kim on 2022/03/12.
//

import UIKit

extension MoodSelectionViewController: UICollectionViewDataSource {
    
    func collectionView(_ collectionView: UICollectionView, numberOfItemsInSection section: Int) -> Int {
        return Mood.moods.count
    }
    
    func collectionView(_ collectionView: UICollectionView, cellForItemAt indexPath: IndexPath) -> UICollectionViewCell {
        guard let cell: MoodCollectionViewCell = collectionView.dequeueReusableCell(withReuseIdentifier: MoodCollectionViewCell.resueID, for: indexPath) as? MoodCollectionViewCell else {
            fatalError()
        }
        
        cell.layer.borderColor = Mood.moods[indexPath.item].color?.cgColor
        cell.moodLabel.text = Mood.moods[indexPath.item].emoji
        
        return cell
    }
    
    
}

// MARK: - UICollectionView Deleage

extension MoodSelectionViewController: UICollectionViewDelegate {
    
    func collectionView(_ collectionView: UICollectionView, didHighlightItemAt indexPath: IndexPath) {
        if let cell: MoodCollectionViewCell = collectionView.cellForItem(at: indexPath) as? MoodCollectionViewCell {
            let generator: UIImpactFeedbackGenerator = UIImpactFeedbackGenerator(style: .light)
            generator.impactOccurred()
            
            let animator: UIViewPropertyAnimator = UIViewPropertyAnimator(duration: 0.1, curve: .easeOut) {
                cell.transform = CGAffineTransform(scaleX: 0.9, y: 0.9)
            }
            animator.startAnimation()
        }
    }
    
    func collectionView(_ collectionView: UICollectionView, didUnhighlightItemAt indexPath: IndexPath) {
        if let cell: MoodCollectionViewCell = collectionView.cellForItem(at: indexPath) as? MoodCollectionViewCell {
            let animator: UIViewPropertyAnimator = UIViewPropertyAnimator(duration: 0.2, curve: .easeOut) {
                cell.transform = .identity
            }
            animator.startAnimation()
        }
    }
    
    func collectionView(_ collectionView: UICollectionView, didSelectItemAt indexPath: IndexPath) {
        guard let cell: MoodCollectionViewCell = collectionView.cellForItem(at: indexPath) as? MoodCollectionViewCell else {
            return
        }
        
        if let selected = selectedMoodIndex {
            if selected == indexPath {
                return
            }
            
            cell.fillBackground(with: Mood.moods[indexPath.item].color)
            
            if let previousCell: MoodCollectionViewCell = collectionView.cellForItem(at: selected) as? MoodCollectionViewCell {
                previousCell.removeBackgroundFill()
            }
            
            selectedMoodIndex = indexPath
        }
        else {
            cell.fillBackground(with: Mood.moods[indexPath.item].color)
            selectedMoodIndex = indexPath
        }
    }
    
}
