//
//  TagSuggestionView.swift
//  Recorday
//
//  Created by HyeeJee Kim on 2022/05/08.
//

import UIKit

protocol TagSuggestionViewDelegate: AnyObject {
    func didSelectTag(of title: String)
}

class TagSuggestionView: UIView {
    
    // MARK: - Outlet
    
    @IBOutlet weak var collectionView: UICollectionView!
    
    // MARK: - Property
    
    private var tags: [String] = []
    
    var keyword: String? {
        didSet {
            print("keyword: \(keyword)")
            self.collectionView.reloadData()
        }
    }
    
    private var filteredTags: [String] {
        if let keyword = keyword {
            return self.tags.filter({
                if $0.range(of: ".*\(keyword).*", options: .regularExpression) != nil {
                    return true
                }
                else {
                    return false
                }
            })
        }
        else {
            return []
        }
    }
    
    weak var delegate: TagSuggestionViewDelegate?
    
    override func awakeFromNib() {
        super.awakeFromNib()
        commonInit()
    }
    
    private func commonInit() {
        setUpCollectionView()
    }
    
    func addTags(_ tags: [String]) {
        self.tags.append(contentsOf: tags)
    }
    
}

// MARK: - Set Up

extension TagSuggestionView {
    
    func setUpCollectionView() {
        self.collectionView.register(UINib(nibName: TagSuggestionCollectionViewCell.reuseID, bundle: .main), forCellWithReuseIdentifier: TagSuggestionCollectionViewCell.reuseID)
        self.collectionView.dataSource = self
        self.collectionView.delegate = self
    }
    
}

// MARK: - Collection View Data Source

extension TagSuggestionView: UICollectionViewDataSource {
    
    func collectionView(_ collectionView: UICollectionView, numberOfItemsInSection section: Int) -> Int {
        return self.filteredTags.count
    }
    
    func collectionView(_ collectionView: UICollectionView, cellForItemAt indexPath: IndexPath) -> UICollectionViewCell {
        guard let cell: TagSuggestionCollectionViewCell = collectionView.dequeueReusableCell(withReuseIdentifier: TagSuggestionCollectionViewCell.reuseID, for: indexPath) as? TagSuggestionCollectionViewCell else {
            return UICollectionViewCell()
        }
        
        if indexPath.row < self.filteredTags.count {
            cell.label.text = self.filteredTags[indexPath.item]
        }
        
        return cell
    }
    
}

// MARK: - Collection View Delegate

extension TagSuggestionView: UICollectionViewDelegate {
    
}

extension TagSuggestionView: UICollectionViewDelegateFlowLayout {
    
    func collectionView(_ collectionView: UICollectionView, layout collectionViewLayout: UICollectionViewLayout, sizeForItemAt indexPath: IndexPath) -> CGSize {
        print("--- \(#function) ---")
        let font: UIFont = .systemFont(ofSize: 17)
        let string: NSString = tags[indexPath.row] as NSString
        let stringSize: CGSize = string.size(withAttributes: [NSAttributedString.Key.font: font])
        return CGSize(width: stringSize.width + 16, height: stringSize.height + 16)
    }
    
    func collectionView(_ collectionView: UICollectionView, didSelectItemAt indexPath: IndexPath) {
        self.delegate?.didSelectTag(of: self.filteredTags[indexPath.item])
    }
    
}
