//
//  MedicamentoViewController.swift
//  Zumaran
//
//  Created by DAMII on 28/04/24.
//

import UIKit
import Alamofire
import AlamofireImage

class MedicamentoViewController: UIViewController, UITableViewDataSource, UITableViewDelegate {
    
    
    @IBOutlet weak var tvMedicamento: UITableView!
    
    var listaMedicamento:[Medicamento]=[]
    var listaEjercicios:[Ejercicio]=[]
    var index = -1

    override func viewDidLoad() {
        super.viewDidLoad()
        traerJSON()
        tvMedicamento.dataSource = self
        tvMedicamento.delegate = self
        tvMedicamento.rowHeight = 100
        
    }
    
    
    func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        return listaEjercicios.count
    }
    
    func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        
        let p3 = tvMedicamento.dequeueReusableCell(withIdentifier: "item") as! ItemMedicamentoTableViewCell
        p3.lblCodigo.text = "Codigo : \(String(listaEjercicios[indexPath.row].idEjercicio) )"
        p3.lblNombre.text = "Nombre : \(listaEjercicios[indexPath.row].nombre)"
        
        return p3
        
    }
    
    func tableView(_ tableView: UITableView, didSelectRowAt indexPath: IndexPath) {
        index = indexPath.row
        performSegue(withIdentifier: "crudMedicamento", sender: nil)
    }
    
    func traerJSON(){
        AF.request("https://suscripcion-node-mysql-production.up.railway.app/api/ejercicio").responseDecodable(of:[Ejercicio].self){ x in
            //Validar si data es null
            guard let info = x.value else { return }
            self.listaEjercicios = info
            self.tvMedicamento.reloadData()
            print(self.listaEjercicios)
        }
        
        /*responseDecodable(of:[Ejercicio].self){ x in
            //Validar si data es null
            print(x)
            guard let info = x.value else { return }
            self.listaEjercicios = info
            self.tvMedicamento.reloadData()
            print(self.listaEjercicios)
        }*/
        
    }
    
    struct Model: Codable{
    var idEjercicio:Int
        var tipo:String
        var nombre:String
        var musculo:String
        var dificultad:String
        var instruccion:String
        var imagen:String
    }

    
    @IBAction func btnRegistrarMedicamento(_ sender: UIButton) {
        performSegue(withIdentifier: "registraMedicamento", sender: nil)
    }
    override func prepare(for segue: UIStoryboardSegue, sender: Any?) {
        
        if segue.identifier == "registraMedicamento" {
            
        } else {
            let vc = segue.destination as! CrudMedicamentoViewController
            vc.medicamento = listaMedicamento[index]
            
        }
    }
    
}
