//
//  ViewController.swift
//  Blued-Checkin
//
//  Created by danlan on 2017/9/27.
//  Copyright © 2017年 lxc. All rights reserved.
//

import Cocoa
import Alamofire
import SwiftyJSON

class ViewController: NSViewController {

    @IBOutlet weak var nameField: NSTextField!
    
    @IBOutlet weak var pwdField: NSSecureTextFieldCell!
    @IBOutlet weak var goButton: NSButton!
    @IBOutlet weak var resultLabel: NSTextField!
    
    
    override func viewDidLoad() {
        super.viewDidLoad()
        
        let userDefaults = UserDefaults.standard
        
        if let name = userDefaults.string(forKey: "username") {
            nameField.stringValue = name
        }
        
        if let pwd = userDefaults.string(forKey: "password") {
            pwdField.stringValue = pwd
        }
    }
    
    func menuClick() {
        
    }

    @IBAction func goClicked(_ sender: Any) {
        
        let name = nameField.stringValue
        let password = pwdField.stringValue
        
        if name.count == 0 || password.count == 0 {
            self.resultLabel.stringValue = "input invalid"
            return
        }
        
        let userDefaults = UserDefaults.standard
        userDefaults.set(name, forKey: "username")
        userDefaults.set(password, forKey: "password")
        userDefaults.synchronize()

        let url = "http://x.x.x.x/ac_portal/login.php?"
        let parameters: [String: Any] = ["opr": "pwdLogin",
                                         "userName": name,
                                         "pwd": password,
                                         "rememberPwd": 1]
        
        Alamofire.request(url, method: .post, parameters:parameters).responseString { (response) in
            
            print("Response: \(String(describing: response.response))")
            print("Result: \(response.result)")
            
            if let _ = response.result.value {
                let rawString = String(data: response.data!, encoding: String.Encoding.utf8)
                
                let valueCompat = rawString!.replacingOccurrences(of: "'", with: "\"")
                let parsedResult = JSON(parseJSON:valueCompat)
                
                let success = parsedResult["success"].bool!
                let msg = parsedResult["msg"].string!
                if success {
                    let tip = "记得用钉钉打卡!!!"
                    self.resultLabel.stringValue = tip
                } else {
                    self.resultLabel.stringValue = msg
                }
            }
        }
    }
    override var representedObject: Any? {
        didSet {
        // Update the view, if already loaded.
        }
    }


}














