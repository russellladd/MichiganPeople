//
//  DetailViewController.swift
//  MichiganPeople
//
//  Created by Russell Ladd on 8/14/14.
//  Copyright (c) 2014 GRL5. All rights reserved.
//

import UIKit
import Wolverine

class PersonViewController: UIViewController {
    
    @IBOutlet weak var detailDescriptionLabel: UILabel!
    
    var personResult: PersonResult? {
        
        didSet {
            self.configureView()
        }
    }
    
    func configureView() {
        
        if let personResult = self.personResult {
            if let label = self.detailDescriptionLabel {
                
                switch personResult {
                case .Success(let person):
                    label.text = person.displayName
                case .Error(let error):
                    label.text = error.description
                }
            }
        }
    }
    
    override func viewDidLoad() {
        
        super.viewDidLoad()
        
        self.configureView()
    }
}
