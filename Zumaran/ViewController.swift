//
//  ViewController.swift
//  Zumaran
//
//  Created by DAMII on 22/04/24.
//

import UIKit
import CoreData

class ViewController: UIViewController, UITableViewDataSource, UITableViewDelegate, NSFetchedResultsControllerDelegate {
    
    
    
    @IBOutlet weak var tvAgenda: UITableView!
    
    @IBOutlet weak var lblFiltro: UITextField!
    
    var listaAgendas:[AgendaEntity]=[]
    var filtro:[AgendaEntity]=[]
    var index = -1
    

    override func viewDidLoad() {
        super.viewDidLoad()
        llenarDatos()
        tvAgenda.dataSource = self
        tvAgenda.delegate = self
        tvAgenda.rowHeight = 150
    }
    
    
    
    func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        if  !filtro.isEmpty{
            return filtro.count
        }
        return listaAgendas.count
    }
    
    func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        let p2 = tvAgenda.dequeueReusableCell(withIdentifier: "row") as! ItemTableViewCell
        if !filtro.isEmpty{
            p2.lblNombre.text = "Nombre : \(filtro[indexPath.row].nombre!)"
            p2.lblApellido.text = "Apellido : \(filtro[indexPath.row].apellido!)"
        } else {
            p2.lblNombre.text = "Nombre : \(listaAgendas[indexPath.row].nombre!)"
            p2.lblApellido.text = "Apellido : \(listaAgendas[indexPath.row].apellido!)"
        }
        return p2
    }
    
    func tableView(_ tableView: UITableView, didSelectRowAt indexPath: IndexPath) {
        index=indexPath.row
        
        let txt = "Codigo: \(listaAgendas[indexPath.row].codigo!)\nNombre : \(listaAgendas[indexPath.row].nombre!)\nApellido : \(listaAgendas[indexPath.row].apellido!)\nOperador : \(listaAgendas[indexPath.row].operador!)\nNumero de Celular : \(listaAgendas[indexPath.row].celular!)"
        
        var ventana = UIAlertController(title: "Detalle Agenda", message: txt, preferredStyle: .alert)
        
        ventana.addAction(UIAlertAction(title: "OK", style: .cancel))
        
        present(ventana, animated: true)
        
    }
    

    @IBAction func btnNuevaAgenda(_ sender: UIButton) {
        performSegue(withIdentifier: "agregar", sender: nil)
    }
    @IBAction func btnBuscar(_ sender: UIButton) {
        if lblFiltro.text ?? nil != nil {
            filtrar(lblFiltro.text!)
        }
        
    }
    func filtrar(_ str:String) {
        filtro.removeAll()
        for agenda in listaAgendas {
            if agenda.apellido!.lowercased().contains(str.lowercased()) {
                filtro.append(agenda)
            }
        }
        tvAgenda.reloadData()
    }
    
    override func prepare(for segue: UIStoryboardSegue, sender: Any?) {
        let vc = segue.destination as! AgregarViewController
    }
    
    
    func llenarDatos() {
        listaAgendas = ControladorProducto().listarAgendas()
    }
    
    
    
}

