//
//  ViewController.swift
//  Advent Calendar
//
//  Created by Adeel Qayum on 10/24/18.
//  Copyright © 2018 Adeel Qayum. All rights reserved.
//

import UIKit

class ViewController: UIViewController, TileViewDelegate {
    
    

    @IBOutlet var days: [TileView]!
    @IBOutlet var testmodelabel: UILabel!
    @IBOutlet var testmode: UISwitch!

    
    var calendar = Calendar()
    
    override func viewDidLoad() {
        super.viewDidLoad()
        
        //default title
        self.navigationItem.title = NSLocalizedString("str_christmas", comment: "")
        
        self.view.backgroundColor = UIColor.red
        
        testmode.isOn = calendar.testmode
        
        updateHoliday()
        
        calendar.initGame(with: days.count)
        
        for i in 0..<days.count {
            days[i].index = calendar.array[i].index
            days[i].delegate = self
        }
        
        updateTiles()
    }
    
    func updateTiles() {
        for i in 0..<days.count {
            if calendar.isFaceUp(i){
                days[i].index = calendar.isFaceUp(i) ? i : 0
            }
            if calendar.isFaceDown(i){
                days[i].title = calendar.isFaceDown(i) ? calendar.array[i].label: ""
            }
            if(calendar.testmode == false) {
                for i in 1..<days.count {
                if (calendar.isFaceDown(i)) && (calendar.isFaceUp(i-1)) {
                    dayAlert()
                    self.calendar.toggleFaceUp(i)
                    days[i].animateFlipBack()
                    self.days[i].index = self.calendar.isFaceUp(i) ? i : 0
                }
                }
            }
        }
    }
    
    
    func shouldFlip(_ tileView: TileView, index: Int) -> Bool {
        if calendar.isFaceUp(index) {
            return false
        }
        return true
    }
    
    func didFlip(_ tileView: TileView, index: Int) {
        calendar.toggleFaceUp(index)
        updateTiles()
    }
    
    @IBAction func onReset(_ sender: Any) {
        resetAlert(completion: { _ in
            for i in 0..<self.days.count {
                if self.calendar.isFaceDown(i){
                    self.calendar.toggleFaceUp(i)
                    self.days[i].animateFlipBack()
                }
                if self.calendar.isFaceUp(i) {
                    self.days[i].index = self.calendar.isFaceUp(i) ? i : 0
                }
            }
        })
    }
    
    override func shouldPerformSegue(withIdentifier identifier: String, sender: Any?) -> Bool {
        if(calendar.testmode == false) {
                for i in 0..<(days.count - 1) {
                    if calendar.array[i].faceUp == true {
                    dayAlert()
                    return false
                }
            }
        }
        return true
}
    
    func updateHoliday() {
        self.navigationItem.title = calendar.selectedHoliday
        
        switch (calendar.selectedHoliday) {
        case NSLocalizedString("str_christmas", comment: ""):
            view.backgroundColor = UIColor.red
            break
        case NSLocalizedString("str_kwanza", comment: ""):
            view.backgroundColor = UIColor.blue
            break
        case NSLocalizedString("str_chanukah", comment: ""):
            view.backgroundColor = UIColor.purple
            break
            
        default:
            view.backgroundColor = UIColor.gray
        }
    }
    
    override func prepare(for segue: UIStoryboardSegue, sender: Any?) {
        if (segue.identifier == "Holiday") {
            if let destination = segue.destination as? HolidayTVC {
                destination.delegate = self

            }
        }
    }
    
    
    
    @IBAction func testmodeswitch(_ sender: UISwitch) {
        if (sender.isOn == true) {
            calendar.testmode = true
        }
        if (sender.isOn == false) {
            calendar.testmode = false
            for i in 0..<self.days.count {
                if self.calendar.isFaceDown(i){
                    self.calendar.toggleFaceUp(i)
                    self.days[i].animateFlipBack()
                }
                if self.calendar.isFaceUp(i) {
                    self.days[i].index = self.calendar.isFaceUp(i) ? i : 0
                }
            }
        }
    }
    
    
    
    
    
    func dayAlert() {
        
        let alertMsg = NSLocalizedString("str_dayWarning", comment: "")
        
        let alert = UIAlertController(title: NSLocalizedString("str_warning", comment: ""),
                                      message: alertMsg,
                                      preferredStyle: .alert)
            
        alert.addAction(UIAlertAction(title: NSLocalizedString("str_dismiss", comment: ""), style: .default, handler: { (action) in alert.dismiss(animated: true, completion: nil)
                
            }))

        
        alert.popoverPresentationController?.permittedArrowDirections = []
        alert.popoverPresentationController?.sourceView = self.view
        alert.popoverPresentationController?.sourceRect = CGRect(x: self.view.frame.midX, y: self.view.frame.midY, width: 0, height: 0)
        
        present(alert, animated: true, completion: nil)
    }
    
    
    func resetAlert(completion: @escaping (UIAlertAction) -> Void) {
        
        let alertMsg = NSLocalizedString("str_resetWarning", comment: "")
        
        let alert = UIAlertController(title: NSLocalizedString("str_warning", comment: ""),
                                      message: alertMsg,
                                      preferredStyle: .alert)
        
        let resetAction = UIAlertAction(title: NSLocalizedString("str_reset", comment: ""),
                                        style: .destructive, handler: completion)
        let cancelAction = UIAlertAction(title: NSLocalizedString("str_cancel", comment: ""),
                                         style: .cancel, handler:nil)
        
        alert.addAction(cancelAction)
        alert.addAction(resetAction)
        
        alert.popoverPresentationController?.permittedArrowDirections = []
        alert.popoverPresentationController?.sourceView = self.view
        alert.popoverPresentationController?.sourceRect = CGRect(x: self.view.frame.midX, y: self.view.frame.midY, width: 0, height: 0)
        
        present(alert, animated: true, completion: nil)
    }
    
    override func didReceiveMemoryWarning() {
        super.didReceiveMemoryWarning()
        
        // Dispose of any resources that can be recreated.
    }
    
    
    


}


extension ViewController: HolidayTVCDelegate {
    func selectHoliday(_ holiday: String) {
        calendar.selectedHoliday = holiday
        updateHoliday()
    }
}

