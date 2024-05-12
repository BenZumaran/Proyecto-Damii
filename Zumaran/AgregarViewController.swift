//
//  AgregarViewController.swift
//  Zumaran
//
//  Created by DAMII on 22/04/24.
//

import UIKit
import DropDown


class AgregarViewController: UIViewController {
    
    @IBOutlet weak var txtCodigo: UITextField!
    
    @IBOutlet weak var txtNombre: UITextField!
    
    @IBOutlet weak var txtApellido: UITextField!
        
    @IBOutlet weak var txtCelular: UITextField!
    
    @IBOutlet weak var dropOperador: UIButton!
    
    var lista:[AgendaEntity] = []
    
    let dropDown = DropDown()
        
    override func viewDidLoad() {
        
        super.viewDidLoad()
        lista = ControladorProducto().listarAgendas()
    }

    @IBAction func btnGrabar(_ sender: UIButton) {
        let cod = txtCodigo.text ?? "",
            nom = txtNombre.text ?? "",
            ape = txtApellido.text ?? "",
            ope = dropOperador.titleLabel?.text ?? "",
            cel = txtCelular.text ?? ""
        
        
        var obj = Agenda(codigo: cod, nombre: nom, apellido: ape, operador: ope, celular: cel)
        
        for agenda in lista {
            
            if agenda.codigo == cod {
                
                var ventana = UIAlertController(title: "Error en registro", message: "La agenda : \(cod) ya existe.", preferredStyle: .alert)
                
                
                //ventana.addAction(UIAlertAction(title: "OK", style: .cancel))
                ventana.addAction(UIAlertAction(title: "OK", style: .default, handler: {
                    x in self.performSegue(withIdentifier: "retorno", sender: nil)
                }))
                
                present(ventana, animated: true)
                
                
                
                return
            }
        }
                if ControladorProducto().registrarAgenda(bean: obj) {
                    
                    lista = ControladorProducto().listarAgendas()
                    
                    var msg = "Se registro correctamente la agenda : \(cod)\nCliente : \(nom) \(ape)"
                    var ventana = UIAlertController(title: "Registro Exitoso", message: msg, preferredStyle: .alert)
                    
                    ventana.addAction(UIAlertAction(title: "OK", style: .cancel))
                    
                    present(ventana, animated: true)
                    
            
                
            
            
            
            
        }
        
        print(dropOperador.titleLabel?.text ?? "")
            
        limpiar()
        

    }
    @IBAction func btnVolver(_ sender: UIButton) {
    performSegue(withIdentifier: "retorno", sender: nil)
    }
    
    override func prepare(for segue: UIStoryboardSegue, sender: Any?) {
        let vc = segue.destination as! ViewController
        vc.listaAgendas = lista
    }
    @IBAction func ddOperador(_ sender: Any) {
        
        dropDown.anchorView = dropOperador
        dropDown.dataSource = ["Manual","Automatico","Reusable"]
        dropDown.direction = .bottom
        dropDown.bottomOffset = CGPoint(x: 0, y:(dropDown.anchorView?.plainView.bounds.height)!)
        dropDown.selectionAction = { [unowned self] (index: Int, item: String) in
            dropOperador.setTitle(item, for: UIControl.State.normal)
           }
        dropDown.show()
        
    }
    
    
    func limpiar() {
        txtCodigo.text = ""
        txtNombre.text = ""
        txtApellido.text = ""
        dropOperador.setTitle("", for: .normal)
        txtCelular.text = ""
    }
    
}
