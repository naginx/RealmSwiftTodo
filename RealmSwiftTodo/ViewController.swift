//
//  ViewController.swift
//  RealmSwiftTodo
//
//  Created by nagisa miura on 2020/04/19.
//  Copyright © 2020 nagisa miura. All rights reserved.
//

import UIKit
import RealmSwift

class ViewController: UIViewController {
    
    var todoItems: Results<Todo>!
    @IBOutlet weak var table: UITableView!
    
    override func viewDidLoad() {
        super.viewDidLoad()
        table.dataSource = self
        
        let realm = try? Realm()
        todoItems = realm?.objects(Todo.self)
        table.reloadData()
    }
    
    override func viewWillAppear(_ animated: Bool) {
        super.viewWillAppear(animated)
        table.reloadData()
    }
}

extension ViewController: UITableViewDataSource {
    func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        return todoItems.count
    }

    func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        let cell: UITableViewCell = tableView.dequeueReusableCell(withIdentifier: "cell", for: indexPath)
        let object = todoItems[indexPath.row]
        cell.textLabel?.text = object.title
        return cell
    }

    func tableView(_ tableView: UITableView, commit editingStyle: UITableViewCell.EditingStyle, forRowAt indexPath: IndexPath) {
        if editingStyle == .delete {
            deleteTodo(at: indexPath.row)
            table.reloadData()
        }
    }

    func deleteTodo(at index: Int) {
        let realm = try! Realm()
        try! realm.write{
            realm.delete(todoItems[index])
        }
    }
}

