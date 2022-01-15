//
//  ViewController.swift
//  addListApp
//
//  Created by KhanhVuIT on 13/01/2022.
//

import UIKit

class ViewController: UIViewController{
    

    @IBOutlet weak var myTableView: UITableView!
    
    var tasks = [String]()
    
    override func viewDidLoad() {
        super.viewDidLoad()
        
        myTableView.delegate=self
        myTableView.dataSource=self
        self.title = "Tasks"
        if !UserDefaults().bool(forKey: "setup") {
            UserDefaults().set(true, forKey: "setup")
            UserDefaults().set("0", forKey: "count")
            
        }
        // Do any additional setup after loading the view.
        updateTasks()
    }
    
    func updateTasks() {
        tasks.removeAll()
        guard let count = UserDefaults().value(forKey: "count") as? Int else {
            return
        }
        
        for x in 0..<count {
            if let task = UserDefaults().value(forKey: "Task_\(x+1)") as? String {
                tasks.append(task)
            }
        }
        myTableView.reloadData()
        
    }
    
    
    
    @IBAction func didTapAdd(_ sender: Any) {
        let vc = storyboard?.instantiateViewController(withIdentifier: "entry") as! entryViewController
        vc.title = "New Task"
        vc.update = {
            DispatchQueue.main.async {
                self.updateTasks()
            }
        }
        navigationController?.pushViewController(vc, animated: true)
    }
}

extension ViewController: UITableViewDelegate {
            func tableView(_ tableView: UITableView, didSelectRowAt indexPath: IndexPath) {
                tableView.deselectRow(at: indexPath, animated: true)
            }
}
extension ViewController: UITableViewDataSource {
            func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
                return tasks.count
            }
            func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
                let cell = tableView.dequeueReusableCell(withIdentifier: "cell", for: indexPath)
                
                cell.textLabel?.text = tasks[indexPath.row]
                
                return cell
            }
            
}
        
