//
//  SelectingActiviesVC+Action.swift
//  Recorday
//
//  Created by HyeJee Kim on 2022/03/07.
//

import UIKit
import CoreData

extension NoteViewController {
    
    // MARK: - Keyboard Related Methods
    
    @objc func keyboardWillShow(_ notification: NSNotification) {
        guard let userInfo = notification.value(forKey: "userInfo") as? NSDictionary, let keyboardFrameEnd = userInfo["UIKeyboardFrameEndUserInfoKey"] as? CGRect else {
            return
        }
        
        var inset = self.scrollView.contentInset
        
        if inset.bottom > 0 {
            print("return")
            return
        }
        
        inset.bottom += keyboardFrameEnd.height
        self.scrollView.contentInset = inset
    }
    
    @objc func keyboardWillHide(_ notification: NSNotification) {
        var inset = self.scrollView.contentInset
        inset.bottom = 0
        self.scrollView.contentInset = inset
    }
    
    func addInputAccessoryView() {
        let nibs = Bundle.main.loadNibNamed("TagSuggestionView", owner: nil, options: nil)
        
        if let tagSuggestionView: TagSuggestionView = nibs?.first as? TagSuggestionView {
            tagSuggestionView.delegate = self
            
            if let tags: [String] = AppDelegate.sharedAppDelegate.coreDataManager.fetchAllTagTitles() {
                tagSuggestionView.addTags(tags)
            }
            
            tagSuggestionView.frame = CGRect(x: 0, y: 0, width: view.bounds.width, height: 50)
            textView.inputAccessoryView = tagSuggestionView
        }
    }

    // MARK: - Bar Button Item Related Methods
    
    @objc func saveButtonTapped() {
        print("--- \(#function) ---")
        // daily record metatdata 기반으로 managed object를 context에 만들고, core data에 저장한다
        createDailyRecord()
        
        // save context
        do {
            try AppDelegate.sharedAppDelegate.coreDataManager.managedContext.save()
            self.dismiss(animated: true, completion: nil)
        }
        catch {
            print("### Failed to save context: \(error) ###")
        }
    }
    
    @objc func cancelButtonTapped(_ sender: Any) {
        if !self.textView.text.isEmpty {
            
        }
        else {
            self.dismiss(animated: true)
        }
    }
    
    func createDailyRecord() {
        guard let metadata: DailyRecordMetadata = dailyRecordMetadata else {
            return
        }
        
        let mainContext: NSManagedObjectContext = AppDelegate.sharedAppDelegate.coreDataManager.managedContext
        
        // Day managed object가 DB에 있는지 확인하고 없다면 생성한다
        let dayFetchRequest: NSFetchRequest<Day> = Day.fetchRequest()
        dayFetchRequest.predicate = NSPredicate(format: "%K = %@", argumentArray: [#keyPath(Day.timestamp), metadata.dateTimestamp])
        
        do {
            let fetchResult: [Day] = try mainContext.fetch(dayFetchRequest)
            
            let day: Day
            
            if fetchResult.isEmpty {
                day = Day(context: mainContext)
                day.timestamp = metadata.dateTimestamp
            }
            else {
                day = fetchResult[0]
            }
            
            // DailyRecord managed object를 생성한다
            let dailyRecord: DailyRecord = DailyRecord(context: mainContext)
            dailyRecord.id = UUID()
            dailyRecord.mood = metadata.moodID
            dailyRecord.timestamp = metadata.timeTimestamp
            dailyRecord.note = textView.text
            
            // dailyRecord.note, dailyRecord.tag 처리 관련 코드 추가하기
            print("--- \(hashTagStrings) ---")
            for hashTagString in self.hashTagStrings {
                let tagFetchRequest: NSFetchRequest<Tag> = Tag.fetchRequest()
                tagFetchRequest.predicate = NSPredicate(format: "%K = %@", argumentArray: [#keyPath(Tag.title), hashTagString])
                
                let tagFetchResult: [Tag] = try mainContext.fetch(tagFetchRequest)
                
                let tag: Tag
                
                if tagFetchResult.isEmpty {
                    tag = Tag(context: mainContext)
                    tag.id = UUID()
                    tag.title = hashTagString
                }
                else {
                    tag = tagFetchResult[0]
                }
                
                // daily record와 tag 관계 맺어주기
                tag.addToDailyRecords(dailyRecord)
                dailyRecord.addToTags(tag)
            }
            
            // Day와 DailyRecord relation 연결 시켜주기
            day.addToDailyRecords(dailyRecord)
            dailyRecord.day = day
        } catch {
            // 사용자에게 오류가 생겼음을 전달한다
        }
    }
    
    // MARK: - Date Picker
    
    @IBAction func datePickerButtonTapped(_ sender: Any) {
        self.textView.resignFirstResponder()
        
        datePickerView.isHidden = false
        
        self.dimmedView?.isHidden = false
        
        let dimmedViewAnimation: UIViewPropertyAnimator = UIViewPropertyAnimator(duration: 0.5, curve: .easeInOut) {
            self.dimmedView?.alpha = 0.6
        }
        dimmedViewAnimation.startAnimation()
    }
    
    @IBAction func datePickerViewDoneButtonTapped(_ sender: Any) {
        print("--- \(#function) ---")
        
        datePickerView.isHidden = true
        
        let disappearAnimation: UIViewPropertyAnimator = UIViewPropertyAnimator(duration: 0.5, curve: .easeInOut) {
            self.dimmedView?.alpha = 0.0
        }
        disappearAnimation.addCompletion { _ in
            self.dimmedView?.isHidden = true
        }
        disappearAnimation.startAnimation()
    }
    
    
    @objc func datePickerChanged(_ sender: Any) {
        let dateFormatter: DateFormatter = DateFormatter()
        dateFormatter.dateFormat = "yy.MM.dd hh:mm"
        self.datePickerButton.setTitle("\(dateFormatter.string(from: self.datePicker.date))", for: .normal)
        self.datePickerButton.titleLabel?.font = UIFont(name: "Pretendard-Bold", size: 15)
        
        //
    }
    
    // MARK: - Image View Tap Gesture Recognizer Handler
    
    @objc func handleImageViewTap(_ sender: Any) {
        guard let metatData = self.dailyRecordMetadata else {
            self.imageView.image = UIImage(named: "0-big")
            return
        }
        
        var index: Int = 0
        
        for mood in Mood.moods {
            if metatData.moodID == mood.id {
                break
            }
            
            index += 1
        }
        
        let nextIndex: Int = (index + 1) % Mood.moods.count
        self.dailyRecordMetadata?.moodID = Mood.moods[nextIndex].id
        self.imageView.image = UIImage(named: "\(Mood.moods[nextIndex].id)-big")
    }
    
    // MARK: -
    
    @objc func dimmedViewTapped(_ sender: Any) {
        print(#function)
    }
    
}

extension NoteViewController: UIPopoverPresentationControllerDelegate {
    
}
