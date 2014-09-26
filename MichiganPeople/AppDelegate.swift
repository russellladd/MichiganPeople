//
//  AppDelegate.swift
//  MichiganPeople
//
//  Created by Russell Ladd on 8/14/14.
//  Copyright (c) 2014 GRL5. All rights reserved.
//

import UIKit

@UIApplicationMain

class AppDelegate: UIResponder, UIApplicationDelegate, UISplitViewControllerDelegate {
    
    var window: UIWindow?
    
    func application(application: UIApplication!, didFinishLaunchingWithOptions launchOptions: NSDictionary!) -> Bool {
        
        let splitViewController = self.window!.rootViewController as UISplitViewController
        
        splitViewController.preferredDisplayMode = .AllVisible
        splitViewController.preferredPrimaryColumnWidthFraction = 0.4
        splitViewController.maximumPrimaryColumnWidth = 480.0
        splitViewController.delegate = self

        return true
    }
    
    // MARK: - Split view
    
    func splitViewController(splitViewController: UISplitViewController!, collapseSecondaryViewController secondaryViewController:UIViewController!, ontoPrimaryViewController primaryViewController:UIViewController!) -> Bool {
        
        if let secondaryAsNavController = secondaryViewController as? UINavigationController {
            if let topAsDetailController = secondaryAsNavController.topViewController as? PersonViewController {
                
                if topAsDetailController.personResult == nil {
                    // Return true to indicate that we have handled the collapse by doing nothing; the secondary controller will be discarded.
                    return true
                }
            }
        }
        
        return false
    }
}
