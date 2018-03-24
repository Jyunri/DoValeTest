//
//  Services.swift
//  DoVale Test
//
//  Created by Jimy Suenaga on 20/08/17.
//  Copyright © 2017 Audience Marketing. All rights reserved.
//

import Foundation

class Services{
    var servicePartnerName = ""
    var servicePartnerAddress = ""
    var servicePartnerPhone = ""
    var servicePreview =  ""
    var servicePartnerProfileImage = ""
    var serviceType: ServicesType
    var isFavorite = false
    var serviceRating = 3.0
    
    init(servicePartnerName:String, servicePartnerAddress:String, servicePartnerPhone:String,servicePreview:String, servicePartnerProfileImage:String, serviceType: ServicesType){
        self.servicePartnerName = servicePartnerName
        self.servicePartnerAddress = servicePartnerAddress
        self.servicePartnerPhone = servicePartnerPhone
        self.servicePreview =  servicePreview
        self.servicePartnerProfileImage = servicePartnerProfileImage
        self.serviceType = serviceType
    }
}
