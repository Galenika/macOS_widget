//
//  AppDelegate.swift
//  Blued-Checkin
//
//  Created by danlan on 2017/9/27.
//  Copyright © 2017年 lxc. All rights reserved.
//

import Cocoa

@NSApplicationMain
class AppDelegate: NSObject, NSApplicationDelegate {

    var menuItem: NSStatusItem?
    
    public var window: NSWindow?


    func applicationDidFinishLaunching(_ aNotification: Notification) {
        // Insert code here to initialize your application
        
        self.window = NSApp.windows.first
        
        let statusBar = NSStatusBar.system
        
        let item = statusBar.statusItem(withLength: NSStatusItem.squareLength)
        
        item.button?.image = NSImage(named: NSImage.Name(rawValue: "net"))
        
        menuItem = item
        menuItem?.target = self
        menuItem?.toolTip = "淡蓝联网"
        menuItem?.action = #selector(menuClick)
    }
    
    @objc func menuClick() {
        self.window?.makeKeyAndOrderFront(self)
        NSApp.activate(ignoringOtherApps: true)
    }

    func applicationWillTerminate(_ aNotification: Notification) {
        // Insert code here to tear down your application
        NSStatusBar.system.removeStatusItem(menuItem!)
    }
    
    /*
     //这个是点击关闭按钮是否应该被关掉，默认是不关闭
     func applicationShouldTerminateAfterLastWindowClosed(_ sender: NSApplication) -> Bool {
        
    }
     */
    
    func applicationShouldHandleReopen(_ sender: NSApplication, hasVisibleWindows flag: Bool) -> Bool {
        //如果没有可见的话
        if !flag {
            self.window?.makeKeyAndOrderFront(self)
        }
        return true
    }
    
}
