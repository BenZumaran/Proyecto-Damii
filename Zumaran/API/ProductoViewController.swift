//
//  ProductoViewController.swift
//  Zumaran
//
//  Created by DAMII on 5/05/24.
//

import UIKit
import FirebaseFirestore

class ProductoViewController: UIViewController, UITableViewDelegate, UITableViewDataSource {

    @IBOutlet weak var tvProductos: UITableView!
    
    var listaProductos:[Producto]=[]
    
    override func viewDidLoad() {
        super.viewDidLoad()
        tvProductos.dataSource=self
        tvProductos.delegate=self
        tvProductos.rowHeight=100
        llenarDatos()
    }
    
    
    func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        listaProductos.count
    }
    
    func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        let v2 = tvProductos.dequeueReusableCell(withIdentifier: "item") as! ItemProductoTableViewCell
        v2.lblNombre.text = listaProductos[indexPath.row].nombre
        return v2
    }
    
    func llenarDatos(){
        let DB = Firestore.firestore()
        DB.collection("producto").addSnapshotListener{
            (data, error) in
            guard let info = data?.documents else { return }
            self.listaProductos = info.map{(bean) -> Producto in
                let row = bean.data()
                let nom = row["nombre"] as! String
                let pre = row["precio"] as! Double
                return Producto(nombre: nom, precio: pre)
            }
            self.tvProductos.reloadData()
        }
    }
    

}
