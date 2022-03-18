//
//  RecordListViewController.swift
//  Recorday
//
//  Created by HyeJee Kim on 2022/03/01.
//

import UIKit
import CoreData

class RecordListViewController: UIViewController {
    
    // MARK: - Outlet
    
    @IBOutlet weak var tableView: UITableView!
    
    // MARK: - Property
    
    lazy var fetchedResultsController: NSFetchedResultsController<DailyRecord>? = {
        let context = AppDelegate.sharedAppDelegate.coreDataManager.managedContext
        let fetchRequest: NSFetchRequest = DailyRecord.fetchRequest()
        fetchRequest.sortDescriptors = [NSSortDescriptor(key: #keyPath(DailyRecord.date), ascending: false), NSSortDescriptor(key: #keyPath(DailyRecord.time), ascending: false)]
        
        let fetchedResultsController: NSFetchedResultsController = NSFetchedResultsController(fetchRequest: fetchRequest, managedObjectContext: context, sectionNameKeyPath: #keyPath(DailyRecord.date), cacheName: nil)
        fetchedResultsController.delegate = self
        
        do {
            try fetchedResultsController.performFetch()
        } catch  {
            print("--- Fetched result ---")
        }
        
        return fetchedResultsController
    }()
    
    let dateFormatter: DateFormatter = {
        let dateFormatter: DateFormatter = DateFormatter()
        dateFormatter.dateFormat = "HH:mm"
        return dateFormatter
    }()
    
    // MARK: - Initializer
    
    required init?(coder: NSCoder) {
        super.init(coder: coder)
        print("--- RecordListViewController \(#function) ---")
        self.title = "Records"
        self.tabBarItem = UITabBarItem(title: "Home", image: UIImage(systemName: "doc.on.doc"), selectedImage: UIImage(systemName: "doc.on.doc"))
    }
    
    // MARK: - Deinit
    
    deinit {
        print("--- deinit RecordListViewController ---")
    }
    
    // MARK: - View Life Cycle
    
    override func viewDidLoad() {
        super.viewDidLoad()
        print(#function)
        self.commonInit()
    }
    
    override func viewWillAppear(_ animated: Bool) {
        super.viewWillAppear(animated)
        print(#function)
        self.fetchChanges()
    }
    
    // MARK: - Set Up RecordListViewController
    
    func commonInit() {
        self.setUpTableView()
        NotificationCenter.default.addObserver(self, selector: #selector(fetchChanges), name: .NSPersistentStoreRemoteChange, object: AppDelegate.sharedAppDelegate.coreDataManager.persistentContainer.persistentStoreCoordinator)
    }
    
}
