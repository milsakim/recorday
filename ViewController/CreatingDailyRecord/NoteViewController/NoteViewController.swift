//
//  SelectingActivitiesViewController.swift
//  Recorday
//
//  Created by HyeJee Kim on 2022/03/04.
//

import UIKit

class NoteViewController: UIViewController {
    
    static let reuseID: String = "NoteViewController"
    
    // MARK: - Outlet
    
    @IBOutlet weak var navigationBar: UINavigationBar!
    @IBOutlet weak var scrollView: UIScrollView!
    @IBOutlet weak var textViewBackground: UIView!
    @IBOutlet weak var textView: UITextView!
    @IBOutlet weak var imageView: UIImageView!
    @IBOutlet weak var datePickerButton: UIButton!
    @IBOutlet var datePickerView: UIView!
    @IBOutlet weak var datePicker: UIDatePicker!
    
    // MARK: - Property
    
    var dailyRecordMetadata: DailyRecordMetadata?
    var hashTagStrings: [String] = []
    var isHashTagInserting: Bool = false
    var hashTagRange: (location: Int, length: Int)?
    var dimmedView: UIView?
    
    required init?(coder: NSCoder) {
        super.init(coder: coder)
        print(#function)
    }
    
    // MARK: - Deinitializer
    
    deinit {
        print("--- deinit SelectingActivitiesViewController ---")
    }
    
    // MARK: - View Life Cycle
    
    override func viewDidLoad() {
        super.viewDidLoad()
        commonInit()

        self.textView.becomeFirstResponder()
    }

    override func traitCollectionDidChange(_ previousTraitCollection: UITraitCollection?) {
        super.traitCollectionDidChange(previousTraitCollection)
        self.datePickerView.layer.borderColor = UIColor(named: "accent-color")?.cgColor
    }

    private func commonInit() {
        setUpUI()
        setupNavigation()
        setupTextView()
        setupKeyboardNotification()
        textViewBackground.layer.borderWidth = 3
        textViewBackground.layer.borderColor = UIColor(named: "accent-color")?.cgColor
    }
    
}

