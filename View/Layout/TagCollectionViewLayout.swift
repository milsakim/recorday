//
//  TagCollectionViewLayout.swift
//  Recorday
//
//  Created by HyeeJee Kim on 2022/03/10.
//

import UIKit

protocol TagCollectionViewLayoutDelegate: AnyObject {
    
    func collectionView(_ collectionView: UICollectionView, widthForTagLabelAtIndexPath indexPath: IndexPath) -> CGFloat
    
}

class TagCollectionViewLayout: UICollectionViewLayout {
    
    // MARK: - Property
    
    weak var delegate: TagCollectionViewLayoutDelegate?
    
    private var cache: [UICollectionViewLayoutAttributes] = []
    
    private var contentWidth: CGFloat {
        guard let collectionView = self.collectionView else {
            return 0
        }
        
        let insets: UIEdgeInsets = collectionView.contentInset
        
        return collectionView.bounds.width - (insets.left + insets.right)
    }
    
    private var contentHeight: CGFloat = 0
    
    override var collectionViewContentSize: CGSize {
        return CGSize(width: contentWidth, height: contentHeight)
    }
    
    // MARK: - Deinit
    
    deinit {
        print("--- deinit TagCollectionViewLayout ---")
    }
    
    // MARK: - Prepare
    
    override func prepare() {
        print("--- \(#function) ---")
        guard cache.isEmpty, let collectionView = self.collectionView else {
            return
        }
        
        let label: UILabel = UILabel(frame: CGRect(x: 0, y: 0, width: CGFloat.greatestFiniteMagnitude, height: CGFloat.greatestFiniteMagnitude))
        label.numberOfLines = 0
        label.font = UIFont.systemFont(ofSize: 17)
        label.textAlignment = .center
        label.text = "QqPp"
        label.sizeToFit()
        
        let rowHeight: CGFloat = 8 + label.frame.size.height
        
        var xOffset: CGFloat = 6
        var yOffset: CGFloat = 0
        
//        print("contentWidth: \(contentWidth)")
        
        for item in 0..<collectionView.numberOfItems(inSection: 0) {
            let indexPath: IndexPath = IndexPath(item: item, section: 0)
            
            let tagLabelWidth: CGFloat = self.delegate?.collectionView(collectionView, widthForTagLabelAtIndexPath: indexPath) ?? contentWidth
//            print("--- \(item)'s tagLabelWidth: \(tagLabelWidth) ---")
            
            if xOffset + tagLabelWidth + 16 + 6 > contentWidth {
                xOffset = 6
                yOffset += rowHeight + 6
            }
//            print("--- \(item): \(xOffset), \(yOffset) ---")
            let frame: CGRect = CGRect(x: xOffset, y: yOffset, width: tagLabelWidth + 16, height: rowHeight)
            //            let insetFrame: CGRect = frame.insetBy(dx: 6, dy: 6)
            
            let attributes: UICollectionViewLayoutAttributes = UICollectionViewLayoutAttributes(forCellWith: indexPath)
            attributes.frame = frame
            self.cache.append(attributes)
            
            self.contentHeight = max(self.contentHeight, frame.maxY)
            
            xOffset += frame.width + 6
//            print()
        }
    }
    
    override func layoutAttributesForElements(in rect: CGRect) -> [UICollectionViewLayoutAttributes]? {
        print("--- \(#function) ---")
        var visibleLayoutAttributes: [UICollectionViewLayoutAttributes] = []
        
        // Loop through the cache and look for items in the rect
        for attributes in cache {
            if attributes.frame.intersects(rect) {
                visibleLayoutAttributes.append(attributes)
            }
        }
        
        return visibleLayoutAttributes
    }
    
    override func layoutAttributesForItem(at indexPath: IndexPath) -> UICollectionViewLayoutAttributes? {
        print("--- \(#function) ---")
        return cache[indexPath.item]
    }
    
    override func invalidateLayout() {
        super.invalidateLayout()
        contentHeight = 0
        cache.removeAll()
    }
    
}
