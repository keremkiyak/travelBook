//
//  ListViewController.swift
//  travelBook
//
//  Created by kerem on 20.02.2023.
//

import UIKit
import CoreData

class ListViewController: UIViewController,UITableViewDataSource, UITableViewDelegate {
    
    @IBOutlet weak var tableView: UITableView!
    var titleArray = [String]()
    var idArray = [UUID]()
    override func viewDidLoad() {
        super.viewDidLoad()
        navigationController?.navigationBar.topItem?.rightBarButtonItem =
        UIBarButtonItem(barButtonSystemItem:UIBarButtonItem.SystemItem.add,target:self,action:#selector(addButtonClicked))
        tableView.delegate = self
        tableView.dataSource = self
        getData()
    }
    
    func getData(){
        let appDelegate = UIApplication.shared.delegate as! AppDelegate
        let context = appDelegate.persistentContainer.viewContext
        
        
        let request = NSFetchRequest<NSFetchRequestResult>(entityName: "Places")
        request.returnsObjectsAsFaults = false
       
        
        do{
            let results =  try context.fetch(request)
            if results.count > 0{
                
                self.idArray.removeAll(keepingCapacity: false)
                self.titleArray.removeAll(keepingCapacity: false)
                //for look a başlamadan önce bütün bu verileri temizlememiz gerekiyordu ki duplike şeyler olmasın diye üsteki iki satır bunun için.
                for result in results as![NSManagedObject]{
                    if let title = result.value(forKey: "title") as? String {
                        self.titleArray.append(title)
                    }
                    if let id = result.value(forKey:"id") as? UUID{
                        self.idArray.append(id)
                    }
                    tableView.reloadData()
                }
            }
        }
        catch{
            print("error")
        }
    }
    @objc func addButtonClicked(){
        performSegue(withIdentifier: "toViewController", sender: nil)
    }
    func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        return titleArray.count
    }
    func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        let cell = UITableViewCell()
        cell.textLabel?.text = titleArray[indexPath.row]
        return cell
    }
    
}
