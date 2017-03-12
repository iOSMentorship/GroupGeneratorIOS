//
//  GroupsController.swift
//  GroupGenerator
//
//  Created by Kayode Oguntimehin on 09/03/2017.
//  Copyright © 2017 Kayode Oguntimehin. All rights reserved.
//

import UIKit

class GroupsController: UIViewController {

    @IBOutlet weak var groupsGeneratedLabel: UITextView!
    var groupsGenerated = String()
    
    var mygroups : String = ""
    
    
    override func viewWillAppear(_ animated: Bool) {
        groupsGeneratedLabel.text = mygroups
        
        print(mygroups + "ade")
    }
    
    override func viewDidLoad() {
        super.viewDidLoad()
    }

}
