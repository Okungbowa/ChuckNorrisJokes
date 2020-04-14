//
//  LoadingCell.swift
//  Chuck Norris Jokes
//
//  Created by Joshua Okungbowa on 12/04/2020.
//  Copyright © 2020 Joshua Okungbowa. All rights reserved.
//

import UIKit

class LoadingCell: UITableViewCell {

    @IBOutlet weak var activityIndicator: UIActivityIndicatorView!
    
    override func awakeFromNib() {
        super.awakeFromNib()
        // Initialization code
    }

    override func setSelected(_ selected: Bool, animated: Bool) {
        super.setSelected(selected, animated: animated)
        // Configure the view for the selected state
    }
    
}
