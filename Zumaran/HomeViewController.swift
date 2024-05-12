
import UIKit

import FirebaseAuth
import FirebaseFirestore

enum ProviderType : String{
     case basic
}

class HomeViewController: UIViewController {
    
    private let db = Firestore.firestore()
    
    @IBOutlet weak var txtId: UITextField!
    @IBOutlet weak var txtname: UITextField!
    
   
    
    
    @IBOutlet weak var btnSalirseccion: UIButton!
    @IBOutlet weak var lblEmail: UILabel!
    
    @IBOutlet weak var lblProvider: UILabel!
    
    
    override func viewDidLoad() {
        super.viewDidLoad()
        
        navigationItem.setHidesBackButton(true, animated: false)
        
        lblEmail.text = email
        lblProvider.text = provider.rawValue
        
        let defaults = UserDefaults.standard
        defaults.set(email, forKey: "email")
        defaults.set(provider.rawValue, forKey: "provider")
        defaults.synchronize()
     
    }
    
    private let email: String
    private let provider : ProviderType
    
    
    
    init(email:String , provider: ProviderType){
        self.email = email
        self.provider = provider
        super.init(nibName: nil, bundle: nil)
    }
    
    required init?(coder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }

    
    @IBAction func botonSalirAction(_ sender: Any) {
        let defaults = UserDefaults.standard
        
        defaults.removeObject(forKey: "email")
        defaults.removeObject(forKey: "provider")
        defaults.synchronize()
        
        
        
        switch provider {
        case .basic:
            do{
                try Auth.auth().signOut()
                navigationController?.popViewController(animated: true)
            }catch{
                
            }
        }
    }
    
    
    @IBAction func botonGuardarAction(_ sender: Any) {
        view.endEditing(true)
        
        db.collection("users").document(email).setData([
            "provider" : provider.rawValue ,
            "id" : txtId.text ?? "" ,
            "nombre" : txtname.text ?? ""], completion: { error in
                if let error = error {
                    let alertController = UIAlertController(title: "Error", message: "Error al guardar: \(error.localizedDescription)", preferredStyle: .alert)
                    alertController.addAction(UIAlertAction(title: "Aceptar", style: .default))
                    self.present(alertController, animated: true, completion: nil)
                } else {
                    let alertController = UIAlertController(title: "Éxito", message: "Datos guardados correctamente", preferredStyle: .alert)
                    alertController.addAction(UIAlertAction(title: "Aceptar", style: .default))
                    self.present(alertController, animated: true, completion: nil)
                }
        })
    }
    
    
    @IBAction func botonActualizarAction(_ sender: Any) {
        view.endEditing(true)
        
        db.collection("user").document(email).getDocument { documentSnapshot, error  in
            if let document = documentSnapshot , error == nil {
                if let id = document.get("id")  as? String{
                    self.txtId.text = id
                    
                } else {
                    self.txtId.text = ""
                }
                if let name = document.get("name") as? String{
                    self.txtname.text = name
                }else{
                    self.txtname.text = ""
                }
                
                let alertController = UIAlertController(title: "Éxito", message: "Datos actualizados correctamente", preferredStyle: .alert)
                alertController.addAction(UIAlertAction(title: "Aceptar", style: .default))
                self.present(alertController, animated: true, completion: nil)
                
            }else{
                self.txtId.text = ""
                self.txtname.text = ""
                
                let alertController = UIAlertController(title: "Error", message: "Error al actualizar datos", preferredStyle: .alert)
                alertController.addAction(UIAlertAction(title: "Aceptar", style: .default))
                self.present(alertController, animated: true, completion: nil)
            }
        }
    }
    

    @IBAction func botonElimarAction(_ sender: Any) {
        view.endEditing(true)
        
        db.collection("users").document(email).delete() { err in
            if let err = err {
                let alertController = UIAlertController(title: "Error", message: "Error al eliminar: \(err.localizedDescription)", preferredStyle: .alert)
                alertController.addAction(UIAlertAction(title: "Aceptar", style: .default))
                self.present(alertController, animated: true, completion: nil)
            } else {
                let alertController = UIAlertController(title: "Éxito", message: "Datos eliminados correctamente", preferredStyle: .alert)
                alertController.addAction(UIAlertAction(title: "Aceptar", style: .default))
                self.present(alertController, animated: true, completion: nil)
            }
        }
    }
   
    
}

