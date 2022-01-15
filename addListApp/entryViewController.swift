//
//  entryViewController.swift
//  addListApp
//
//  Created by KhanhVuIT on 13/01/2022.
//

import UIKit

class entryViewController: UIViewController, UITextFieldDelegate {
    var update: (() -> Void)?
    @IBOutlet weak var enterTextField: UITextField!
    
    override func viewDidLoad() {
        super.viewDidLoad()
        
        enterTextField.delegate=self
        
        navigationItem.rightBarButtonItem = UIBarButtonItem(title: "Save", style: .done, target: self, action: #selector(saveTask))
        
    }
    
    

    func textFieldShouldReturn(_ textField: UITextField) -> Bool {
        saveTask()
        print("aloo")
        return true
    }
    
    @objc func saveTask() {
        guard let text = enterTextField.text, !text.isEmpty else {
            return
        }
        
        guard let count = UserDefaults().value(forKey:"count") as? Int else {
            return
        }
        
        let newCount = count + 1
        
        UserDefaults().set(newCount, forKey: "count")
        UserDefaults().set(text, forKey: "Task_\(newCount)")
        print("111")
        
        update?()
        navigationController?.popViewController(animated: true)
        
        
    }
    

}
