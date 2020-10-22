//
//  DetailsModal.swift
//  Agenda
//
//  Created by Jhennyfer Rodrigues de Oliveira on 20/10/20.
//

import UIKit
import CoreData

class DetailsModal: UIViewController {
    var person:Person?
    var action: Action = .edit
    var agenda: [Person]?
    let context = (UIApplication.shared.delegate as! AppDelegate).persistentContainer.viewContext
    @IBOutlet weak var textFieldName: UITextField!
    @IBOutlet weak var saveButton: UIButton!
    @IBOutlet weak var textFieldEmail: UITextField!
    @IBOutlet weak var textFieldCellNumber: UITextField!
    
    override func viewDidLoad() {
        super.viewDidLoad()
        saveButton.addTarget(self, action: #selector(saveTapped), for: .touchUpInside)
    }
    
    override func viewWillDisappear(_ animated: Bool) {
        super.viewWillDisappear(true)
        NotificationCenter.default.post(name: .dismissModal, object: nil)
    }
    
    @IBAction func saveTapped(){
        if action == .edit{
            edit()
        } else {
            add()
        }
        self.dismiss(animated: true, completion: nil)
    }
    
    func edit(){
        person?.name = textFieldName.text
        person?.email = textFieldEmail.text
        person?.number = Int64(textFieldCellNumber.text!) ?? 0
        do {
            try self.context.save()
        } catch{
            print(error.localizedDescription)
        }
    }
    
    func add(){
        agenda = try! context.fetch(Person.fetchRequest())
        let newPerson = Person(context: context.self)
        newPerson.name = textFieldName.text
        newPerson.email = textFieldEmail.text
        newPerson.number = Int64(textFieldCellNumber.text!) ?? 0
        newPerson.id = UUID()
        do {
            try self.context.save()
        } catch{
            print(error.localizedDescription)
        }
        
    }
    
}
