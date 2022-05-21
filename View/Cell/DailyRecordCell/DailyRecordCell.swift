//
//  DailyRecordCell.swift
//  Recorday
//
//  Created by HyeeJee Kim on 2022/05/06.
//

import UIKit

class DailyRecordCell: UITableViewCell {
    
    // MARK: - Property
    
    static let reuseID: String = "DailyRecordCell"
    
    // MARK: - Outlet
    
    @IBOutlet weak var contentBackground: UIView!
    @IBOutlet weak var moodImageView: UIImageView!
    @IBOutlet weak var textView: UITextView!
    @IBOutlet weak var timeLabel: UILabel!
    
    
    // MARK: - Nested Type
    
    override func awakeFromNib() {
        super.awakeFromNib()
        
        self.backgroundColor = .clear
        
        textView.delegate = self
        
        self.contentBackground.layer.borderWidth = 1.0
        self.contentBackground.layer.borderColor = UIColor(named: "accent-color")?.cgColor
    }
    
    override func traitCollectionDidChange(_ previousTraitCollection: UITraitCollection?) {
        super.traitCollectionDidChange(previousTraitCollection)
        self.contentBackground.layer.borderColor = UIColor(named: "accent-color")?.cgColor
    }

    override func setSelected(_ selected: Bool, animated: Bool) {
        super.setSelected(selected, animated: animated)

        // Configure the view for the selected state
    }
    
    override func prepareForReuse() {
        super.prepareForReuse()

        self.moodImageView.image = nil
        self.textView.attributedText = nil
        self.textView.text = nil
    }
    
}

// MARK: - Configuration

extension DailyRecordCell {
    
    func setMood(of id: String?) {
        if let id: String = id, let mood: Mood = Mood.moods.filter({ $0.id == id }).first {
            self.moodImageView.image = UIImage(named: id)
        }
        else {

        }
    }
    
    func setNote(_ memo: String) {
        // Attributed string으로 변환
        let attributedString: NSAttributedString = resolveHashTags(from: memo)
        
        // text view에 적용
        self.textView.attributedText = attributedString
    }
    
    private func resolveHashTags(from string: String) -> NSAttributedString {
        let words: [String] = string.split(separator: " ").map({ String($0) })
        let attributedString: NSMutableAttributedString = NSMutableAttributedString(string: string)
        
        if let font: UIFont = UIFont(name: "Pretendard-Regular", size: 12) {
            let attributes = [
                NSAttributedString.Key.font: font,
                NSAttributedString.Key.foregroundColor: UIColor(named: "accent-color")
            ]
            attributedString.addAttributes(attributes as [NSAttributedString.Key : Any], range: NSRange(location: 0, length: attributedString.length))
        }
        
        let nsText: NSString = string as NSString
        
        for word in words {
            if word.hasPrefix("#") {
                let specificRange: NSRange = nsText.range(of: word as String)
                
                if let stringifiedWord = String(word.dropFirst()).addingPercentEncoding(withAllowedCharacters: .urlHostAllowed) {
                    attributedString.addAttribute(NSAttributedString.Key.link, value: "hash:\(stringifiedWord)", range: specificRange)
                    attributedString.addAttribute(.underlineStyle, value: NSUnderlineStyle.single.rawValue, range: specificRange)
                }
            }
        }
        
        return attributedString
    }
    
}

// MARK: - Text View Delegate

extension DailyRecordCell: UITextViewDelegate {
    
    func textView(_ textView: UITextView, shouldInteractWith URL: URL, in characterRange: NSRange, interaction: UITextItemInteraction) -> Bool {
        if let urlString: String = URL.absoluteString.removingPercentEncoding {
            print("--- Tag Touched: \(URL) ---")
            
            if urlString.hasPrefix("hash:") {
                print("--- Hash Tag: \(urlString) ---")
            }
        }
        
        return true
    }
    
}
