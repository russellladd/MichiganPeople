//
//  MasterViewController.swift
//  MichiganPeople
//
//  Created by Russell Ladd on 8/14/14.
//  Copyright (c) 2014 GRL5. All rights reserved.
//

import UIKit
import Wolverine

class SearchViewController: UITableViewController, ServiceManagerDelegate {
    
    let serviceManager: ServiceManager
    
    var personArrayResults: PersonArrayResult? {
        didSet {
            tableView.reloadData()
        }
    }
    
    var personResults: [PersonResult]? {
        get {
            if let personArrayResults = personArrayResults {
                switch personArrayResults {
                case .Success(let personResults):
                    return personResults
                default:
                    return nil
                }
            } else {
                return nil
            }
        }
    }
    
    // MARK: - View
    
    let label = UILabel()
    
    override func viewDidLoad() {
        
        super.viewDidLoad()
        
        label.font = UIFont.preferredFontForTextStyle(UIFontTextStyleHeadline)
        label.text = NSLocalizedString("Could not connect to database.", comment: "Service not connected")
        //label.hidden =
    }
    
    // MARK: - Initialization
    
    required init(coder aDecoder: NSCoder) {
        
        serviceManager = ServiceManager(credential: Credential(key: "Wijw6wNYqffL0_ZnLOW9HemfEf8a", secret: "hjUuNq2CqsjchshuVsGnJs5Kenca"))
        
        super.init(coder: aDecoder)
        
        serviceManager.delegate = self
    }
    
    // MARK: - Service manager delegate
    
    func serviceManager(serviceManager: ServiceManager, didChangeStatus status: ServiceManager.Status) {
        
        switch status {
        case .Connecting:
            ()
        case .Connected(let service):
            service.getPeopleForSearchString("Russell") { personArrayResults in
                self.personArrayResults = personArrayResults
            }
        case .NotConnected(let error):
            println(error)
        }
    }
    
    // MARK: - Segues
    
    override func prepareForSegue(segue: UIStoryboardSegue, sender: AnyObject?) {
        
        if segue.identifier == "showPerson" {
            
            let indexPath = self.tableView.indexPathForSelectedRow()!
            
            let personResult = personResults![indexPath.row]
            
            let controller = (segue.destinationViewController as UINavigationController).topViewController as PersonViewController
            
            controller.personResult = personResult
            controller.navigationItem.leftBarButtonItem = self.splitViewController!.displayModeButtonItem()
            controller.navigationItem.leftItemsSupplementBackButton = true
        }
    }
    
    // MARK: - Table View
    
    override func tableView(tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        return personResults?.count ?? 0
    }
    
    override func tableView(tableView: UITableView, cellForRowAtIndexPath indexPath: NSIndexPath) -> UITableViewCell {
        
        let cell = tableView.dequeueReusableCellWithIdentifier("Person Cell", forIndexPath: indexPath) as UITableViewCell
        
        let personResult = personResults![indexPath.row];
        
        switch personResult {
        case .Success(let person):
            cell.textLabel!.text = person.displayName
        case .Error(let error):
            cell.textLabel!.text = error.description
        }
        
        return cell
    }
}
