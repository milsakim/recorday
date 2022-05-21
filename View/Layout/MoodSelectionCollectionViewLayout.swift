//
//  MoodSelectionCollectionViewLayout.swift
//  Recorday
//
//  Created by HyeeJee Kim on 2022/03/15.
//

import UIKit

class MoodSelectionCollectionViewLayout: UICollectionViewLayout {
    
    private var contentWidth: CGFloat {
        guard let collectionView = self.collectionView else {
            return 0
        }
        
        let insets: UIEdgeInsets = collectionView.contentInset
        
        
        return collectionView.bounds.width - (insets.left + insets.right)
    }
    
    private var contentHeight: CGFloat {
        guard let collectionView = self.collectionView else {
            return 0
        }
        
        let insets: UIEdgeInsets = collectionView.contentInset
//        print("--- collection view inset: \(insets) ---")
        
        return collectionView.bounds.height - (insets.left + insets.right)
    }
    
    private var itemWidth: CGFloat {
        guard let collectionView = collectionView else {
            return 90
        }
        
        if collectionView.frame.width > collectionView.frame.height {
            let estimatedwidth: CGFloat = (contentWidth - 16 * 4) / 5
            let estimatedHeight: CGFloat = contentHeight
            
            return estimatedwidth > estimatedHeight ? estimatedHeight : estimatedwidth
        }
        else {
            return contentWidth / 3
        }
    }
    
    private var itemHeight: CGFloat {
        guard let collectionView = collectionView else {
            return 90
        }
        
        if collectionView.frame.width > collectionView.frame.height {
            let estimatedwidth: CGFloat = (contentWidth - padding * 4) / 5
            let estimatedHeight: CGFloat = contentHeight
            
            return estimatedwidth > estimatedHeight ? estimatedHeight : estimatedwidth
        }
        else {
            return itemWidth
        }
    }
    
    private var padding: CGFloat = 16
    
    override var collectionViewContentSize: CGSize {
        guard collectionView != nil else {
            return CGSize(width: 270, height: 270)
        }
        
//        print("--- MoodCollectionViewPortraitLayout collectionViewContentSize: \(collectionView.frame.width) ---")
        
        return CGSize(width: contentWidth, height: contentHeight)
    }
    
    private var cache: [UICollectionViewLayoutAttributes] = []
    
    override func prepare() {
        guard cache.isEmpty, let collectionView = self.collectionView else {
            return
        }
        
        let attributes0: UICollectionViewLayoutAttributes = UICollectionViewLayoutAttributes(forCellWith: IndexPath(item: 0, section: 0))
        let attributes1: UICollectionViewLayoutAttributes = UICollectionViewLayoutAttributes(forCellWith: IndexPath(item: 1, section: 0))
        let attributes2: UICollectionViewLayoutAttributes = UICollectionViewLayoutAttributes(forCellWith: IndexPath(item: 2, section: 0))
        let attributes3: UICollectionViewLayoutAttributes = UICollectionViewLayoutAttributes(forCellWith: IndexPath(item: 3, section: 0))
        let attributes4: UICollectionViewLayoutAttributes = UICollectionViewLayoutAttributes(forCellWith: IndexPath(item: 4, section: 0))
        
        if collectionView.frame.width >= collectionView.frame.height {
            let yOffset: CGFloat = (contentHeight - itemWidth) / 2
            attributes0.frame = CGRect(x: 0, y: yOffset, width: itemWidth, height: itemWidth)
            attributes1.frame = CGRect(x: itemWidth * 1 + padding, y: yOffset + 0, width: itemWidth, height: itemWidth)
            attributes2.frame = CGRect(x: itemWidth * 2 + padding * 2, y: yOffset + 0, width: itemWidth, height: itemWidth)
            attributes3.frame = CGRect(x: itemWidth * 3 + padding * 3, y: yOffset, width: itemWidth, height: itemWidth)
            attributes4.frame = CGRect(x: itemWidth * 4 + padding * 4, y: yOffset, width: itemWidth, height: itemWidth)
        }
        else {
            let yOffset: CGFloat = (contentHeight - itemWidth * 3) / 2
            attributes0.frame = CGRect(x: 0, y: yOffset, width: itemWidth, height: itemWidth)
            attributes1.frame = CGRect(x: itemWidth * 2, y: yOffset, width: itemWidth, height: itemWidth)
            attributes2.frame = CGRect(x: itemWidth, y: yOffset + itemWidth, width: itemWidth, height: itemWidth)
            attributes3.frame = CGRect(x: 0, y: yOffset + itemWidth * 2, width: itemWidth, height: itemWidth)
            attributes4.frame = CGRect(x: itemWidth * 2, y: yOffset + itemWidth * 2, width: itemWidth, height: itemWidth)
        }
        
        cache = [attributes0, attributes1, attributes2, attributes3, attributes4]
        
        /*
         for (index, value) in cache.enumerated() {
         print("--- cache \(index): \(value.frame) ---")
         }
         */
    }
    
    override func layoutAttributesForElements(in rect: CGRect) -> [UICollectionViewLayoutAttributes]? {
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
        return cache[indexPath.item]
    }
    
    override func shouldInvalidateLayout(forBoundsChange newBounds: CGRect) -> Bool {
        return true
    }
    
    override func invalidateLayout() {
        super.invalidateLayout()
        cache = []
    }
    
}

