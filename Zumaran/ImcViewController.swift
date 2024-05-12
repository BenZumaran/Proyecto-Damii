//
//  ImcViewController.swift
import UIKit

class ImcViewController: UIViewController {

    @IBOutlet weak var txtRespuesta: UILabel!
    @IBOutlet weak var labelAltura: UILabel!
    @IBOutlet weak var labelPeso: UILabel!
    
    @IBOutlet weak var SliAltura: UISlider!
    @IBOutlet weak var SliPeso: UISlider!
    
    override func viewDidLoad() {
        super.viewDidLoad()
    }
    
    @IBAction func btnCalcular(_ sender: UIButton) {
        let altura = Double(SliAltura.value)
        let peso = Double(SliPeso.value)
        
        // Actualizar los textos de los labels con los valores de los sliders
        labelAltura.text = String(format: "%.2f m", altura)
        labelPeso.text = String(format: "%.2f kg", peso)
        
        let imc = calcularIMC(peso: peso, altura: altura)
        mostrarResultadoIMC(imc)
    }
    
    
    @IBAction func alturSlider(_ sender: UISlider) {
        print(sender.value)
        labelAltura.text = "\(String(format: "%.2f m", sender.value))"
        
    }
    
    
    @IBAction func PesoSlider(_ sender: UISlider) {
        print(sender.value)
        labelPeso.text = "\(String(format: "%.2f kg", sender.value))"
    }
    
    
    
    
    
    
    func calcularIMC(peso: Double, altura: Double) -> Double {
        return peso / (altura * altura)
    }
    
    func mostrarResultadoIMC(_ imc: Double) {
        let formattedIMC = String(format: "%.3f", imc)
        var message = ""
        if imc < 18.5 {
            message = "Su IMC es \(formattedIMC). Está bajo de peso."
        } else if imc >= 18.5 && imc < 25 {
            message = "Su IMC es \(formattedIMC). Tiene un peso saludable."
        } else if imc >= 25 && imc < 30 {
            message = "Su IMC es \(formattedIMC). Tiene sobrepeso."
        } else {
            message = "Su IMC es \(formattedIMC). Tiene obesidad."
        }
        
        let alertController = UIAlertController(title: "Resultado del IMC", message: message, preferredStyle: .alert)
        let okAction = UIAlertAction(title: "OK", style: .default, handler: nil)
        alertController.addAction(okAction)
        present(alertController, animated: true, completion: nil)
    }
}
