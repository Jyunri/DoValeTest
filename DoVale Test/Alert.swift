//
//  Alert.swift
//  DoVale Test
//
//  Created by Jimy Suenaga on 12/11/17.
//  Copyright © 2017 Audience Marketing. All rights reserved.
//

import UIKit

class Alert {
    
    var title: String
    var message: String
    
    init(title: String, message: String) {
        self.title = title
        self.message = message
    }
    
    func get_alert() -> UIAlertController{
        let alert = UIAlertController(title: self.title,message: self.message, preferredStyle: .alert)
        alert.addAction(UIAlertAction(title: "OK", style: .default, handler: nil))
        return alert
    }

}
