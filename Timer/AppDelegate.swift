//
//  AppDelegate.swift
//  Timer
//
//  Created by Charlie Wang on 2017/8/2.
//  Copyright © 2017年 Charlie Studio. All rights reserved.
//

import Cocoa

@NSApplicationMain
class AppDelegate: NSObject, NSApplicationDelegate {
    
    let statusItem = NSStatusBar.system().statusItem(withLength: -1)
    let popover = NSPopover()
    var eventMonitor: EventMonitor?
    
    func applicationDidFinishLaunching(_ aNotification: Notification) {
        
        if let button = statusItem.button {
            button.image = NSImage(named: "MenuBarButtonImage")
            button.action = #selector(togglePopover)
        }
        
        let controller = NSStoryboard(name: "Main", bundle: nil).instantiateController(withIdentifier: "ViewController") as! ViewController
        
        popover.contentViewController = controller
        
        eventMonitor = EventMonitor(mask: [.leftMouseDown, .rightMouseDown]) {
            [unowned self] event in
            if self.popover.isShown {
                self.closePopover(event)
            }
        }
        eventMonitor?.start()
        showPopover(nil)
        
    }
    
    func applicationWillTerminate(_ aNotification: Notification) {
        // Insert code here to tear down your application
    }
    
    func togglePopover(_ sender: AnyObject?) {
        popover.isShown ? closePopover(sender) : showPopover(sender)
    }
    
    func showPopover(_ sender: AnyObject?) {
        if let button = statusItem.button {
            popover.show(relativeTo: button.bounds, of: button, preferredEdge: NSRectEdge.minY)
        }
        eventMonitor?.start()
    }
    
    func closePopover(_ sender: AnyObject?) {
        popover.performClose(sender)
        eventMonitor?.stop()
    }

}

