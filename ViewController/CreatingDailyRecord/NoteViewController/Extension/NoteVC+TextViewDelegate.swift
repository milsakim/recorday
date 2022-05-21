//
//  NoteVC+TextViewDelegate.swift
//  Recorday
//
//  Created by HyeeJee Kim on 2022/04/28.
//

import UIKit

extension NoteViewController: UITextViewDelegate {
    
    func scrollViewWillBeginDragging(_ scrollView: UIScrollView) {
        scrollView.resignFirstResponder()
    }
    
    func textViewShouldBeginEditing(_ textView: UITextView) -> Bool {
        self.addInputAccessoryView()
        return true
    }
    
    func textView(_ textView: UITextView, shouldChangeTextIn range: NSRange, replacementText text: String) -> Bool {
        if range.length == 0 { // 문자를 입력하는 경우
            if text == "#" { // 입력 문자가 #인 경우
                self.isHashTagInserting = true
                self.hashTagRange = (range.location, 1)
                
                if let tagSuggestionView: TagSuggestionView = textView.inputAccessoryView as? TagSuggestionView {
                    tagSuggestionView.keyword = textView.text.substring(of: self.hashTagRange!)
                }
            }
            else if text == " " {
                if let tagSuggestionView: TagSuggestionView = textView.inputAccessoryView as? TagSuggestionView {
                    tagSuggestionView.keyword = nil
                }
            }
            else { // 입력 문자가 #가 아닌 경우
                if self.isHashTagInserting { // 해시 태그 입력 중인 경우
                    if let hashTagRange = self.hashTagRange {
                        self.hashTagRange = (hashTagRange.location, range.location - hashTagRange.location + 1)
                        
                        if let tagSuggestionView: TagSuggestionView = textView.inputAccessoryView as? TagSuggestionView {
                            tagSuggestionView.keyword = textView.text.substring(of: self.hashTagRange!)
                        }
                    }
                }
                else {
                    
                }
            }
        }
        else { // 문자를 삭제하는 경우
            if isHashTagInserting { // 해시 입력 상황인 경우
                if let hashTagRange = self.hashTagRange, range.location == hashTagRange.location {
                    self.isHashTagInserting = false
                    self.hashTagRange = nil
                    
                    if let tagSuggestionView: TagSuggestionView = textView.inputAccessoryView as? TagSuggestionView {
                        tagSuggestionView.keyword = nil
                    }
                }
                else {
                    if let hashTagRange = self.hashTagRange {
                        self.hashTagRange = (hashTagRange.location, range.location - range.length + 1)
                        
                        if let tagSuggestionView: TagSuggestionView = textView.inputAccessoryView as? TagSuggestionView {
                            tagSuggestionView.keyword = textView.text.substring(of: self.hashTagRange!)
                        }
                    }
                }
            }
            else { // 해시 입력 상황이 아닌 경우
                
            }
        }

        return true
    }
    
    func textViewDidChange(_ textView: UITextView) {
        dailyRecordMetadata?.note = textView.text
        
        let cursorLocation: NSRange = self.textView.selectedRange
        let attributedString: NSAttributedString = resolveHashTags(from: textView.text)
        
        self.textView.attributedText = attributedString
        self.textView.selectedRange = cursorLocation
    }
    
    private func resolveHashTags(from string: String) -> NSAttributedString {
        self.hashTagStrings.removeAll()
        
        let words: [String] = string.split(separator: " ").map({ String($0) })
        print("--- word: \(words) ---")
        let attributedString: NSMutableAttributedString = NSMutableAttributedString(string: string)
        attributedString.addAttribute(.foregroundColor, value: UIColor(named: "accent-color")!, range: NSRange(location: 0, length: attributedString.length))
        
        if let customFont: UIFont = UIFont(name: "Pretendard-Regular", size: 15) {
            attributedString.addAttribute(.font, value: customFont, range: NSRange(location: 0, length: attributedString.length))
        }
    
        var location: Int = 0
        
        var tags: [String] = []
        
        for word in words{
            if word.hasPrefix("#") {
                tags.append(word)
                
                let specificRange: NSRange = NSRange(location: location, length: word.count)
                attributedString.addAttribute(.underlineStyle, value: NSUnderlineStyle.single.rawValue, range: specificRange)
            }
            
            location += (word.count + 1)
        }
        
        self.hashTagStrings = tags
        
        return attributedString
    }
    
}

extension String {
    
    func substring(of range: (location: Int, length: Int)) -> String {
        let characters: [Character] = Array(self)
        
        guard range.location < characters.count else {
            return ""
        }
        
        let endLocation: Int = range.location + range.length - 1
        
        if endLocation >= characters.count {
            return String(characters[range.location...])
        }
        print("--- \(range.location) \(endLocation) ---")
        return String(characters[range.location...endLocation])
    }
    
}
