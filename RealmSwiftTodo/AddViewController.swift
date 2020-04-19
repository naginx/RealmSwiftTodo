//
//  addViewController.swift
//  RealmSwiftTodo
//
//  Created by nagisa miura on 2020/04/19.
//  Copyright © 2020 nagisa miura. All rights reserved.
//

import UIKit
import RealmSwift

class AddViewController: UIViewController {
    
    @IBOutlet weak var textBox: UITextField!
    
    override func viewDidLoad() {
        super.viewDidLoad()
        textBox.delegate = self
    }
    
    @IBAction func addTask(_ sender: Any) {
        let realm = try! Realm()
        let todo = Todo()
        todo.title = textBox.text!
        try! realm.write {
            realm.add(todo)
        }
        self.navigationController?.popViewController(animated: true)
    }
}

extension AddViewController: UITextFieldDelegate {
    func textFieldShouldReturn(_ textField: UITextField) -> Bool {
        self.textBox.resignFirstResponder()
        return true
    }
}
