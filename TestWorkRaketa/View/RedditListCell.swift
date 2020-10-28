//
//  RedditListCell.swift
//  TestWorkRaketa
//
//  Created by Vladimirus on 28.10.2020.
//

import UIKit

class RedditListCell: UITableViewCell {
    
    @IBOutlet weak var authorName: UILabel!
    @IBOutlet weak var entryDate: UILabel!
    @IBOutlet weak var titleInfo: UILabel!
    @IBOutlet weak var numberOfComments: UILabel!
    @IBOutlet weak var thumbnail: UIImageView!
    

    override func awakeFromNib() {
        super.awakeFromNib()
        // Initialization code
    }

    override func setSelected(_ selected: Bool, animated: Bool) {
        super.setSelected(selected, animated: animated)

        // Configure the view for the selected state
    }
    
}
