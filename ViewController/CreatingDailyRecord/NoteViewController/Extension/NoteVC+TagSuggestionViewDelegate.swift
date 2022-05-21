//
//  NoteVC+TagSuggestionViewDelegate.swift
//  Recorday
//
//  Created by HyeeJee Kim on 2022/05/13.
//

import UIKit

extension NoteViewController: TagSuggestionViewDelegate {
    
    func didSelectTag(of title: String) {
        guard let range: (location: Int, length: Int) = self.hashTagRange else {
            return
        }
        
        print("--- select: \(title), current cursor position: \(self.textView.selectedRange) ---")
        
        let attributedString: NSMutableAttributedString = NSMutableAttributedString(attributedString: self.textView.attributedText)
        attributedString.replaceCharacters(in: NSRange(location: range.location, length: range.length), with: title)
        
        self.textView.attributedText = attributedString
    }
    
}
