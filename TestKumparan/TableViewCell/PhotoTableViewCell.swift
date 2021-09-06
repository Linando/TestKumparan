//
//  PhotoTableViewCell.swift
//  TestKumparan
//
//  Created by Linando Saputra on 06/09/21.
//

import UIKit

//protocol PhotoDelegate{
//    func photoIsTapped(_ photoID: Int)
//}

class PhotoTableViewCell: UITableViewCell {
    
    
    @IBOutlet weak var leftPhoto: UIImageView!
    @IBOutlet weak var middlePhoto: UIImageView!
    @IBOutlet weak var rightPhoto: UIImageView!
    
    
    override func awakeFromNib() {
        super.awakeFromNib()
        
    }
    
    override func setSelected(_ selected: Bool, animated: Bool) {
        super.setSelected(selected, animated: animated)
        
    }
    
}
