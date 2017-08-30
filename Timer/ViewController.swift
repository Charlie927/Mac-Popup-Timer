//
//  ViewController.swift
//  Timer
//
//  Created by Charlie Wang on 2017/8/2.
//  Copyright © 2017年 Charlie Studio. All rights reserved.
//

import Cocoa

class ViewController: NSViewController {
    
    @IBOutlet weak var timerLabel: NSTextField!
    @IBOutlet weak var startPauseResumeButton: NSButton!
    @IBOutlet weak var resetButton: NSButton!
    @IBOutlet weak var setTimeButton: NSButton!
    
    var timer = TimerModel()
    
    override func viewDidLoad() {
        super.viewDidLoad()
        timer.delegate = self
        resetButton.isEnabled = false
        configureTimeLabel(to: timer.duration)
    }
    
    override var representedObject: Any? {
        didSet {
            // Update the view, if already loaded.
        }
    }
    
    @IBAction func quit(_ sender: NSButton) {
        NSApp.terminate(self)
    }
    
    @IBAction func startPauseResume(_ sender: NSButton) {
        switch sender.title {
        case "Start":
            timer.start()
            resetButton.isEnabled = true
            setTimeButton.isEnabled = false
            sender.title = "Pause"
        case "Pause":
            timer.pause()
            sender.title = "Resume"
        case "Resume":
            timer.resume()
            sender.title = "Pause"
        default:
            break
        }
    }
    
    @IBAction func reset(_ sender: NSButton) {
        timer.reset()
        startPauseResumeButton.isEnabled = true
        resetButton.isEnabled = false
        setTimeButton.isEnabled = true
        startPauseResumeButton.title = "Start"
        timerLabel.textColor = NSColor.labelColor
        configureTimeLabel(to: timer.duration)
    }
    
    override func prepare(for segue: NSStoryboardSegue, sender: Any?) {
        if segue.identifier == "SetTime" {
            let windowController = segue.destinationController as! NSWindowController
            let controller = windowController.contentViewController as! SetTimeViewController
            controller.delegate = timer
        }
    }
    
    func configureTimeLabel(to time: Double) {
        let minutes = floor(time / 60)
        let seconds = time - (minutes * 60)
        let minutesDisplay = String(format: "%02d", Int(minutes))
        let secondsDisplay = String(format: "%02d", Int(seconds))
        timerLabel.stringValue = "\(minutesDisplay):\(secondsDisplay)"
    }
    
}

extension ViewController: TimerModelDelegate {
    
    func timerHasFinished(_ timer: TimerModel) {
        
        startPauseResumeButton.isEnabled = false
        timerLabel.stringValue = "00:00"
        timerLabel.textColor = NSColor.red
        
        let notification = NSUserNotification()
        notification.title = "Time's up!"
        notification.informativeText = "Your timer has finished."
        notification.soundName = NSUserNotificationDefaultSoundName //"Time's Up"
        NSUserNotificationCenter.default.deliver(notification)
        
    }
    
    func setTime(_ timer: TimerModel, to time: Double) {
        configureTimeLabel(to: time)
    }
    
}
