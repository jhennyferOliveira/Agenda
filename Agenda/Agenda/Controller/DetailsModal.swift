//
//  DetailsModal.swift
//  Agenda
//
//  Created by Jhennyfer Rodrigues de Oliveira on 20/10/20.
//

import UIKit

class DetailsModal: UIViewController {

    @IBOutlet weak var textFieldName: UITextField!
    @IBOutlet weak var saveButton: UIButton!
    @IBOutlet weak var textFieldEmail: UITextField!
    @IBOutlet weak var textFieldCellNumber: UITextField!
    
    override func viewDidLoad() {
        super.viewDidLoad()
        saveButton.addTarget(self, action: #selector(saveTapped), for: .touchUpInside)
    }
    
    @IBAction func saveTapped(){
        dismiss(animated: true, completion: nil)
    }

}
