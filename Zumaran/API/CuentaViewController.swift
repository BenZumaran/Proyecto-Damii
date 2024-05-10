//
//  CuentaViewController.swift
//  Zumaran
//
//  Created by DAMII on 5/05/24.
//

import UIKit
import Alamofire
import FirebaseFirestore
import FirebaseAuth

class CuentaViewController: UIViewController {

    @IBOutlet weak var txtCorreo: UITextField!
    
    @IBOutlet weak var txtNombre: UITextField!
    
    @IBOutlet weak var txtApellido: UITextField!
    @IBOutlet weak var txtHijos: UITextField!
    
    @IBOutlet weak var txtClave: UITextField!
    
    
    override func viewDidLoad() {
        super.viewDidLoad()

        
    }
    
    @IBAction func btnGrabar(_ sender: UIButton) {
        let nom = txtNombre.text ?? "",
        correo = txtCorreo.text ?? "",
        hijos = Int(txtHijos.text ?? "") ?? 0,
        clave = txtClave.text ?? "",
        ape = txtApellido.text ?? ""
        grabarCuenta(vNombre: nom, vApe: ape, vHijos: hijos, vCorre: correo, vClave: clave)
        
        
    }
    
    func grabarCuenta(vNombre:String, vApe:String, vHijos:Int, vCorre:String, vClave:String){
        Auth.auth().createUser(withEmail: vCorre, password: vClave){
            data,error in
            if let info = data {
                print("Correcto")
                
                let uid = info.user.uid
                
                self.grabarEmpleado(nom: vNombre, ape: vApe, hijos: vHijos, UID: uid)
            } else {
                print("Error en el registro")
            }
        }
    }
    func grabarEmpleado(nom:String, ape:String, hijos:Int, UID:String){
        let BD = Firestore.firestore()
        BD.collection("empleado").document(UID).setData([
            "nombre":nom,
            "apellido":ape,
            "hijos":hijos
        ]){
            result in
            if let info=result{
                print("Error en el registro de empleado")
            } else{
                print("Registro ok")
            }
        }
    }
}
