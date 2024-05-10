//
//  ItemTableViewCell.swift
//  Zumaran
//
//  Created by DAMII on 22/04/24.
//

import UIKit

class ItemTableViewCell: UITableViewCell {

    @IBOutlet weak var lblNombre: UILabel!
    
    @IBOutlet weak var lblApellido: UILabel!
    
    
    override func awakeFromNib() {
        super.awakeFromNib()
        // Initialization code
    }

    override func setSelected(_ selected: Bool, animated: Bool) {
        super.setSelected(selected, animated: animated)

        // Configure the view for the selected state
    }

}
