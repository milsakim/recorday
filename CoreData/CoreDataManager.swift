//
//  CoreDataManager.swift
//  Recorday
//
//  Created by HyeJee Kim on 2022/03/04.
//

import UIKit
import CoreData

class CoreDataManager {
    
    // MARK: - Property
    
    lazy var persistentContainer: NSPersistentCloudKitContainer = {
        let container: NSPersistentCloudKitContainer = NSPersistentCloudKitContainer(name: "Model")
        
        if let description: NSPersistentStoreDescription = container.persistentStoreDescriptions.first {
            description.setOption(true as NSNumber, forKey: NSPersistentStoreRemoteChangeNotificationPostOptionKey)
        }
        
        container.loadPersistentStores { loadedStoreDescription, error in
            if let error = error {
                fatalError("--- Failed to load persistent store: \(error)")
            }
        }
        
        container.viewContext.automaticallyMergesChangesFromParent = true
        
        return container
    }()
    
}
