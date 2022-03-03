//
//  AppDelegate.swift
//  Recorday
//
//  Created by HyeJee Kim on 2022/03/01.
//

import UIKit
import CoreData
import CloudKit

@main
class AppDelegate: UIResponder, UIApplicationDelegate {
    
    // MARK: - Property
    
    static let sharedAppDelegate: AppDelegate = {
        guard let appDelegate: AppDelegate = UIApplication.shared.delegate as? AppDelegate else {
            fatalError("--- Failed to cast app delegate as AppDelegate ---")
        }
        
        return appDelegate
    }()
    
    lazy var coreDataManager: CoreDataManager = {
        return CoreDataManager()
    }()
    
    // MARK: - Initializing the App

    func application(_ application: UIApplication, didFinishLaunchingWithOptions launchOptions: [UIApplication.LaunchOptionsKey: Any]?) -> Bool {
        // Override point for customization after application launch.
        print(#function)
        return true
    }

    // MARK: UISceneSession Lifecycle

    func application(_ application: UIApplication, configurationForConnecting connectingSceneSession: UISceneSession, options: UIScene.ConnectionOptions) -> UISceneConfiguration {
        // Called when a new scene session is being created.
        // Use this method to select a configuration to create the new scene with.
        return UISceneConfiguration(name: "Default Configuration", sessionRole: connectingSceneSession.role)
    }

    func application(_ application: UIApplication, didDiscardSceneSessions sceneSessions: Set<UISceneSession>) {
        // Called when the user discards a scene session.
        // If any sessions were discarded while the application was not running, this will be called shortly after application:didFinishLaunchingWithOptions.
        // Use this method to release any resources that were specific to the discarded scenes, as they will not return.
    }
    
    // MARK: - Handling Remote Notification
    
    func application(_ application: UIApplication, didReceiveRemoteNotification userInfo: [AnyHashable : Any], fetchCompletionHandler completionHandler: @escaping (UIBackgroundFetchResult) -> Void) {
        print("--- \(#function): \(userInfo) ---")
        if let notification = CKNotification(fromRemoteNotificationDictionary: userInfo) {
            print("--- CloudKit database changed: \(notification.description) ---")
        }
    }


}

