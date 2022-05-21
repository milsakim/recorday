//
//  RecordListViewController.swift
//  Recorday
//
//  Created by HyeJee Kim on 2022/03/01.
//

import UIKit
import CoreData
import CoreLocation

class RecordListViewController: UIViewController {
    
    // MARK: - Outlet
    
    @IBOutlet weak var tableView: UITableView!
    @IBOutlet weak var collectionView: UICollectionView!
    @IBOutlet weak var collectionViewWidthConstraint: NSLayoutConstraint!
    @IBOutlet weak var addButton: UIButton!

    // MARK: - Property
    
    static let storyboardID: String = "RecordListViewController"
    
    let locationManager: CLLocationManager = CLLocationManager()
    
    let dateFormatter: DateFormatter = {
        let dateFormatter: DateFormatter = DateFormatter()
        dateFormatter.dateFormat = "HH:mm"
        return dateFormatter
    }()
    
    var viewModel: RecordListViewModel?
    
    var dimmedView: UIView?
    
    // MARK: - Initializer
    
    required init?(coder: NSCoder) {
        super.init(coder: coder)
        print("--- RecordListViewController \(#function) ---")
    }
    
    // MARK: - Deinit
    
    deinit {
        print("--- deinit RecordListViewController ---")
    }
    
    // MARK: - View Life Cycle
    
    override func viewDidLoad() {
        super.viewDidLoad()
        commonInit()
    }
    
    override func viewWillAppear(_ animated: Bool) {
        super.viewWillAppear(animated)
    }
    
    // MARK: - Set Up RecordListViewController
    
    func commonInit() {
        setUpTableView()
        setUpLocationManager()
        setUpNavigation()
        setUpCollectionView()
        setUpViewModel()
        setUpDimmedView()
    }
    
}

extension RecordListViewController: RecordListViewModeleDelegate {
    func didUpdateData() {
        DispatchQueue.main.async {
            self.tableView.reloadData()
        }
    }
}
