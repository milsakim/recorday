//
//  ActivityInputTableViewCell.swift
//  Recorday
//
//  Created by HyeeJee Kim on 2022/03/15.
//

import UIKit

protocol ActivityInputTableViewCellDelegate: AnyObject {
    func textViewHeightDidChange(to height: CGFloat)
}

final class ActivityInputTableViewCell: UITableViewCell {
    
    // MARK: - Outlet
    
    @IBOutlet weak var activityInputTextView: UITextView!
    
    // MARK: - Property
    
    static let reuseID: String = "ActivityInputTableViewCell"
    
    weak var delegate: ActivityInputTableViewCellDelegate?
    
    private var startIndex: Int?
    private var tagRanges: [NSRange] = []
    
    var hashTagAttribute: [NSAttributedString.Key: Any] = {
        return [NSAttributedString.Key.foregroundColor: UIColor.red,
                NSAttributedString.Key.font: UIFont.boldSystemFont(ofSize: 14),
                NSAttributedString.Key.underlineStyle: NSNumber(value: 0)]
    }()
    
    override func awakeFromNib() {
        super.awakeFromNib()
        activityInputTextView.delegate = self
        activityInputTextView.layer.cornerRadius = 10.0
        activityInputTextView.layer.borderColor = UIColor.red.cgColor
        activityInputTextView.layer.borderWidth = 1.5
        activityInputTextView.text = "#"
    }
    
    override func setSelected(_ selected: Bool, animated: Bool) {
        super.setSelected(selected, animated: animated)
        
        // Configure the view for the selected state
    }
    
}

extension ActivityInputTableViewCell: UITextViewDelegate {
    
    func textViewDidBeginEditing(_ textView: UITextView) {
        
    }
    
    func textView(_ textView: UITextView, shouldChangeTextIn range: NSRange, replacementText text: String) -> Bool {
        print("--- \(#function): \(range), \(text) ---")
        
        var isEditingExistingTag: Bool = false
        
        for tagRange in tagRanges {
            if tagRange.contains(range.location) {
                isEditingExistingTag = true
            }
        }
        
        if isEditingExistingTag {
            return true
        }
        else {
            // deleting text
            if range.length > 0 {
                if range.location == 0 {
                    return false
                }
                
                return true
            }
            // inserting text
            else {
                if text == " " {
                    guard let start = startIndex else {
                        return false
                    }
                    
                    tagRanges.append(NSRange(location: start, length: range.location - start + 1))
                    startIndex = nil
                    
                    return true
                }
                
                guard text.range(of: "[~!@#\\$%\\^&\\*;:\'\"]*", options: .regularExpression) != nil else {
                    return false
                }
                
                if startIndex == nil {
                    startIndex = range.location
                }
                
                return true
            }
        }
    }
    
    func textViewDidChange(_ textView: UITextView) {
        print("--- \(#function) ---")
        
        if startIndex == nil {
            textView.text = textView.text + "#"
            applyHasTagAttributes()
        }
        
        delegate?.textViewHeightDidChange(to: textView.contentSize.height)
    }
    
    func applyHasTagAttributes() {
        print("--- \(#function) ---")
        let attributedString = NSMutableAttributedString(string: activityInputTextView.text)
        
        for tagRange in tagRanges {
            attributedString.addAttributes(hashTagAttribute, range: tagRange)
            print(tagRange)
        }
        
        activityInputTextView.attributedText = attributedString
    }
    
}
