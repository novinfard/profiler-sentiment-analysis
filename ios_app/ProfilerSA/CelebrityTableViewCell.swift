//
//  CelebrityTableViewCell.swift
//  ProfilerSA
//
//  Created by Soheil on 19/08/2018.
//  Copyright © 2018 Novinfard. All rights reserved.
//

import UIKit

class CelebrityTableViewCell: UITableViewCell {

	@IBOutlet weak var celebAvatar: UIImageView!
	@IBOutlet weak var celebName: UILabel!
	
	override func awakeFromNib() {
        super.awakeFromNib()
        // Initialization code
    }

    override func setSelected(_ selected: Bool, animated: Bool) {
        super.setSelected(selected, animated: animated)

        // Configure the view for the selected state
    }

}
