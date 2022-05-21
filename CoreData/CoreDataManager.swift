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
            description.setOption(true as NSNumber, forKey: NSPersistentHistoryTrackingKey)
            
            /*
            let isICloudSyncEnabled = NSUbiquitousKeyValueStore.default.bool(forKey: UserDefaultsKey.isICloudSyncEnabled)
            
            if !isICloudSyncEnabled {
                description.cloudKitContainerOptions = nil
                print("iCloud Sync Disabled")
            }
            */
        }
        
        container.loadPersistentStores { loadedStoreDescription, error in
            if let error = error {
                fatalError("--- Failed to load persistent store: \(error)")
            }
        }
        
        container.viewContext.automaticallyMergesChangesFromParent = true
        
        return container
    }()
    
    lazy var managedContext: NSManagedObjectContext = {
        return self.persistentContainer.viewContext
    }()
    
}

extension CoreDataManager {
    
    func fetchAllTagTitles() -> [String]? {
        let tagFetchRequest: NSFetchRequest<Tag> = Tag.fetchRequest()
        tagFetchRequest.sortDescriptors = [NSSortDescriptor(keyPath: \Tag.title, ascending: true)]
        do {
            let fetchResult: [Tag] = try self.managedContext.fetch(tagFetchRequest)
            
            return fetchResult.compactMap({ $0.title })
        }
        catch {
            print("--- Failed to fetch tags ---")
            return nil
        }
    }
    
    func setUpContainer(with isICloudSyncEnabled: Bool) {
        let container: NSPersistentCloudKitContainer = NSPersistentCloudKitContainer(name: "Model")
        
        if let description: NSPersistentStoreDescription = container.persistentStoreDescriptions.first {
            description.setOption(true as NSNumber, forKey: NSPersistentStoreRemoteChangeNotificationPostOptionKey)
            description.setOption(true as NSNumber, forKey: NSPersistentHistoryTrackingKey)

            if !isICloudSyncEnabled {
                description.cloudKitContainerOptions = nil
            }
        }
        
        container.loadPersistentStores { loadedStoreDescription, error in
            if let error = error {
                fatalError("--- Failed to load persistent store: \(error)")
            }
        }
        
        container.viewContext.automaticallyMergesChangesFromParent = true
        
        self.persistentContainer = container
    }
    
}
