//
//  ItemPechoTableViewCell.swift
//  Zumaran
//
//  Created by DAMII on 12/05/24.
//

import UIKit

class ItemPechoTableViewCell: UITableViewCell {

    @IBOutlet weak var lblNombrePecho: UILabel!
    @IBOutlet weak var lblTipos: UILabel!
    @IBOutlet weak var lblInstruccion: UILabel!
    @IBOutlet weak var lblDificultad: UILabel!
    
    @IBOutlet weak var imgPecho: UIImageView!
    
    override func awakeFromNib() {
        super.awakeFromNib()
        // Initialization code
    }

    override func setSelected(_ selected: Bool, animated: Bool) {
        super.setSelected(selected, animated: animated)

        // Configure the view for the selected state
    }

}
