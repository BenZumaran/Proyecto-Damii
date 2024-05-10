//
//  CrudMedicamentoViewController.swift
//  Zumaran
//
//  Created by DAMII on 29/04/24.
//

import UIKit
import Alamofire

class CrudMedicamentoViewController: UIViewController {
    
    @IBOutlet weak var txtCodigo: UITextField!
    
    @IBOutlet weak var txtNombre: UITextField!
    
    @IBOutlet weak var txtStock: UITextField!
    
    @IBOutlet weak var txtPrecio: UITextField!
    
    var medicamento:Medicamento!
    
    
    override func viewDidLoad() {
        super.viewDidLoad()
        txtCodigo.isEnabled = false
        txtCodigo.text = String(medicamento.codigo)
        txtNombre.text = medicamento.nombre
        txtStock.text = String(medicamento.stock)
        txtPrecio.text = String(medicamento.precio)
        
    }
    @IBAction func btnActualizar(_ sender: UIButton) {
        
        updateMedicamento(obj: Medicamento(codigo: medicamento.codigo, nombre: txtNombre.text ?? "", stock: Int(txtStock.text ?? "") ?? 0, precio: Double(txtPrecio.text ?? "") ?? 0))
    }
    
    @IBAction func btnEliminar(_ sender: UIButton) {
        
        
        var ventana = UIAlertController(title: "Confirmar Eliminacion", message: "Desea eliminar el medicamento : \(self.medicamento.nombre)?", preferredStyle: .alert)
        let actSi = UIAlertAction(title: "SI", style: .default, handler: { w in
            self.eliminarMedicamento(obj: self.medicamento.codigo)
            })
        let actNO = UIAlertAction(title: "NO", style: .cancel)
        
        ventana.addAction(actSi)
        ventana.addAction(actNO)
        
        self.present(ventana, animated: true)
        
        
    }
    @IBAction func btnVolver(_ sender: UIButton) {
        performSegue(withIdentifier: "volverDeCrudMedicamento", sender: nil)
    }
    
    func updateMedicamento(obj:Medicamento){
        AF.request("https://puedeser.onrender.com/medicamento/actualizar", method:  .put, parameters: obj, encoder: JSONParameterEncoder.default).response(completionHandler:{ x in
            switch x.result {
            case .success(let y):
                do{
                    let info = try JSONDecoder().decode(Medicamento.self, from: y!)
                    print("Codigo actualizado : \(info.codigo)")
                    var ventana = UIAlertController(title: "Medicamento Registrado", message: "Codigo : \(info.codigo)\nNombre : \(info.nombre)\nStock : \(info.stock)\nPrecio : \(info.precio)", preferredStyle: .alert)
                    
                    ventana.addAction(UIAlertAction(title: "OK", style: .cancel))
                    self.present(ventana, animated: true)
                } catch {
                    print("Error con JSON")
                }
            case .failure(let z):
                print(z.localizedDescription)
            }
        })
    }
    
    func eliminarMedicamento(obj:Int){
        AF.request("https://puedeser.onrender.com/medicamento/eliminar/\(obj)", method: .delete).response(completionHandler: { x in
            switch x.result {
            case .success:
                var ventana = UIAlertController(title: "Medicamento Eliminado", message: "Medicamento : \(self.medicamento.nombre) ha sido eliminado", preferredStyle: .alert)
                ventana.addAction(UIAlertAction(title: "OK", style: .cancel, handler: { w in
                    self.performSegue(withIdentifier: "volverDeCrudMedicamento", sender: nil)
                }))
                
                self.present(ventana, animated: true)
                print("Medicamento Eliminado")
            case .failure(let z):
                print(z.localizedDescription)
            }
        })
    }
    
    /*
     "https://puedeser.onrender.com/medicamento/eliminar/" + string
     
     
     func saveMedicamento(obj:Medicamento){
         AF.request("https://puedeser.onrender.com/medicamento/registrar",
                    method: .post, parameters: obj, encoder: JSONParameterEncoder.default).response(completionHandler: { x in
             //Evaluar la respuesta
             switch x.result {
             case.success(let y):
                 do {
                     let info = try JSONDecoder().decode(Medicamento.self, from: y!)
                     print("Codigo generado: \(info.codigo)")
                 } catch {
                     print("Error en el JSON")
                 }
             case .failure(let z):
                 print(z.localizedDescription)
             }
             
         })
     }
     */
    
    
}
