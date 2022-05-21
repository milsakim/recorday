//
//  CircularCollectionViewLayout.swift
//  Recorday
//
//  Created by HyeeJee Kim on 2022/05/17.
//

import UIKit

class CircularCollectionViewLayout: UICollectionViewLayout {
    
    var center: CGPoint {
        guard let collectionView = self.collectionView else {
            return CGPoint(x: 300, y: 300)
        }
        
        return CGPoint(x: collectionView.bounds.maxX, y: collectionView.bounds.maxY)
    }
    var itemSize: CGSize = CGSize(width: 40, height: 40)
    var radius: CGFloat = (200 - 20)
    var angularSpacing: CGFloat = .pi / 3
    var scrollDirection: UICollectionView.ScrollDirection = .horizontal
    var mirrorX: Bool = false
    var mirrorY: Bool = false
    var rotateItems: Bool = false
    var angleOfEachItem: CGFloat = .pi / 9 // 30 degrees
    var circumference: CGFloat?
    var cellCount: Int {
        return collectionView?.numberOfItems(inSection: 0) ?? 0
    }
    var maxNoOfCellsInCircle: CGFloat?
    var startAngle: CGFloat  = .pi
    var endAngle: CGFloat = .pi / 2
    
    
    override func prepare() {
        super.prepare()
        
        self.circumference = abs(self.startAngle - self.endAngle) * radius
        self.maxNoOfCellsInCircle = self.circumference! / (self.itemSize.width + self.angularSpacing)
    }
    
    override var collectionViewContentSize: CGSize {
        let visibleAngle: CGFloat = abs(startAngle - endAngle)
        let remaindingItemsCount: Int = cellCount > Int(maxNoOfCellsInCircle!) ? cellCount - Int(maxNoOfCellsInCircle!) : 0
        let scrollableContentWidth: CGFloat = CGFloat((remaindingItemsCount + 1)) * angleOfEachItem * self.radius / (2 * .pi / visibleAngle)
        let height: CGFloat = self.radius + itemSize.width / 2
        
        if self.scrollDirection == .vertical {
            return CGSize(width: height, height: scrollableContentWidth + self.collectionView!.bounds.size.width)
        }
        else {
            return CGSize(width: scrollableContentWidth + self.collectionView!.bounds.size.width, height: height)
        }
    }
    
    override func layoutAttributesForItem(at indexPath: IndexPath) -> UICollectionViewLayoutAttributes? {
        return self.layoutAttributesForHorizontalScroll(at: indexPath)
    }
    
    override func layoutAttributesForElements(in rect: CGRect) -> [UICollectionViewLayoutAttributes]? {
        var attributesList: [UICollectionViewLayoutAttributes] = []
        
        for i in 0..<cellCount {
            let indexPath: IndexPath = IndexPath(item: i, section: 0)
            
            if let cellAttributes = self.layoutAttributesForItem(at: indexPath), rect.intersects(cellAttributes.frame) {
                attributesList.append(cellAttributes)
            }
        }
        
        return attributesList
    }
    
    func layoutAttributesForHorizontalScroll(at indexPath: IndexPath) -> UICollectionViewLayoutAttributes? {
        if self.startAngle - self.endAngle == 0 {
            return nil
        }
        
        guard let collectionView = self.collectionView else {
            return nil
        }
        
        let attributes: UICollectionViewLayoutAttributes = UICollectionViewLayoutAttributes(forCellWith: indexPath)
        let offset: CGFloat = collectionView.contentOffset.x == 0 ? 1 : collectionView.contentOffset.x
        let offsetPartInPi: CGFloat = offset / circumference!
        let offsetAngle: CGFloat = 2 * .pi * offsetPartInPi
        
        attributes.size = self.itemSize
        
        let x: CGFloat = self.center.x + offset + radius * cos(CGFloat(indexPath.item) * angleOfEachItem - offsetAngle + angleOfEachItem / 2 - startAngle)
        let y: CGFloat = self.center.y + radius * sin(CGFloat(indexPath.item) * angleOfEachItem - offsetAngle + angleOfEachItem / 2 - startAngle)
        
        
        attributes.center = CGPoint(x: x, y: y)
        attributes.zIndex = cellCount - indexPath.item
        
        return attributes
    }
    
    override func shouldInvalidateLayout(forBoundsChange newBounds: CGRect) -> Bool {
        return true
    }
    
    override func invalidateLayout() {
        super.invalidateLayout()
    }
    
}
