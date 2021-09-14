//
//  ListViewController.swift
//  CodingMentor
//
//  Created by Mac on 9/13/21.
//  Copyright © 2021 Mac. All rights reserved.
//

import UIKit


var tasks = [String]()
class ListViewController: UIViewController, UITextFieldDelegate  {
    
    

    @IBOutlet weak var tableView: UITableView!
//
    @IBOutlet weak var field: UITextField!
    
    @IBOutlet weak var addButton: UIButton!
    
    
    
    var update: (() -> Void)?
    
    override func viewDidLoad() {
        super.viewDidLoad()
        self.title = "Study List"
        field.delegate = self
        tableView.delegate = self
        tableView.dataSource = self
        
        if !UserDefaults().bool(forKey: "setup") {
            UserDefaults().set(true, forKey: "setup")
            UserDefaults().set(0, forKey: "count")
        }
        
        //Get all current saved tasks
        updateTasks()
    }
    
//    func textFieldShouldReturn(_ textField: UITextField) -> Bool {
//        addTask()
//        return true
//    }
    
    @IBAction func addTask(_: Any) {
        guard let text = field.text, !text.isEmpty else {
            return
        }
        guard let count = UserDefaults().value(forKey: "count") as? Int else {
            return
        }
        
        let newCount = count+1
        UserDefaults().set(newCount, forKey: "count")
        UserDefaults().set(text, forKey: "task_\(newCount)")
        updateTasks()
    }
    
    func updateTasks() {
        
        tasks.removeAll()
        
        guard let count = UserDefaults().value(forKey: "count") as? Int else {
            return
        }
        
        for x in 0..<count {
            if let task = UserDefaults().value(forKey: "task_\(x+1)") as? String {
                tasks.append(task)
            }
        }
        
        tasks = Array(tasks.reversed())
        
        tableView.reloadData()
    }
    
    /*
    // MARK: - Navigation
    // In a storyboard-based application, you will often want to do a little preparation before navigation
    override func prepare(for segue: UIStoryboardSegue, sender: Any?) {
        // Get the new view controller using segue.destination.
        // Pass the selected object to the new view controller.
    }
    */
    
}
extension ListViewController: UITableViewDelegate {
    func tableView(_ tableView: UITableView, didSelectRowAt indexPath: IndexPath) {
        tableView.deselectRow(at: indexPath, animated: true)
    }
}

extension ListViewController: UITableViewDataSource {
    func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        return tasks.count
    }
    func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        let cell = tableView.dequeueReusableCell(withIdentifier: "cell", for: indexPath)
        cell.textLabel?.text = tasks[indexPath.row]
        return cell
    }
}
