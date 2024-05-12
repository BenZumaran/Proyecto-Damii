//
//  PiernaViewController.swift
//  Zumaran
//
//  Created by DAMII on 12/05/24.
//

import UIKit
import Alamofire

class PiernaViewController: UIViewController, UITableViewDataSource, UITableViewDelegate  {

    @IBOutlet weak var tbPierna: UITableView!
    
    
    
    
    var listaEjercicios:[Ejercicio]=[]
    var index = -1
    
    override func viewDidLoad() {
        super.viewDidLoad()
        
        traerJSON()
        tbPierna.dataSource = self
        tbPierna.delegate = self
        tbPierna.rowHeight = 250
    }
    

    
    func traerJSON(){
        AF.request("https://suscripcion-node-mysql-production.up.railway.app/api/ejercicio").responseDecodable(of:[Ejercicio].self){ x in
            //Validar si data es null
            guard let info = x.value else { return }
            self.listaEjercicios = info
            self.tbPierna.reloadData()
            print(self.listaEjercicios)
        }
    }
        
        func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
            return listaEjercicios.count
        }
        
        func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
            let p3 = tbPierna.dequeueReusableCell(withIdentifier: "itemPierna") as! ItemPiernaTableViewCell
            p3.lblNombrePierna.text = "Nombre : \(listaEjercicios[indexPath.row].nombre )"
            
            p3.lblTipos.text = "Tipós : \(listaEjercicios[indexPath.row].tipo)"
            p3.lblDificultad.text = "Dificultad : \(listaEjercicios[indexPath.row].dificultad)"
            p3.lblInstruccion.text = "Instrucciopn : \(listaEjercicios[indexPath.row].instruccion)"
            
            return p3
           
        }


}
