//
//  UIAlertControllerExtension.swift
//  Post It
//
//  Created by Catalin Neculaide on 25.04.2021.
//

import Foundation
import UIKit


extension UIAlertController{
    static func showOKAlert(on controller: UIViewController, title: String, message: String){
        let ac = UIAlertController(title: title, message: message, preferredStyle: .alert)
        ac.addAction(UIAlertAction(title: "OK", style: .default))
        controller.present(ac, animated: true)
    }
}
