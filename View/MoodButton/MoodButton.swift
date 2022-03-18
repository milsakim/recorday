//
//  MoodButton.swift
//  Recorday
//
//  Created by HyeJee Kim on 2022/03/04.
//

import UIKit

protocol MoodButtonDelegate: AnyObject {
    func didSelect(of mood: Mood)
    func didDeselect(of mood: Mood)
}

class MoodButton: UIImageView {
    
    // MARK: - Property
    
    var isSelected: Bool = false {
        didSet {
            updateImage()
        }
    }
    
    weak var delegate: MoodButtonDelegate?
    
    var mood: Mood?
    
    @IBInspectable var normalImage: UIImage?
    @IBInspectable var selectedImage: UIImage?
    
    // MARK: - Initialize
    
    required init?(coder: NSCoder) {
        super.init(coder: coder)
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
        
        if delegate != nil {
            delegate = nil
        }
        
        print("--- \(#function) MoodButton ---")
    }

    // MARK: - Responding to Touch Events

    override func touchesEnded(_ touches: Set<UITouch>, with event: UIEvent?) {
        print("--- \(#function) ---")
        
        if self.isSelected {
            self.isSelected = false
            
            if let mood = mood {
                delegate?.didDeselect(of: mood)
            }
        }
        else {
            self.isSelected = true
            
            if let mood = mood {
                delegate?.didSelect(of: mood)
            }
        }
    }
    
    // MARK: - Updating Image
    
    private func updateImage() {
        print("--- \(#function) ---")
        
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
