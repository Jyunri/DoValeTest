//
//  ServicesType.swift
//  DoVale Test
//
//  Created by Jimy Suenaga on 19/08/17.
//  Copyright © 2017 Audience Marketing. All rights reserved.
//

import Foundation
import UIKit

class ServicesType{
    var name = ""
    var image = ""
    var background : UIColor
    
    init(name:String, image:String, background:UIColor){
        self.name = name
        self.image = image
        self.background = background
    }
}
