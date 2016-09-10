//
//  ViewController.swift
//  clockDemo
//
//  Created by Sherif Khaled on 9/10/16.
//  Copyright © 2016 Sherif Khaled. All rights reserved.
//

import UIKit

class ViewController: UIViewController {

    @IBOutlet weak var dateTextField: UITextField!
    @IBOutlet weak var clockContainerView: UIView!
    var clock:SKClock!
    
    override func viewDidLoad() {
        super.viewDidLoad()
    clock = NSBundle.mainBundle().loadNibNamed("SKClock", owner: self, options: nil)[0] as? SKClock
        clock.frame = clockContainerView.bounds
        clockContainerView.addSubview(clock)
        clock.startDate = "03:33 AM".getDate("hh:mm a")
        clock.primaryColor = UIColor(hexCode: "#474645")!
        clock.secondryColor = UIColor(hexCode: "#d1e152")!
        let delayTime = dispatch_time(DISPATCH_TIME_NOW, Int64(0.01 * Double(NSEC_PER_SEC)))
        dispatch_after(delayTime, dispatch_get_main_queue())
        {
            self.clock.configureClockViews()
        }

    }

    @IBAction func printSelectedDate(sender: UIButton) {
    dateTextField.text = "String = \(clock.getSelecteStringdDate()) - Date : \(clock.getSelectedDate())"
    }
    


}

