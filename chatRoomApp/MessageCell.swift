//
//  MessageCell.swift
//  chatRoomApp
//
//  Created by 吉村舜也 on 2021/06/06.
//

import UIKit

class MessageCell: UITableViewCell {

    @IBOutlet weak var nameTextLabel: UILabel!
    @IBOutlet weak var messageTextLabel: UILabel!
    override func awakeFromNib() {
        super.awakeFromNib()
        // Initialization code
    }

    override func setSelected(_ selected: Bool, animated: Bool) {
        super.setSelected(selected, animated: animated)

        // Configure the view for the selected state
    }
    
}
