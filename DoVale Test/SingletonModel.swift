//
//  SingletonModel.swift
//  DoVale Test
//
//  Created by Jimy Suenaga on 31/10/17.
//  Copyright © 2017 Audience Marketing. All rights reserved.
//

import Foundation
import UIKit

class SingletonModel{
    static var servicesType:[ServicesType] =
        [
            ServicesType(name:"Eletricista", image:"electricity", background:UIColor(red: 128.00/255.0, green: 128.00/255.0, blue: 0.00/255.0, alpha: 1)),
            ServicesType(name:"Pedreiro",image:"pedreiro", background:UIColor.darkGray),
            ServicesType(name:"Salão de Beleza",image:"beleza", background:UIColor.magenta),
            ServicesType(name:"Professor Particular",image:"diploma", background:UIColor.purple),
            ServicesType(name:"Cozinheira",image:"cupcake", background:UIColor.red)
    ]
    
    
}


extension UIColor {
    convenience init(hexString: String) {
        let hex = hexString.trimmingCharacters(in: CharacterSet.alphanumerics.inverted)
        var int = UInt32()
        Scanner(string: hex).scanHexInt32(&int)
        let a, r, g, b: UInt32
        switch hex.characters.count {
        case 3: // RGB (12-bit)
            (a, r, g, b) = (255, (int >> 8) * 17, (int >> 4 & 0xF) * 17, (int & 0xF) * 17)
        case 6: // RGB (24-bit)
            (a, r, g, b) = (255, int >> 16, int >> 8 & 0xFF, int & 0xFF)
        case 8: // ARGB (32-bit)
            (a, r, g, b) = (int >> 24, int >> 16 & 0xFF, int >> 8 & 0xFF, int & 0xFF)
        default:
            (a, r, g, b) = (255, 0, 0, 0)
        }
        self.init(red: CGFloat(r) / 255, green: CGFloat(g) / 255, blue: CGFloat(b) / 255, alpha: CGFloat(a) / 255)
    }
}

struct Style{
    static var mainNavigationBarColor = UIColor.init(hexString: ("202FFF"))
}
