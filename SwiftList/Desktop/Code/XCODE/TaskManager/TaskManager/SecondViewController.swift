//
//  SecondViewController.swift
//  TaskManager
//
//  Created by Rohil on 6/13/20.
//  Copyright © 2020 TM. All rights reserved.
//

import UIKit

class SecondViewController: UIViewController, UITableViewDelegate {
    
    @IBOutlet weak var reminder: UILabel!

    @IBOutlet weak var reminderInput: UITextField!
    

    
    
    
    
    override func viewDidLoad() {
        super.viewDidLoad()
        // Do any additional setup after loading the view.

    }

    @IBAction func add(_ sender: Any) {
        print(reminderInput.text)
        reminder.text = reminderInput.text
    }
    
}


    


