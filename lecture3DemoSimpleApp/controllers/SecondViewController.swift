//
//  SecondViewController.swift
//  lecture3DemoSimpleApp
//
//  Created by admin on 06.01.2021.
//

import UIKit

protocol SecondViewControllerDelegate {
    func removeItem(_ id: Int)
    func openEdit(_ id: Int)
    func addItem(_ title: String, _ subtitle: String, _ deadline: String)
    func editItem(_ id: Int, _ title: String, _ subtitle: String, _ deadline: String, _ status: Bool)
}

class SecondViewController: UIViewController {
    
    @IBOutlet weak var tableView: UITableView!
    var arr = [ToDoItem]()
    let cellId = "TableViewCell"
   
    override func viewWillAppear(_ animated: Bool) {
        super.viewWillAppear(animated)
        navigationController?.setNavigationBarHidden(false, animated: false)
        testDataConfigure()
    }
    
    
    override func viewDidLoad() {
        super.viewDidLoad()
        self.title = "Main page"
        self.configureTableView()
    }

    
    func testDataConfigure(){
        arr.append(ToDoItem(id: 1, title: "first", subtitle: "option", deadLine: "20.12.2021", status: false))
        arr.append(ToDoItem(id: 2, title: "second", subtitle: "option", deadLine: "22.12.2021", status: false))
        arr.append(ToDoItem(id: 3, title: "third", subtitle: "option", deadLine: "12.08.2021", status: false))
        arr.append(ToDoItem(id: 4, title: "uno", subtitle: "option", deadLine: "05.07.2021", status: true))
        arr.append(ToDoItem(id: 5, title: "dos", subtitle: "option", deadLine: "29.12.2021", status: false))
    }
    
    
    func configureTableView(){
        tableView.delegate = self
        tableView.dataSource = self
        tableView.register(UINib(nibName: cellId, bundle: nil), forCellReuseIdentifier: cellId)
        tableView.tableFooterView = UIView()
        
    }
    
    @IBAction func add(_ sender: UIBarButtonItem) {
        //change this method
        //Alert manager with two fields
        let vc = storyboard?.instantiateViewController(identifier: "AddViewController") as! AddViewController
        vc.delegate = self
        navigationController?.pushViewController(vc, animated: true)
        tableView.reloadData()
    }
    
}

extension SecondViewController: SecondViewControllerDelegate{
    func addItem(_ title: String, _ subtitle: String, _ deadline: String) {
        arr.append(ToDoItem(id: arr.count+1, title: title, subtitle: subtitle, deadLine: deadline, status: false))
        tableView.reloadData()
    }
    
    func removeItem(_ id: Int) {
        //remove item from array
        arr.removeAll(where: { $0.id == id })
        tableView.reloadData()
    }
    
    func openEdit(_ id: Int) {
        //open new view controller which allows you to change the data of the array item
        let vc = storyboard?.instantiateViewController(identifier: "EditViewController") as! EditViewController
        vc.delegate = self
        navigationController?.pushViewController(vc, animated: true)
        tableView.reloadData()
    }
    
    func editItem(_ id: Int, _ title: String, _ subtitle: String, _ deadline: String, _ status: Bool) {
        
        arr.first{ $0.id == id}?.title = title
        arr.first{ $0.id == id}?.subtitle = subtitle
        arr.first{ $0.id == id}?.deadLine = deadline
        arr.first{ $0.id == id}?.status = status
        

        tableView.reloadData()
    }
 
}

extension SecondViewController: UITableViewDelegate, UITableViewDataSource{

    func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        return arr.count
    }
    
    func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        let cell = tableView.dequeueReusableCell(withIdentifier: cellId, for: indexPath) as! TableViewCell
        let item = arr[indexPath.row]
//        cell.delegate = self
        cell.id = item.id ?? 0
        cell.titleLabel.text = item.title
        cell.subtitleLabel.text = item.subtitle
        cell.deadlineLabel.text = item.deadLine
        if item.status == true {
            cell.statusLabel.text = "Done"
        } else {cell.statusLabel.text = "In progress"}

        
//        cell.editCallback = { id in
//            self.editItem(id)
//        }
//
//        cell.removeCallback = { id in
//            self.removeItem(id)
//        }
        return cell
    }
    
//    func tableView(_ tableView: UITableView, canEditRowAt indexPath: IndexPath) -> Bool {
//        return true
//    }

//    func tableView(_ tableView: UITableView, commit editingStyle: UITableViewCell.EditingStyle, forRowAt indexPath: IndexPath) {
//
//        if (editingStyle == .delete) {
//            self.removeItem(arr[indexPath.row].id!)
//        }
//
//    }
    
    func tableView(_ tableView: UITableView, editingStyleForRowAt indexPath: IndexPath) -> UITableViewCell.EditingStyle {
        return .none
    }
    
    func tableView(_ tableView: UITableView,
                       trailingSwipeActionsConfigurationForRowAt indexPath: IndexPath) -> UISwipeActionsConfiguration? {
        let id = arr[indexPath.row].id!
        
        // Remove action
        let remove = UIContextualAction(style: .destructive,
                                       title: "Remove") { [weak self] (action, view, completionHandler) in
                                        self?.removeItem(id)
                                        completionHandler(true)
        }
        remove.backgroundColor = .systemRed
        
        // Edit action
        let edit = UIContextualAction(style: .normal,
                                         title: "Edit") { [weak self] (action, view, completionHandler) in
                                            self?.openEdit(id)
                                            completionHandler(true)
        }
        edit.backgroundColor = .systemBlue

        
        
        let configuration = UISwipeActionsConfiguration(actions: [remove, edit])

        return configuration
    }
    
    
}
