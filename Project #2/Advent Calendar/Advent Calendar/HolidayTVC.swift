//
//  HolidayTVC.swift
//  Advent Calendar
//
//  Created by Adeel Qayum on 11/1/18.
//  Copyright © 2018 Adeel Qayum. All rights reserved.
//

import UIKit

protocol HolidayTVCDelegate: class {
    func selectHoliday(_ holiday: String)
}

class HolidayTVC: UITableViewController {

    override func viewDidLoad() {
        super.viewDidLoad()


    }
    
    var holidays: [String] = [NSLocalizedString("str_christmas", comment: ""), NSLocalizedString("str_kwanza", comment: ""), NSLocalizedString("str_chanukah", comment: "")]
    
    weak var delegate: HolidayTVCDelegate?

    override func didReceiveMemoryWarning() {
        super.didReceiveMemoryWarning()
        // Dispose of any resources that can be recreated.
    }

    // MARK: - Table view data source

    override func numberOfSections(in tableView: UITableView) -> Int {
        return 1
    }

    override func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        return 3
    }

    
    override func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        let cell = tableView.dequeueReusableCell(withIdentifier: "tablecell", for: indexPath)

        cell.textLabel?.text = holidays[indexPath.row]

        return cell
    }


     
    // Override to support conditional editing of the table view.
    override func tableView(_ tableView: UITableView, canEditRowAt indexPath: IndexPath) -> Bool {
        // Return false if you do not want the specified item to be editable.
        return true
    }
    

    override func tableView(_ tableView: UITableView, didSelectRowAt indexPath: IndexPath) {
        delegate?.selectHoliday(holidays[indexPath.row])
    }

}
