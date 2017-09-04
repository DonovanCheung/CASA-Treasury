//
//  TableViewCell.swift
//  CASA Treasury
//
//  Created by Donovan Cheung on 8/11/17.
//  Copyright © 2017 Donovan Cheung. All rights reserved.
//

import UIKit

class TableViewCell: UITableViewCell {

	@IBOutlet weak var nameLabel: UILabel!
	
	@IBOutlet weak var timeLabel: UILabel!
	
	@IBOutlet weak var amountLabel: UILabel!
	
	
	
    override func awakeFromNib() {
        super.awakeFromNib()
        // Initialization code
    }

    override func setSelected(_ selected: Bool, animated: Bool) {
        super.setSelected(selected, animated: animated)

        // Configure the view for the selected state
    }
	
}
