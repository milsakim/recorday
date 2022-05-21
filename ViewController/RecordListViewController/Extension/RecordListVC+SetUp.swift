//
//  RecordListVC+SetUp.swift
//  Recorday
//
//  Created by HyeJee Kim on 2022/03/03.
//

import UIKit
import CoreLocation

extension RecordListViewController {
    
    func setUpViewModel() {
        self.viewModel = RecordListViewModel()
        self.viewModel?.delegate = self
        self.viewModel?.fetchChanges()
    }
    
    func setUpTableView() {
        tableView.dataSource = self
        tableView.delegate = self
        tableView.rowHeight = UITableView.automaticDimension
        tableView.estimatedRowHeight = 300
        tableView.sectionHeaderHeight = 30
        tableView.register(DailyRecordListHeaderView.self, forHeaderFooterViewReuseIdentifier: DailyRecordListHeaderView.reuseID)
        tableView.register(UINib(nibName: "DailyRecordCell", bundle: .main), forCellReuseIdentifier: DailyRecordCell.reuseID)
    }
    
    func setUpLocationManager() {
        locationManager.delegate = self
        
        if CLLocationManager.locationServicesEnabled() {
            switch locationManager.authorizationStatus {
            case .authorizedAlways:
                print("Always")
                locationManager.startUpdatingLocation()
            case .authorizedWhenInUse:
                print("When in use")
                locationManager.startUpdatingLocation()
            case .denied:
                print("Denied")
                locationManager.requestWhenInUseAuthorization()
            case .notDetermined:
                locationManager.requestWhenInUseAuthorization()
            default:
                print("\(locationManager.authorizationStatus)")
            }
        }
        else {
            print("Disabled")
        }
    }
    
    func setUpNavigation() {
        guard self.navigationController != nil else {
            return
        }
        
        self.navigationController?.navigationBar.barTintColor = UIColor(named: "main-color")
        
        navigationItem.leftBarButtonItem = UIBarButtonItem(image: UIImage(named: "settings-button"), style: .plain, target: self, action: #selector(settingButtonTapped))
        navigationItem.leftBarButtonItem?.tintColor = UIColor(named: "accent-color")
        
        navigationItem.rightBarButtonItem = UIBarButtonItem(image: UIImage(named: "settings-button"), style: .plain, target: self, action: #selector(tagFilteringButtonTapped))
        navigationItem.leftBarButtonItem?.tintColor = UIColor(named: "accent-color")
    }
    
    func setUpCollectionView() {
        print(#function)
        self.collectionView.register(UINib(nibName: MoodCollectionViewCell.reuseID, bundle: .main), forCellWithReuseIdentifier: MoodCollectionViewCell.reuseID)
        self.collectionView.dataSource = self
        self.collectionView.delegate = self
    }
    
    func setUpDimmedView() {
        dimmedView = UIView(frame: .zero)
        dimmedView?.backgroundColor = UIColor(named: "main-color")
        dimmedView?.isHidden = true
        dimmedView?.alpha = 0
        dimmedView?.translatesAutoresizingMaskIntoConstraints = false
        
        guard let dimmedView = dimmedView else {
            return
        }
        
        self.view.insertSubview(dimmedView, belowSubview: self.collectionView)
        
        dimmedView.topAnchor.constraint(equalTo: self.view.topAnchor).isActive = true
        dimmedView.bottomAnchor.constraint(equalTo: self.view.bottomAnchor).isActive = true
        dimmedView.trailingAnchor.constraint(equalTo: self.view.trailingAnchor).isActive = true
        dimmedView.leadingAnchor.constraint(equalTo: self.view.leadingAnchor).isActive = true
        
        let tapRecognizer: UITapGestureRecognizer = UITapGestureRecognizer(target: self, action: #selector(dimmedViewTapped))
        dimmedView.addGestureRecognizer(tapRecognizer)
    }
    
}
