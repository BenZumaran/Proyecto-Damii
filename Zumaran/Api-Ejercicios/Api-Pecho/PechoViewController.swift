//
//  PechoViewController.swift
//  Zumaran
//
//  Created by DAMII on 12/05/24.
//

import UIKit
import Alamofire
class PechoViewController: UIViewController , UITableViewDataSource, UITableViewDelegate {

    @IBOutlet weak var tbPecho: UITableView!
    
    
        
        
        
        var listaEjercicios:[Ejercicio]=[]
        var index = -1
        
        override func viewDidLoad() {
            super.viewDidLoad()
            
            traerJSON()
            tbPecho.dataSource = self
            tbPecho.delegate = self
            tbPecho.rowHeight = 250
        }
        
        
        
        func traerJSON(){
            AF.request("https://suscripcion-node-mysql-production.up.railway.app/api/ejercicio").responseDecodable(of:[Ejercicio].self){ x in
                //Validar si data es null
                guard let info = x.value else { return }
                self.listaEjercicios = info
                self.tbPecho.reloadData()
                print(self.listaEjercicios)
            }
        }
        
        func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
            return listaEjercicios.count
        }
        
        func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
            let p3 = tbPecho.dequeueReusableCell(withIdentifier: "itemPecho") as! ItemPechoTableViewCell
            p3.lblNombrePecho.text = "Nombre : \(listaEjercicios[indexPath.row].nombre )"
            
            p3.lblTipos.text = "Tipós : \(listaEjercicios[indexPath.row].tipo)"
            p3.lblDificultad.text = "Dificultad : \(listaEjercicios[indexPath.row].dificultad)"
            p3.lblInstruccion.text = "Instrucciopn : \(listaEjercicios[indexPath.row].instruccion)"
            
            return p3
            
        }
        
    
}
