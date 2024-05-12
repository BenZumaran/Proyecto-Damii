//
//  BrazosViewController.swift
//  Zumaran
//
//  Created by DAMII on 12/05/24.
//

import UIKit
import Alamofire
import Kingfisher

class BrazosViewController: UIViewController, UITableViewDataSource, UITableViewDelegate  {
   
    

    
    @IBOutlet weak var tbBrazos: UITableView!
    
    var listaEjercicios:[Ejercicio]=[]
    var index = -1
    
    override func viewDidLoad() {
        super.viewDidLoad()
        
        traerJSON()
        tbBrazos.dataSource = self
        tbBrazos.delegate = self
        tbBrazos.rowHeight = 250
    }
    

    
    func traerJSON(){
        AF.request("https://suscripcion-node-mysql-production.up.railway.app/api/ejercicio/musculo/brazos").responseDecodable(of:[Ejercicio].self){ x in
            //Validar si data es null
            guard let info = x.value else { return }
            self.listaEjercicios = info
            self.tbBrazos.reloadData()
            print(self.listaEjercicios)
        }
    }
        
        func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
            return listaEjercicios.count
        }
        
        func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
            let p3 = tbBrazos.dequeueReusableCell(withIdentifier: "itemBrazos") as! ItemBrazosTableViewCell
            p3.lblNombreBrazos.text = "Nombre : \(listaEjercicios[indexPath.row].nombre )"
            p3.lblTipos.text = "Tipós : \(listaEjercicios[indexPath.row].tipo)"
            p3.lblDificultad.text = "Dificultad : \(listaEjercicios[indexPath.row].dificultad)"
            p3.lblInstruccion.text = "Instruccion : \(listaEjercicios[indexPath.row].instruccion)"
            p3.imgBrazos.kf.setImage(with: URL(string: listaEjercicios[indexPath.row].imagen))
            
            return p3
           
        }

}
