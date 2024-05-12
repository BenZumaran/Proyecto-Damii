import UIKit
import Alamofire
import FirebaseFirestore
import FirebaseAuth

class CuentaViewController: UIViewController {

    @IBOutlet weak var txtCorreo: UITextField!
    
    @IBOutlet weak var txtNombre: UITextField!
    
    @IBOutlet weak var txtApellido: UITextField!
    @IBOutlet weak var txtEdad: UITextField!
    
    @IBOutlet weak var txtClave: UITextField!
    
    
    override func viewDidLoad() {
        super.viewDidLoad()

        
    }
    
    @IBAction func btnGrabar(_ sender: UIButton) {
        let nom = txtNombre.text ?? "",
        correo = txtCorreo.text ?? "",
        edad = Int(txtEdad.text ?? "") ?? 0,
        clave = txtClave.text ?? "",
        ape = txtApellido.text ?? ""
        grabarCuenta(vNombre: nom, vApe: ape, vEdad: edad, vCorre: correo, vClave: clave)
        
        
    }
    
    func grabarCuenta(vNombre:String, vApe:String, vEdad:Int, vCorre:String, vClave:String){
        Auth.auth().createUser(withEmail: vCorre, password: vClave){
            data,error in
            if let info = data {
                print("Correcto")
                self.mostrarAlertaRegistroExitoso()
                
                let uid = info.user.uid
                
                self.grabarEmpleado(nom: vNombre, ape: vApe, edad: vEdad, UID: uid)
            } else {
                print("Error en el registro")
                self.mostrarAlertaErrorRegistro()
            }
        }
    }
    func grabarEmpleado(nom:String, ape:String, edad:Int, UID:String){
        let BD = Firestore.firestore()
        BD.collection("empleado").document(UID).setData([
            "nombre":nom,
            "apellido":ape,
            "edad":edad
        ]){
            result in
            if let info=result{
                print("Error en el registro de empleado")
            } else{
                print("Registro ok")
                
            }
        }
    }
    
    func mostrarAlertaRegistroExitoso() {
         let alert = UIAlertController(title: "Registro Exitoso", message: "¡Tu cuenta ha sido creada con éxito!", preferredStyle: .alert)
         alert.addAction(UIAlertAction(title: "Aceptar", style: .default, handler: nil))
         present(alert, animated: true, completion: nil)
     }

     func mostrarAlertaErrorRegistro() {
         let alert = UIAlertController(title: "Error en el Registro", message: "Hubo un error al crear tu cuenta. Por favor, inténtalo nuevamente más tarde.", preferredStyle: .alert)
         alert.addAction(UIAlertAction(title: "Aceptar", style: .default, handler: nil))
         present(alert, animated: true, completion: nil)
     }
}

