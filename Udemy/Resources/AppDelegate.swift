//
//  AppDelegate.swift
//  Udemy
//
//  Created by Phúc Lý on 9/28/20.
//  Copyright © 2020 Phúc Lý. All rights reserved.
//

import UIKit
import CoreData
import Reachability
import SVProgressHUD
import IQKeyboardManagerSwift

@UIApplicationMain
class AppDelegate: UIResponder, UIApplicationDelegate {
    
    var account: Account = Account()
    var cart: Cart = Cart()
    var window: UIWindow?
    var reachability: Reachability?
    
    var currentController: CurrentController = .login
    var wasNotifyActivationCode: Bool? = false
    
    let loginController: UINavigationController = UINavigationController(rootViewController: LoginViewController())
    var mainTabBarController: MainTabBarController?
    
    func application(_ application: UIApplication, didFinishLaunchingWithOptions launchOptions: [UIApplication.LaunchOptionsKey: Any]?) -> Bool {
        // Override point for customization after application launch.
        
        // Keyboard
        IQKeyboardManager.shared.enable = true
        
        // Windows
        window = UIWindow(frame: UIScreen.main.bounds)
        window?.setController(currentController)
        window?.makeKeyAndVisible()
        
        
        
        // Networking
        do {
            reachability = try Reachability()
        } catch {
            self.window?.showError("Error", "Initialize reachability variable failed")
        }
        guard let reachability = reachability else {
            self.window?.showError("Error", "Can not check network")
            return true
        }
        
        reachability.whenUnreachable = { reach in
            self.window?.showError("Failed", "Can not connect to network")
            SVProgressHUD.dismiss()
        }
        
        do {
            try reachability.startNotifier()
        } catch {
            window?.showError("Error", error.localizedDescription)
        }
        
        return true
    }

    // MARK: - Core Data stack
    lazy var persistentContainer: NSPersistentContainer = {
        /*
         The persistent container for the application. This implementation
         creates and returns a container, having loaded the store for the
         application to it. This property is optional since there are legitimate
         error conditions that could cause the creation of the store to fail.
        */
        let container = NSPersistentContainer(name: "Udemy")
        container.loadPersistentStores(completionHandler: { (storeDescription, error) in
            if let error = error as NSError? {
                // Replace this implementation with code to handle the error appropriately.
                // fatalError() causes the application to generate a crash log and terminate. You should not use this function in a shipping application, although it may be useful during development.
                 
                /*
                 Typical reasons for an error here include:
                 * The parent directory does not exist, cannot be created, or disallows writing.
                 * The persistent store is not accessible, due to permissions or data protection when the device is locked.
                 * The device is out of space.
                 * The store could not be migrated to the current model version.
                 Check the error message to determine what the actual problem was.
                 */
                fatalError("Unresolved error \(error), \(error.userInfo)")
            }
        })
        return container
    }()

    // MARK: - Core Data Saving support

    func saveContext () {
        let context = persistentContainer.viewContext
        if context.hasChanges {
            do {
                try context.save()
            } catch {
                // Replace this implementation with code to handle the error appropriately.
                // fatalError() causes the application to generate a crash log and terminate. You should not use this function in a shipping application, although it may be useful during development.
                let nserror = error as NSError
                fatalError("Unresolved error \(nserror), \(nserror.userInfo)")
            }
        }
    }
    
    
    // MARK: - Deinitailizer
    deinit {
        reachability?.stopNotifier()
    }
}

