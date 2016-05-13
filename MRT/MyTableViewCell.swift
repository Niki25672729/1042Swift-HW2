//
//  MyTableViewCell.swift
//  MRT
//
//  Created by Niki25672729 on 5/13/16.
//  Copyright © 2016 Niki. All rights reserved.
//

import UIKit

class MyTableViewCell: UITableViewCell {

    @IBOutlet weak var TitleLabel: UILabel!
    @IBOutlet weak var LineNumberLabelR: UILabel!
    @IBOutlet weak var LineNumberLabelL: UILabel!
    override func awakeFromNib() {
        super.awakeFromNib()
        // Initialization code
    }

    override func setSelected(selected: Bool, animated: Bool) {
        super.setSelected(selected, animated: animated)

        // Configure the view for the selected state
    }

}
