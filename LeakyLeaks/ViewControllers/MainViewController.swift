//
//  ViewController.swift
//  LeakyLeaks
//
//  Created by Michał Zięba on 23/01/2022.
//

import UIKit

class MainViewController: UIViewController {

    override func viewDidLoad() {
        super.viewDidLoad()
        navigationController?.setNavigationBarHidden(true, animated: false)
    }

    @IBAction func presentModalViewController(_ sender: Any) {
        //Example 1 - Memory leak in modal presentation. Closure assigned to `closeActionHandler` creates strong reference between MainViewController and ModalViewController classes by default.
        guard let modalViewController = UIStoryboard(name: "ModalViewController", bundle: nil).instantiateInitialViewController() as? ModalViewController else { return }
        
        modalViewController.closeActionHandler = {
            modalViewController.dismiss(animated: true, completion: nil)
        }
        
        //Solution to the memory leak problem:
        /*
        modalViewController.closeActionHandler = { [weak modalViewController] in
            modalViewController?.dismiss(animated: true, completion: nil)
        }
        */
        
        present(modalViewController, animated: true, completion: nil)
    }
    
    @IBAction func pushBuggyViewController(_ sender: Any) {
        guard let buggyViewController = UIStoryboard(name: "BuggyViewController", bundle: nil).instantiateInitialViewController() else { return }
        navigationController?.pushViewController(buggyViewController, animated: true)
    }
    
    @IBAction func initializeLeakyObject(_ sender: Any) {
        var classB: ClassB? = ClassB(otherValue: "test")
        var classA: ClassA? = ClassA(someValue: 7)
        classA?.classB = classB
        classB?.classA = classA
        
        classA = nil
        classB = nil
    }

}


class ClassA {
    // Example 3 - ClassA contains strong reference to property of type ClassB and ClassB has strong reference to property of type ClassA.
    // This creates a retain cycle. Note that deinit function is never called despite setting optional objects to nil in function above.
    let someValue: Int
    var classB: ClassB?
    
    init(someValue: Int) {
        self.someValue = someValue
        print("ClassA allocated")
    }
    
    deinit {
        print("ClassA deallocated")
    }
}

class ClassB {
    let otherValue: String
    /*unowned */var classA: ClassA? //Note: Commented out fix to the retention cycle problem.
    
    init(otherValue: String) {
        self.otherValue = otherValue
        print("ClassB allocated")
    }
    
    deinit {
        print("ClassB deallocated")
    }
}

