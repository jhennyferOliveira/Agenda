//
//  Person+CoreDataProperties.swift
//  Agenda
//
//  Created by Jhennyfer Rodrigues de Oliveira on 22/10/20.
//
//

import Foundation
import CoreData


extension Person {

    @nonobjc public class func fetchRequest() -> NSFetchRequest<Person> {
        return NSFetchRequest<Person>(entityName: "Person")
    }

    @NSManaged public var email: String?
    @NSManaged public var name: String?
    @NSManaged public var number: Int64
    @NSManaged public var id: UUID?

}

extension Person : Identifiable {

}
