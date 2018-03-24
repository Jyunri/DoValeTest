//
//  ServicesTableViewCell.swift
//  DoVale Test
//
//  Created by Jimy Suenaga on 19/08/17.
//  Copyright © 2017 Audience Marketing. All rights reserved.
//

import UIKit

class ServicesTypeTableViewCell: UITableViewCell {
    
    @IBOutlet var serviceTypeLabel: UILabel!
    @IBOutlet var serviceTypeImageView: UIImageView!
    @IBOutlet var serviceBackground: UIView!
    
    override func awakeFromNib() {
        super.awakeFromNib()
        // Initialization code
    }

    override func setSelected(_ selected: Bool, animated: Bool) {
        super.setSelected(selected, animated: animated)

        // Configure the view for the selected state
    }

}
