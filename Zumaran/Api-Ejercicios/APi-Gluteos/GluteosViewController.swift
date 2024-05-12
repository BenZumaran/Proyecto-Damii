//
//  GluteosViewController.swift
//  Zumaran
//
//  Created by DAMII on 12/05/24.
//

import UIKit
import Alamofire
import Kingfisher
class GluteosViewController: UIViewController, UITableViewDataSource, UITableViewDelegate  {

 
    @IBOutlet weak var tbGluteos: UITableView!
    
        
        var listaEjercicios:[Ejercicio]=[]
        var index = -1
        
        override func viewDidLoad() {
            super.viewDidLoad()
            
            traerJSON()
            tbGluteos.dataSource = self
            tbGluteos.delegate = self
            tbGluteos.rowHeight = 250
        }
        

        
        func traerJSON(){
            AF.request("https://suscripcion-node-mysql-production.up.railway.app/api/ejercicio/musculo/gluteos").responseDecodable(of:[Ejercicio].self){ x in
                //Validar si data es null
                guard let info = x.value else { return }
                self.listaEjercicios = info
                self.tbGluteos.reloadData()
                print(self.listaEjercicios)
            }
        }
            
            func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
                return listaEjercicios.count
            }
            
            func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
                let p3 = tbGluteos.dequeueReusableCell(withIdentifier: "itemGluteos") as! ItemGluteosTableViewCell
                p3.lblNombreGluteos.text = "Nombre : \(listaEjercicios[indexPath.row].nombre )"
                
                p3.lblTipos.text = "Tipós : \(listaEjercicios[indexPath.row].tipo)"
                p3.lblDificultad.text = "Dificultad : \(listaEjercicios[indexPath.row].dificultad)"
                p3.lblInstruccion.text = "Instrucciopn : \(listaEjercicios[indexPath.row].instruccion)"
                
                p3.imgGluteos.kf.setImage(with: URL(string: listaEjercicios[indexPath.row].imagen))
                
                return p3
               
            }


}
