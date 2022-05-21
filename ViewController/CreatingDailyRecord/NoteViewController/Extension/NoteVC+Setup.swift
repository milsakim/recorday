//
//  SelectingActivitiesVC+Setup.swift
//  Recorday
//
//  Created by HyeJee Kim on 2022/03/07.
//

import UIKit

extension NoteViewController {
    
    func setUpUI() {
        guard let metadata = self.dailyRecordMetadata else {
            return
        }
        
        let dateFormatter: DateFormatter = DateFormatter()
        dateFormatter.dateFormat = "yy.MM.dd hh:mm"
        let date: Date = Date(timeIntervalSince1970: metadata.dateTimestamp + metadata.timeTimestamp)
        self.datePickerButton.setTitle("\(dateFormatter.string(from: date))", for: .normal)
        self.datePickerButton.titleLabel?.font = UIFont(name: "Pretendard-Bold", size: 15)
        
        self.imageView.image = UIImage(named: "\(metadata.moodID)-big")
        self.imageView.isUserInteractionEnabled = true
        let tapGestureRecognizer: UITapGestureRecognizer = UITapGestureRecognizer(target: self, action: #selector(handleImageViewTap))
        self.imageView.addGestureRecognizer(tapGestureRecognizer)
        
        self.dimmedView = UIView()
        dimmedView = UIView(frame: .zero)
        dimmedView?.backgroundColor = UIColor(named: "main-color")
        dimmedView?.isHidden = true
        dimmedView?.alpha = 0
        dimmedView?.translatesAutoresizingMaskIntoConstraints = false
        
        guard let dimmedView = dimmedView else {
            return
        }
        
        self.view.insertSubview(dimmedView, belowSubview: self.datePicker)
        
        dimmedView.topAnchor.constraint(equalTo: self.view.topAnchor).isActive = true
        dimmedView.bottomAnchor.constraint(equalTo: self.view.bottomAnchor).isActive = true
        dimmedView.trailingAnchor.constraint(equalTo: self.view.trailingAnchor).isActive = true
        dimmedView.leadingAnchor.constraint(equalTo: self.view.leadingAnchor).isActive = true
        
        let tapRecognizer: UITapGestureRecognizer = UITapGestureRecognizer(target: self, action: #selector(dimmedViewTapped))
        dimmedView.addGestureRecognizer(tapRecognizer)
        
        // date picker view constraint
        self.datePickerView.translatesAutoresizingMaskIntoConstraints = false
        self.datePickerView.layer.borderWidth = 3
        self.datePickerView.layer.borderColor = UIColor(named: "accent-color")?.cgColor
        
        self.view.addSubview(self.datePickerView)
        
//        datePickerView.bottomAnchor.constraint(equalTo: self.view.safeAreaLayoutGuide.bottomAnchor).isActive = true
//        datePickerView.leadingAnchor.constraint(equalTo: self.view.safeAreaLayoutGuide.leadingAnchor).isActive = true
//        datePickerView.trailingAnchor.constraint(equalTo: self.view.safeAreaLayoutGuide.trailingAnchor).isActive = true
        datePickerView.leadingAnchor.constraint(equalTo: self.view.safeAreaLayoutGuide.leadingAnchor, constant: 16).isActive = true
        datePickerView.trailingAnchor.constraint(equalTo: self.view.safeAreaLayoutGuide.trailingAnchor, constant: -16).isActive = true
        datePickerView.centerYAnchor.constraint(equalTo: self.view.safeAreaLayoutGuide.centerYAnchor).isActive = true
        datePickerView.heightAnchor.constraint(equalToConstant: 200).isActive = true
        
        datePickerView.isHidden = true
        
        // add date picker action
        datePicker.addTarget(self, action: #selector(datePickerChanged), for: .valueChanged)
    }
    
    func setupNavigation() {
        let customNavigationItme: UINavigationItem = UINavigationItem(title: "")
        
        let saveButton: UIBarButtonItem = UIBarButtonItem(title: "Save", style: .done, target: self, action: #selector(saveButtonTapped))
        customNavigationItme.setRightBarButton(saveButton, animated: false)
        
        let cancelButton: UIBarButtonItem = UIBarButtonItem(title: "Cancel", style: .plain, target: self, action: #selector(cancelButtonTapped))
        customNavigationItme.setLeftBarButton(cancelButton, animated: false)
        
        customNavigationItme.rightBarButtonItem?.tintColor = UIColor(named: "accent-color")
        customNavigationItme.leftBarButtonItem?.tintColor = UIColor(named: "accent-color")
        
        self.navigationBar.setItems([customNavigationItme], animated: true)
    }
    
    func setupTextView() {
        textView.delegate = self
        textView.text = dailyRecordMetadata?.note
    }
    
    func setupKeyboardNotification() {
        let notificationCenter = NotificationCenter.default
        notificationCenter.addObserver(self, selector: #selector(keyboardWillHide), name: UIResponder.keyboardWillHideNotification, object: nil)
        notificationCenter.addObserver(self, selector: #selector(keyboardWillShow), name: UIResponder.keyboardWillShowNotification, object: nil)
    }
    
}
