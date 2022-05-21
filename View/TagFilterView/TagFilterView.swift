//
//  TagFilterView.swift
//  Recorday
//
//  Created by HyeeJee Kim on 2022/05/19.
//

import UIKit

protocol TagFilterViewDelegate: AnyObject {
    func didSelectTag(_ selectedTags: [String])
}

class TagFilterView: UIView {

    // MARK: - Outlet
    
    @IBOutlet weak var dimmedView: UIView!
    @IBOutlet weak var collectionView: UICollectionView!

    // MARK: - Property
    
    weak var delegate: TagFilterViewDelegate?
    
    var tags: [String] = [] {
        didSet {
            self.collectionView.reloadData()
        }
    }
    
    var selectedTag: [String: Bool] = [:]
    
    // MARK: - Set Up
    
    override func awakeFromNib() {
        super.awakeFromNib()
        setUpCollectionView()
        
        let tapRecognizer: UITapGestureRecognizer = UITapGestureRecognizer(target: self, action: #selector(handleTapGesture))
        dimmedView.addGestureRecognizer(tapRecognizer)
    }
    
    func setUpCollectionView() {
        self.collectionView.dataSource = self
        self.collectionView.delegate = self
        self.collectionView.allowsMultipleSelection = true
        self.collectionView.register(UINib(nibName: TagSuggestionCollectionViewCell.reuseID, bundle: .main), forCellWithReuseIdentifier: TagSuggestionCollectionViewCell.reuseID)
        
        if let layout: TagCollectionViewLayout = self.collectionView.collectionViewLayout as? TagCollectionViewLayout {
            layout.delegate = self
        }
    }
    
    @objc func handleTapGesture(_ gestureRecognizer: UITapGestureRecognizer) {
        print("--- \(#function) ---")
        
        let propertyAnimator: UIViewPropertyAnimator = UIViewPropertyAnimator(duration: 0.5, curve: .easeInOut) {
            self.alpha = 0
        }
        propertyAnimator.addCompletion { _ in
            self.removeFromSuperview()
        }
        propertyAnimator.startAnimation()
    }

}

// MARK: - Collection View Data Source

extension TagFilterView: UICollectionViewDataSource {
    
    func collectionView(_ collectionView: UICollectionView, numberOfItemsInSection section: Int) -> Int {
        return tags.count
    }
    
    func collectionView(_ collectionView: UICollectionView, cellForItemAt indexPath: IndexPath) -> UICollectionViewCell {
        guard let cell = collectionView.dequeueReusableCell(withReuseIdentifier: TagSuggestionCollectionViewCell.reuseID, for: indexPath) as? TagSuggestionCollectionViewCell else {
            return UICollectionViewCell()
        }
        
        cell.label.text = tags[indexPath.item]
        
        return cell
    }
    
}

// MARK: - Collection View Delegate

extension TagFilterView: UICollectionViewDelegate {
    
    func collectionView(_ collectionView: UICollectionView, didSelectItemAt indexPath: IndexPath) {
        if indexPath.item < self.tags.count {
            let title: String = tags[indexPath.item]
            self.selectedTag[title] = true
            delegate?.didSelectTag(self.selectedTag.keys.sorted())
        }
    }
    
    func collectionView(_ collectionView: UICollectionView, didDeselectItemAt indexPath: IndexPath) {
        if indexPath.item < self.tags.count {
            let title: String = tags[indexPath.item]
            self.selectedTag[title] = nil
            delegate?.didSelectTag(self.selectedTag.keys.sorted())
        }
    }
    
}


extension TagFilterView: TagCollectionViewLayoutDelegate {
    
    func collectionView(_ collectionView: UICollectionView, widthForTagLabelAtIndexPath indexPath: IndexPath) -> CGFloat {
        return UILabel.textWidth(font: .systemFont(ofSize: 14), text: self.tags[indexPath.item])
    }
    
}

extension UILabel {
    func textWidth() -> CGFloat {
        return UILabel.textWidth(label: self)
    }
    
    class func textWidth(label: UILabel) -> CGFloat {
        return textWidth(label: label, text: label.text!)
    }
    
    class func textWidth(label: UILabel, text: String) -> CGFloat {
        return textWidth(font: label.font, text: text)
    }
    
    class func textWidth(font: UIFont, text: String) -> CGFloat {
        return textSize(font: font, text: text).width
    }
    
    class func textHeight(withWidth width: CGFloat, font: UIFont, text: String) -> CGFloat {
        return textSize(font: font, text: text, width: width).height
    }
    
    class func textSize(font: UIFont, text: String, extra: CGSize) -> CGSize {
        var size = textSize(font: font, text: text)
        size.width = size.width + extra.width
        size.height = size.height + extra.height
        return size
    }
    
    class func textSize(font: UIFont, text: String, width: CGFloat = .greatestFiniteMagnitude, height: CGFloat = .greatestFiniteMagnitude) -> CGSize {
        let label = UILabel(frame: CGRect(x: 0, y: 0, width: width, height: height))
        label.numberOfLines = 0
        label.font = font
        label.text = text
        label.sizeToFit()
        return label.frame.size
    }
    
    class func countLines(font: UIFont, text: String, width: CGFloat, height: CGFloat = .greatestFiniteMagnitude) -> Int {
        // Call self.layoutIfNeeded() if your view uses auto layout
        let myText = text as NSString
        
        let rect = CGSize(width: width, height: height)
        let labelSize = myText.boundingRect(with: rect, options: .usesLineFragmentOrigin, attributes: [NSAttributedString.Key.font: font], context: nil)
        
        return Int(ceil(CGFloat(labelSize.height) / font.lineHeight))
    }
    
    func countLines(width: CGFloat = .greatestFiniteMagnitude, height: CGFloat = .greatestFiniteMagnitude) -> Int {
        // Call self.layoutIfNeeded() if your view uses auto layout
        let myText = (self.text ?? "") as NSString
        
        let rect = CGSize(width: width, height: height)
        let labelSize = myText.boundingRect(with: rect, options: .usesLineFragmentOrigin, attributes: [NSAttributedString.Key.font: self.font], context: nil)
        
        return Int(ceil(CGFloat(labelSize.height) / self.font.lineHeight))
    }
}
