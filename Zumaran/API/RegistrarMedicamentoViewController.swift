//
//  RegistrarMedicamentoViewController.swift
//  Zumaran
//
//  Created by DAMII on 28/04/24.
//

import UIKit
import Alamofire

class RegistrarMedicamentoViewController: UIViewController {
    
    @IBOutlet weak var txtNombre: UITextField!
    
    @IBOutlet weak var txtStock: UITextField!
    
    @IBOutlet weak var txtPrecio: UITextField!
    
    var listaMedicamentos:[Medicamento] = []
    

    override func viewDidLoad() {
        super.viewDidLoad()

        
        
    }
    
    @IBAction func btnGrabar(_ sender: UIButton) {
        let nom = txtNombre.text ?? "",
        stk = Int(txtStock.text ?? "") ?? 0,
        pre = Double(txtPrecio.text ?? "") ?? 0
        saveMedicamento(obj: Medicamento(codigo: 0, nombre: nom, stock: stk, precio: pre))
    }
    
    @IBAction func btnVolver(_ sender: UIButton) {
        performSegue(withIdentifier: "volverTablaMedicamento", sender: nil)
    }
    
    func saveMedicamento(obj:Medicamento){
        AF.request("https://puedeser.onrender.com/medicamento/registrar",
                   method: .post, parameters: obj, encoder: JSONParameterEncoder.default).response(completionHandler: { x in
            //Evaluar la respuesta
            switch x.result {
            case.success(let y):
                do {
                    let info = try JSONDecoder().decode(Medicamento.self, from: y!)
                    var ventana = UIAlertController(title: "Medicamento Registrado", message: "Codigo : \(info.codigo)\nNombre : \(info.nombre)\nStock : \(info.stock)\nPrecio : \(info.precio)", preferredStyle: .alert)
                    
                    ventana.addAction(UIAlertAction(title: "OK", style: .cancel))
                    self.present(ventana, animated: true)
                    
                    self.limpiarTexts()
                    
                    print("Codigo generado: \(info.codigo)")
                } catch {
                    print("Error en el JSON")
                }
            case .failure(let z):
                print(z.localizedDescription)
            }
            
        })
        
        /*v
         ar ventana = UIAlertController(title: "Detalle Agenda", message: txt, preferredStyle: .alert)
         
         ventana.addAction(UIAlertAction(title: "OK", style: .cancel))
         */
        
    }
    
    func limpiarTexts(){
        txtStock.text = ""
        txtNombre.text = ""
        txtPrecio.text = ""
    }
    
    
}
