//
//  EventMonitor.swift
//  Timer
//
//  Created by Charlie Wang on 2017/8/2.
//  Copyright © 2017年 Charlie Studio. All rights reserved.
//

import Cocoa

class EventMonitor {
    
    var monitor: AnyObject?
    let mask: NSEventMask
    let handler: (NSEvent?) -> ()
    
    public init(mask: NSEventMask, handler: @escaping (NSEvent?) -> ()) {
        self.mask = mask
        self.handler = handler
    }
    
    deinit {
        stop()
    }
    
    func start() {
        monitor = NSEvent.addGlobalMonitorForEvents(matching: mask, handler: handler) as AnyObject?
    }
    
    func stop() {
        if monitor != nil {
            NSEvent.removeMonitor(monitor!)
            monitor = nil
        }
    }
    
}
