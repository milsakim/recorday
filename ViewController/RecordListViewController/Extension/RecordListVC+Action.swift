//
//  RecordListVC+Action.swift
//  Recorday
//
//  Created by HyeJee Kim on 2022/03/07.
//

import UIKit
import CoreData

extension RecordListViewController {
    
    @IBAction func createDailyRecord(_ sender: Any) {
        guard let button: UIButton = sender as? UIButton else {
            return
        }
        
        if button.isSelected {
            self.hideMoods()
        }
        else {
            self.showMoods()
        }
        
        button.isSelected = !button.isSelected
    }
    
    @objc func dimmedViewTapped(_ sender: Any) {
        guard let _ = sender as? UITapGestureRecognizer else {
            return
        }
        
        if self.addButton.isSelected {
            self.hideMoods()
        }
        else {
            self.showMoods()
        }
        
        self.addButton.isSelected = !self.addButton.isSelected
    }

    func showMoods() {
        self.dimmedView?.isHidden = false
        
        let propertyAnimator: UIViewPropertyAnimator = UIViewPropertyAnimator(duration: 0.4, curve: .easeInOut) {
            let transform = self.addButton.transform
            self.addButton.transform = transform.rotated(by: .pi / 4 + .pi)
            
            self.dimmedView?.alpha = 0.6
            
            self.collectionViewWidthConstraint.constant = 300
            self.view.layoutIfNeeded()
        }
        
        propertyAnimator.startAnimation()
    }
    
    func hideMoods() {
        let propertyAnimator: UIViewPropertyAnimator = UIViewPropertyAnimator(duration: 0.4, curve: .easeInOut) {
            let transform = self.addButton.transform
            self.addButton.transform = transform.rotated(by: -(.pi / 4 + .pi))
            
            self.dimmedView?.alpha = 0
            
            self.collectionViewWidthConstraint.constant = 0
            self.view.layoutIfNeeded()
        }
        propertyAnimator.addCompletion({ _ in
            self.dimmedView?.isHidden = true
        })
        
        propertyAnimator.startAnimation()
    }
    
    // MARK: - Navigation Bar Button Action
    
    @objc func settingButtonTapped(_ sender: Any) {
        print(#function)
        
        let storyboard: UIStoryboard = UIStoryboard(name: "SettingsViewController", bundle: .main)
        let viewController = storyboard.instantiateViewController(withIdentifier: "SettingsViewController")
        self.present(viewController, animated: true)
    }
    
    @objc func tagFilteringButtonTapped(_ sender: Any) {
        if let firstView = Bundle.main.loadNibNamed("TagFilterView", owner: nil, options: nil)?.first as? TagFilterView {
            self.navigationController?.view.addSubview(firstView)
            firstView.frame = self.view.frame
            firstView.delegate = self
            
            let fetchRequest: NSFetchRequest<Tag> = Tag.fetchRequest()
            fetchRequest.sortDescriptors = [NSSortDescriptor(keyPath: \Tag.title, ascending: true)]
            
            do {
                let context: NSManagedObjectContext = AppDelegate.sharedAppDelegate.coreDataManager.managedContext
                let fetchResult = try context.fetch(fetchRequest)
                firstView.tags = fetchResult.compactMap({ $0.title })
            }
            catch {
                print("--- Failed to fetch tags ---")
            }
        }
        
    }

    func addWeatherData(_ weatherData: [DailyWeather]) {
        let context: NSManagedObjectContext = AppDelegate.sharedAppDelegate.coreDataManager.managedContext
        
        for weatherDatum in weatherData {
            guard let timeStamp: Double = getDateTimestamp(from: weatherDatum.dt) else {
                continue
            }
            
            let fetchRequest: NSFetchRequest<Day> = Day.fetchRequest()
            fetchRequest.predicate = NSPredicate(format: "%K = %@", argumentArray: [#keyPath(Day.timestamp), timeStamp])
            
            do {
                let fetchResult: [Day] = try context.fetch(fetchRequest)
                
                let day: Day
                
                if fetchResult.isEmpty {
                    day = Day(context: context)
                    day.timestamp = timeStamp
                }
                else {
                    day = fetchResult[0]
                }
                
                if  weatherDatum.weather.isEmpty {
                    continue
                }
                
                day.weatherID = "\(weatherDatum.weather[0].id)"
                day.weatherIconID = weatherDatum.weather[0].icon
            }
            catch {
                print("--- Fetch Error ---")
            }
        }
        
        do {
            if context.hasChanges {
                try context.save()
            }
        }
        catch {
            print("--- Failed to save context ---")
        }
    }
    
    func getDateTimestamp(from timestamp: Double) -> Double? {
        let date: Date = Date(timeIntervalSince1970: timestamp)
        
        let dateFormatter: DateFormatter = DateFormatter()
        dateFormatter.dateFormat = "yyyy-MM-dd"
        
        guard let convertedDate: Date = dateFormatter.date(from: dateFormatter.string(from: date)) else {
            return nil
        }
        
        return convertedDate.timeIntervalSince1970
    }
    
    func showAlert(actionHandler: @escaping (Bool) -> Void) {
        let alertController: UIAlertController = UIAlertController(title: "정말 삭제하시겠습니까?", message: nil, preferredStyle: .alert)
        
        let cancelAction: UIAlertAction = UIAlertAction(title: "Cancel", style: .cancel, handler: { action in
            actionHandler(false)
        })
        
        let deleteAction: UIAlertAction = UIAlertAction(title: "Delete", style: .destructive, handler: { action in
            actionHandler(true)
        })
        
        alertController.addAction(cancelAction)
        alertController.addAction(deleteAction)
        
        self.present(alertController, animated: true)
    }
    
}
