//
//  HappyViewController.swift
//  Advent Calendar
//
//  Created by Adeel Qayum on 10/31/18.
//  Copyright © 2018 Adeel Qayum. All rights reserved.
//

import UIKit

class HappyViewController: UIViewController {
    
    
    @IBOutlet var happyholidayslabel: UILabel!
    

    override func viewDidLoad() {
        super.viewDidLoad()

        self.view.backgroundColor = UIColor.green
        
        happyholidayslabel.text = NSLocalizedString("str_happyholidays", comment: "")
        
        self.happyholidayslabel.textColor = UIColor.white
    }

    
    
    
    
    
    
    override func didReceiveMemoryWarning() {
        super.didReceiveMemoryWarning()
        // Dispose of any resources that can be recreated.
    }
    

}
