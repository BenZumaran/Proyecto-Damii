//
//  ItemEspaldaTableViewCell.swift
//  Zumaran
//
//  Created by DAMII on 12/05/24.
//

import UIKit

class ItemAbdomenTableViewCell: UITableViewCell {

    
    @IBOutlet weak var lblNombreEspalda: UILabel!
    @IBOutlet weak var lblTipos: UILabel!
    @IBOutlet weak var lblInstruccion: UILabel!
    @IBOutlet weak var lblDificultad: UILabel!
    
    
    override func awakeFromNib() {
        super.awakeFromNib()
        // Initialization code
    }

    override func setSelected(_ selected: Bool, animated: Bool) {
        super.setSelected(selected, animated: animated)
        
        // Configure the view for the selected state
        
    }

}
