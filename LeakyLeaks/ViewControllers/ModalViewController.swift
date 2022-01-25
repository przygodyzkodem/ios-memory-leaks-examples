//
//  ModalViewController.swift
//  LeakyLeaks
//
//  Created by Michał Zięba on 23/01/2022.
//

import UIKit

class ModalViewController: UIViewController {
    
    var closeActionHandler: (() -> Void)?
    
    @IBAction func closeButtonAction(_ sender: Any) {
        closeActionHandler?()
    }
}
