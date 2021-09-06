//
//  CommentTableViewCell.swift
//  TestKumparan
//
//  Created by Linando Saputra on 06/09/21.
//

import UIKit

class CommentTableViewCell: UITableViewCell {

    @IBOutlet weak var commentAuthorNameLabel: UILabel!
    @IBOutlet weak var commentBodyLabel: UILabel!
    
    override func awakeFromNib() {
        super.awakeFromNib()
        // Initialization code
    }

    override func setSelected(_ selected: Bool, animated: Bool) {
        super.setSelected(selected, animated: animated)

        // Configure the view for the selected state
    }

}
