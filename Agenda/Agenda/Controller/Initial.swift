//
//  ViewController.swift
//  Agenda
//
//  Created by Jhennyfer Rodrigues de Oliveira on 20/10/20.
//

import UIKit

class Initial: UITableViewController {
    @IBOutlet weak var addButton: UIBarButtonItem!
    
    override func viewDidLoad() {
        super.viewDidLoad()
        tableView.delegate = self
        tableView.dataSource = self
        addButton.target = self
        addButton.action = #selector(addTapped(_sender: ))

    }
    
    @IBAction func addTapped(_sender: UIBarButtonItem){
        let storyboard = UIStoryboard.init(name: "DetailsModal", bundle: nil)
        let secondVc = storyboard.instantiateViewController(withIdentifier: "DetailsModal") as! DetailsModal
        present(secondVc, animated: true, completion: nil)
    }
    
}

extension Initial {
    override func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        return 10
    }

    override func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        let cell = tableView.dequeueReusableCell(withIdentifier: "Person", for: indexPath)
        cell.textLabel?.text = "bla"
        return cell
    }
    
    override func numberOfSections(in tableView: UITableView) -> Int {
        return 1
    }
    
    override func tableView(_ tableView: UITableView, didSelectRowAt indexPath: IndexPath) {
        let storyboard = UIStoryboard.init(name: "DetailsModal", bundle: nil)
        let secondVc = storyboard.instantiateViewController(withIdentifier: "DetailsModal") as! DetailsModal
        present(secondVc, animated: true, completion: nil)
    }
    
    override func tableView(_ tableView: UITableView, trailingSwipeActionsConfigurationForRowAt indexPath: IndexPath) -> UISwipeActionsConfiguration? {
        let action = UIContextualAction(style: .destructive, title: "Delete") { (action, view, completionHandler) in
//            // get the person to remove
//            let personToRemove = self.items![indexPath.row]
//            // remove the person
//            self.context.delete(personToRemove)
//            // save the data
//            do {
//                try  self.context.save()
//            } catch {
//                print(error.localizedDescription)
//            }
//            // re-fetch
//            self.fetchPeople()
        }
        return UISwipeActionsConfiguration(actions: [action])
    }

}

