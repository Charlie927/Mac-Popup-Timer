//
//  SetTimeViewController.swift
//  Timer
//
//  Created by Charlie Wang on 2017/8/2.
//  Copyright © 2017年 Charlie Studio. All rights reserved.
//

import Cocoa

protocol SetTimeViewControllerDelegate {
    func setTime(_ controller: SetTimeViewController, to time: Double)
    func getTime(_ controller: SetTimeViewController) -> Double
}

class SetTimeViewController: NSViewController {
    
    @IBOutlet weak var minuteLabel: NSTextField!
    @IBOutlet weak var secondLabel: NSTextField!
    @IBOutlet weak var minuteStepper: NSStepper!
    @IBOutlet weak var secondStepper: NSStepper!
    @IBOutlet weak var doneButton: NSButton!
    
    var delegate: SetTimeViewControllerDelegate?
    
    override func viewDidLoad() {
        super.viewDidLoad()
    }
    
    override func viewWillAppear() {
        super.viewWillAppear()
        let time = delegate?.getTime(self)
        let minutes = floor(time! / 60)
        let seconds = time! - (minutes * 60)
        minuteStepper.intValue = Int32(minutes)
        secondStepper.intValue = Int32(seconds)
        minuteLabel.stringValue = String(format: "%02d", minuteStepper.intValue)
        secondLabel.stringValue = String(format: "%02d", secondStepper.intValue)
    }
    
    func checkIsTimeLegal() {
        if minuteStepper.intValue == 0 && secondStepper.intValue == 0 {
            doneButton.isEnabled = false
        } else {
            doneButton.isEnabled = true
        }
    }
    
    @IBAction func minuteStepperChanged(_ sender: NSStepper) {
        minuteLabel.stringValue = String(format: "%02d", sender.intValue)
        checkIsTimeLegal()
    }
    
    @IBAction func secondStepperChanged(_ sender: NSStepper) {
        secondLabel.stringValue = String(format: "%02d", sender.intValue)
        checkIsTimeLegal()
    }
    
    @IBAction func done(_ sender: NSButton) {
        let time = 60 * minuteStepper.intValue + secondStepper.intValue
        delegate?.setTime(self, to: Double(time))
        view.window?.close()
    }
    
    @IBAction func cancel(_ sender: NSButton) {
        view.window?.close()
    }
    
}
