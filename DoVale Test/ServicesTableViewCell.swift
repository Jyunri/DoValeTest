//
//  ServicesTableViewCell.swift
//  DoVale Test
//
//  Created by Jimy Suenaga on 19/08/17.
//  Copyright © 2017 Audience Marketing. All rights reserved.
//

import UIKit

class ServicesTableViewCell: UITableViewCell {
    
    @IBOutlet var servicePartnerName: UILabel!
    @IBOutlet var servicePartnerAddress: UILabel!
    @IBOutlet var servicePreview: UILabel!
    @IBOutlet var servicePartnerProfileImage: UIImageView!
    @IBOutlet var serviceRating: CosmosView!
    
    override func awakeFromNib() {
        super.awakeFromNib()
        // Initialization code
    }

    override func setSelected(_ selected: Bool, animated: Bool) {
        super.setSelected(selected, animated: animated)

        // Configure the view for the selected state
    }

}
