//
//  ControladorProducto.swift
//  Zumaran
//
//  Created by DAMII on 22/04/24.
//

import UIKit

class ControladorProducto {
    func registrarAgenda(bean:Agenda) -> Bool{
        var delegate = UIApplication.shared.delegate as! AppDelegate
        var contextDB = delegate.persistentContainer.viewContext
        var tabla = AgendaEntity(context: contextDB)
        
        tabla.codigo = bean.codigo
        tabla.nombre = bean.nombre
        tabla.apellido = bean.apellido
        tabla.operador = bean.operador
        tabla.celular = bean.celular
        
        do {
            try contextDB.save()
        }
        catch let error as NSError {
            print(error.localizedDescription)
            return false
        }
        return true
    }
    
    func listarAgendas()->[AgendaEntity] {
        var data:[AgendaEntity]!
        
        var delegate = UIApplication.shared.delegate as! AppDelegate
        var contextDB = delegate.persistentContainer.viewContext
        
        do{
            var datos = AgendaEntity.fetchRequest()
            try data = contextDB.fetch(datos)
        }
        catch let error as NSError {
            print(error.localizedDescription)
        }
        
        return data
        
    }
    
    

}
