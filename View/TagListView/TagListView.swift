//
//  TagListView.swift
//  Recorday
//
//  Created by HyeJee Kim on 2022/03/01.
//

import UIKit

class TagListView: UIView {
    
    // MARK: - Property
    
    private(set) var tagLabels: [UILabel] = []
    var tagFont: UIFont = .systemFont(ofSize: 12)

    // MARK: - Deinitialize
    
    deinit {
        print(#function)
    }
    
    override func draw(_ rect: CGRect) {
        print("TagListView: \(#function)")
        print("rect: \(rect)")
    }
    
    override func layoutSubviews() {
        super.layoutSubviews()
        print(#function)
        rearrangeTagLabels()
    }
    
    private func rearrangeTagLabels() {
        print(#function)

        // Remove all subviews
        tagLabels.forEach {
            $0.removeFromSuperview()
        }
        
        var xPosition: CGFloat = 0
        var yPosition: CGFloat = 0
        
        for tagLabel in tagLabels {
            if let tagString = tagLabel.text {
                let tagStringSize: CGSize = (tagString as NSString).size(withAttributes: [NSAttributedString.Key.font: tagFont])
                
                if CGFloat(xPosition) + (tagStringSize.width + 4 + 16) >= self.frame.width {
                    xPosition = 0
                    yPosition += (tagStringSize.height + 4 + 4)
                }
                
                tagLabel.frame = CGRect(x: xPosition, y: yPosition, width: tagStringSize.width + 16, height: tagStringSize.height + 4)
                self.addSubview(tagLabel)
                
                xPosition += (tagStringSize.width + 4 + 16)
            }
        }
        
//        self.bounds = CGRect(x: self.bounds.origin.x, y: self.bounds.origin.y, width: self.bounds.width, height: tagLabels.last?.frame.maxY ?? 0.0)
        print(bounds)
        
    }
    
    func addTags(titles: [String]) {
        print(#function)
        defer {
            rearrangeTagLabels()
        }
        
        for title in titles {
            let tagLabel: UILabel = UILabel(frame: .zero)
            tagLabel.text = title
            tagLabel.font = tagFont
            tagLabel.textColor = .white
            tagLabel.textAlignment = .center
            tagLabel.backgroundColor = .red
            tagLabel.layer.cornerRadius = 5
            tagLabel.clipsToBounds = true
            self.tagLabels.append(tagLabel)
        }
    }

}
