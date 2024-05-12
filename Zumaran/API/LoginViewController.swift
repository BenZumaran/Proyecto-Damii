//
//  LoginViewController.swift
//  Zumaran
//
//  Created by DAMII on 29/04/24.
//


import UIKit
import FirebaseAuth

class LoginViewController: UIViewController {
    @IBOutlet weak var txtCorreo: UITextField!
    
    @IBOutlet weak var txtCodigo: UITextField!
    override func viewDidLoad() {
        super.viewDidLoad()

        // Do any additional setup after loading the view.
    }
    
    @IBAction func btnIngresar(_ sender: UIButton) {
        let login=txtCorreo.text ?? "", clave = txtCodigo.text ?? ""
        validarUsuario(vLogin: login.trimmingCharacters(in: .whitespacesAndNewlines), vClave: clave)
    }
    
    func validarUsuario(vLogin:String, vClave:String){
        Auth.auth().signIn(withEmail: vLogin, password: vClave){
            response,error in
            //Validar parametro response
            if let data = response {
                print("Login correcto")
                print("UUID : \(data.user.uid)")
                
                // Navegar a la vista Home
                DispatchQueue.main.async {
                    self.performSegue(withIdentifier: "irHome", sender: nil)
                }
            } else {
                print(error!.localizedDescription)
            }
        }
    }
    @IBAction func btnCrearCuenta(_ sender: UIButton) {
        performSegue(withIdentifier: "crearCuenta", sender: nil)
    }
    
}
