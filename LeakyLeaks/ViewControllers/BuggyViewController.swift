//
//  BuggyViewController.swift
//  LeakyLeaks
//
//  Created by Michał Zięba on 23/01/2022.
//

import UIKit

final class BuggyViewController: UIViewController {
    
    override func viewDidLoad() {
        super.viewDidLoad()
        navigationController?.setNavigationBarHidden(true, animated: false)
    }
    
    @IBAction func backButtonAction(_ sender: Any) {
        //Example 2 - "Silly" mistake in application's logic. Instead of popping back to MainViewController we push a new instance of this class,
        // which in turn can create another instance of BuggyViewController object.
        guard let mainViewController = UIStoryboard(name: "MainViewController", bundle: nil).instantiateInitialViewController() else { return }
        navigationController?.pushViewController(mainViewController, animated: true)
        
        //To fix uncomment line below and remove the logic above.
        /*navigationController?.popViewController(animated: true)*/
    }
}
