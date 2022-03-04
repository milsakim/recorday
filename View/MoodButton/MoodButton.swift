//
//  MoodButton.swift
//  Recorday
//
//  Created by HyeJee Kim on 2022/03/04.
//

import UIKit

protocol MoodButtonDelegate: AnyObject {
    
}

class MoodButton: UIImageView {
    
    // MARK: - Property
    
    var isSelected: Bool = false {
        didSet {
            updateImage()
        }
    }
    
    @IBInspectable var normalImage: UIImage?
    @IBInspectable var selectedImage: UIImage?
    
    // MARK: - Initialize
    
    required init?(coder: NSCoder) {
        super.init(coder: coder)
        print("--- \(#function) ---")
        self.isUserInteractionEnabled = true
    }
    
    // MARK: - Deinitialize
    
    deinit {
        if normalImage != nil {
            normalImage = nil
        }
        
        if selectedImage != nil {
            selectedImage = nil
        }
        
        if self.image != nil {
            self.image = nil
        }
        
        print("--- \(#function) ---")
    }

    // MARK: - Responding to Touch Events

    override func touchesEnded(_ touches: Set<UITouch>, with event: UIEvent?) {
        print("--- \(#function) ---")
        
        defer {
            self.updateImage()
        }
        
        if self.isSelected {
            self.isSelected = false
        }
        else {
            self.isSelected = true
        }
    }
    
    // MARK: - Updating Image
    
    private func updateImage() {
        if isSelected {
            guard let selectedImage = selectedImage else {
                return
            }

            self.image = selectedImage
        }
        else {
            guard let normalImage = normalImage else {
                return
            }
            
            self.image = normalImage
        }
    }

}
