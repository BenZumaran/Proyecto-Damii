//
//  ItemBrazosTableViewCell.swift
//  Zumaran
//
//  Created by DAMII on 12/05/24.
//

import UIKit

class ItemBrazosTableViewCell: UITableViewCell {

    
 
    
    @IBOutlet weak var lblNombreBrazos: UILabel!
    @IBOutlet weak var lblTipos: UILabel!
    @IBOutlet weak var lblInstruccion: UILabel!
    @IBOutlet weak var lblDificultad: UILabel!
    
    @IBOutlet weak var imgBrazos: UIImageView!
    
    override func awakeFromNib() {
        super.awakeFromNib()
      
    }

    override func setSelected(_ selected: Bool, animated: Bool) {
        super.setSelected(selected, animated: animated)

       
    }

}
