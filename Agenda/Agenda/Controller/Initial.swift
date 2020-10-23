//
//  ViewController.swift
//  Agenda
//
//  Created by Jhennyfer Rodrigues de Oliveira on 20/10/20.
//

import UIKit
import CoreData

//MARK:- Which action to perform when going to the next Controller
enum Action{
    case edit
    case add
}

class Initial: UITableViewController {
    
    @IBOutlet weak var addButton: UIBarButtonItem!
    var agenda: [Person]?
    //MARK:- Reference to context in app delegate
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
        let storyboard = UIStoryboard.init(name: "DetailsModal", bundle: nil)
        let secondVc = storyboard.instantiateViewController(withIdentifier: "DetailsModal") as! DetailsModal
        secondVc.action = .add
        present(secondVc, animated: true, completion: nil)
    }
    
    @objc func modalDismissed(notification: NSNotification){
        fetchData()
    }
    
    func fetchData() {
        do {
            let request = Person.fetchRequest() as NSFetchRequest<Person>
            self.agenda = try context.fetch(request)
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
        guard let agenda = agenda else{return}
        let selectedPerson = agenda[indexPath.row]
        let storyboard = UIStoryboard.init(name: "DetailsModal", bundle: nil)
        let secondVc = storyboard.instantiateViewController(withIdentifier: "DetailsModal") as! DetailsModal
        secondVc.action = .edit
        secondVc.person = selectedPerson
        present(secondVc, animated: true, completion: nil)
    }
    
    override func tableView(_ tableView: UITableView, trailingSwipeActionsConfigurationForRowAt indexPath: IndexPath) -> UISwipeActionsConfiguration? {
        
        let action = UIContextualAction(style: .destructive, title: "Delete") { (action, view, completionHandler) in
            
            guard let agenda = self.agenda else {return}
            let personToRemove = agenda[indexPath.row]
            self.context.delete(personToRemove)
            do {
                try  self.context.save()
            } catch {
                print(error.localizedDescription)
            }
            self.fetchData()
        }
        return UISwipeActionsConfiguration(actions: [action])
    }
}

extension Notification.Name {
     static let dismissModal = Notification.Name("dismissModal")

}

