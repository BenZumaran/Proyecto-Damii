//
//  ItemMedicamentoTableViewCell.swift
//  Zumaran
//
//  Created by DAMII on 28/04/24.
//

import UIKit

class ItemMedicamentoTableViewCell: UITableViewCell {

    @IBOutlet weak var lblCodigo: UILabel!
    
    @IBOutlet weak var lblNombre: UILabel!
    
    override func awakeFromNib() {
        super.awakeFromNib()
        // Initialization code
    }

    override func setSelected(_ selected: Bool, animated: Bool) {
        super.setSelected(selected, animated: animated)

        // Configure the view for the selected state
    }

}
