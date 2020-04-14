//
//  JokeCell.swift
//  Chuck Norris Jokes
//
//  Created by Joshua Okungbowa on 11/04/2020.
//  Copyright © 2020 Joshua Okungbowa. All rights reserved.
//

import UIKit

class JokeCell: UITableViewCell {

    @IBOutlet weak var jokeLabel: UILabel!
    
    override func awakeFromNib() {
        super.awakeFromNib()
    }

    override func setSelected(_ selected: Bool, animated: Bool) {
        super.setSelected(selected, animated: animated)
        // Configure the view for the selected state
    }

}
