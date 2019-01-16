//
//  Alertable.swift
//  Stickman Runner
//
//  Created by Vlad Munteanu on 1/12/19.
//  Copyright © 2019 LesGarcons. All rights reserved.
//

import SpriteKit

protocol Alertable { }
extension Alertable where Self: SKScene {
    
    func showAlert(withTitle title: String, message: String) {
        
        let alertController = UIAlertController(title: title, message: message, preferredStyle: .alert)
        
//        let okAction = UIAlertAction(title: "OK", style: .cancel) { _ in }
//        alertController.addAction(okAction)
        
        alertController.addTextField(configurationHandler: { (textField) -> Void in
            textField.text = ""
        })
        
        alertController.addAction(UIAlertAction(title: "OK", style: .default, handler: { (action) -> Void in
            let textField = alertController.textFields![0] as UITextField
            
            if(textField.text != "") {
            print("Text field: \(textField.text)")
            currentName = textField.text!
            let scene = NormalGameScene(size: self.size)
            self.view?.presentScene(scene)
            }
        }))
        
        view?.window?.rootViewController?.present(alertController, animated: true)
    }
    
    func showAlertWithSettings(withTitle title: String, message: String) {
        
        let alertController = UIAlertController(title: title, message: message, preferredStyle: .alert)
        
        let okAction = UIAlertAction(title: "OK", style: .cancel) { _ in }
        alertController.addAction(okAction)
        
        let settingsAction = UIAlertAction(title: "Settings", style: .default) { _ in
            
            guard let url = URL(string: UIApplication.openSettingsURLString) else { return }
            if #available(iOS 10.0, *) {
                UIApplication.shared.open(url)
            } else {
                UIApplication.shared.openURL(url)
            }
        }
        alertController.addAction(settingsAction)
        
        view?.window?.rootViewController?.present(alertController, animated: true)
    }
}
