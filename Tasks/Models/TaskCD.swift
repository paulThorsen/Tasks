//
//  TaskCD.swift
//  Tasks
//
//  Created by Paul Thorsen on 12/28/19.
//  Copyright © 2019 Paul Thorsen. All rights reserved.
//
//  This class represents a Task object that can be used with Core Data.

import Foundation
import CoreData

public class TaskCD: NSManagedObject, Identifiable {
    @NSManaged public var dateCreated: Date?
    @NSManaged public var dateAddedToToDoList: Date?
    @NSManaged public var dateCompleted: Date?
    @NSManaged public var title: String?
    @NSManaged public var completed: Bool
    @NSManaged public var color: String?
    @NSManaged public var id: UUID?
}

extension TaskCD {
    static func getAllTasks() -> NSFetchRequest<TaskCD> {
        let request: NSFetchRequest<TaskCD> = TaskCD.fetchRequest() as! NSFetchRequest<TaskCD>
        
        let sortDescriptor = NSSortDescriptor(key: "dateCreated", ascending: true)
        request.sortDescriptors = [sortDescriptor]
        
        return request
    }
}
