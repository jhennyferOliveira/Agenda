//
//  ViewController.swift
//  Agenda
//
//  Created by Jhennyfer Rodrigues de Oliveira on 20/10/20.
//

import UIKit
import CoreData
enum Action{
    case edit
    case add
}
class Initial: UITableViewController {
    
    @IBOutlet weak var addButton: UIBarButtonItem!
    var agenda: [Person]?
    let context = (UIApplication.shared.delegate as! AppDelegate).persistentContainer.viewContext
    
    override func loadView() {
        super.loadView()
        configAddButton()
    }

    override func viewDidLoad() {
        super.viewDidLoad()
        fetchData()
        tableView.delegate = self
        tableView.dataSource = self
        NotificationCenter.default.addObserver(self, selector: #selector(modalDismissed(notification:)), name: .dismissModal, object: nil)
    }
    
    func configAddButton(){
        addButton.target = self
        addButton.action = #selector(addTapped(_sender: ))
    }
        
    @IBAction func addTapped(_sender: UIBarButtonItem) {
        DetailsModal().action = .add
        let storyboard = UIStoryboard.init(name: "DetailsModal", bundle: nil)
        let secondVc = storyboard.instantiateViewController(withIdentifier: "DetailsModal") as! DetailsModal
        present(secondVc, animated: true, completion: nil)
    }
    
    @objc func modalDismissed(notification: NSNotification){
        fetchData()
    }
    
    func fetchData(){
        do {
            self.agenda = try context.fetch(Person.fetchRequest())
            DispatchQueue.main.async {
                self.tableView.reloadData()
            }
        } catch {
            print(error.localizedDescription)
        }

    }

    override func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        self.agenda?.count ?? 0
    }

    override func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        let cell = tableView.dequeueReusableCell(withIdentifier: "Person", for: indexPath)
        let person = self.agenda![indexPath.row]
        cell.textLabel?.text = person.name
        return cell
    }
    
    override func numberOfSections(in tableView: UITableView) -> Int {
        return 1
    }
    
    override func tableView(_ tableView: UITableView, didSelectRowAt indexPath: IndexPath) {
        DetailsModal().action = .edit
        DetailsModal().person = agenda![indexPath.row]
        let storyboard = UIStoryboard.init(name: "DetailsModal", bundle: nil)
        let secondVc = storyboard.instantiateViewController(withIdentifier: "DetailsModal") as! DetailsModal
        present(secondVc, animated: true, completion: nil)
    }
    
    override func tableView(_ tableView: UITableView, trailingSwipeActionsConfigurationForRowAt indexPath: IndexPath) -> UISwipeActionsConfiguration? {
        let action = UIContextualAction(style: .destructive, title: "Delete") { (action, view, completionHandler) in
            // get the person to remove
            let personToRemove = self.agenda![indexPath.row]
            // remove the person
            self.context.delete(personToRemove)
            // save the data
            do {
                try  self.context.save()
            } catch {
                print(error.localizedDescription)
            }
            // re-fetch
            self.fetchData()
        }
        return UISwipeActionsConfiguration(actions: [action])
    }

}

extension Notification.Name {
     static let dismissModal = Notification.Name("dismissModal")

}

