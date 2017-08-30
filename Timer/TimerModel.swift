//
//  TimerModel.swift
//  Timer
//
//  Created by Charlie Wang on 2017/8/2.
//  Copyright © 2017年 Charlie Studio. All rights reserved.
//

import Foundation

protocol TimerModelDelegate {
    func timerHasFinished(_ timer: TimerModel)
    func setTime(_ timer: TimerModel, to time: Double)
}

class TimerModel {
    
    var timer: Timer?
    var startTime: Date?
    var duration: TimeInterval = 180 // In seconds. Default value 3 minutes.
    var elapsedTime: TimeInterval = 0
    
    var delegate: TimerModelDelegate?
    
    dynamic func fire() {
        
        guard let startTime = startTime else {
            return
        }
        
        elapsedTime = -startTime.timeIntervalSinceNow
        let secondsRemaining = (duration - elapsedTime).rounded()
        
        if secondsRemaining <= 0 {
            reset()
            delegate?.timerHasFinished(self)
        } else {
            delegate?.setTime(self, to: secondsRemaining)
        }
        
    }
    
    func start() {
        startTime = Date()
        elapsedTime = 0
        timer = Timer.scheduledTimer(timeInterval: 1, target: self, selector: #selector(fire), userInfo: nil, repeats: true)
        fire()
    }
    
    func pause() {
        timer?.invalidate()
        timer = nil
        fire()
    }
    
    func resume() {
        startTime = Date(timeIntervalSinceNow: -elapsedTime)
        timer = Timer.scheduledTimer(timeInterval: 1, target: self, selector: #selector(fire), userInfo: nil, repeats: true)
        fire()
    }
    
    func reset() {
        timer?.invalidate()
        timer = nil
        startTime = nil
        elapsedTime = 0
        fire()
    }
    
}

extension TimerModel: SetTimeViewControllerDelegate {
    
    func setTime(_ controller: SetTimeViewController, to time: Double) {
        duration = time
        delegate?.setTime(self, to: duration)
    }
    
    func getTime(_ controller: SetTimeViewController) -> Double {
        return duration
    }
    
}
