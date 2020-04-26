//
//  CoreDataDAO.swift
//  Tasks
//
//  Created by Paul Thorsen on 12/31/19.
//  Copyright © 2019 Paul Thorsen. All rights reserved.
//

import Foundation
import SwiftUI
import CoreData

public class CoreDataDAO: DAOProtocol {
    
    public func create(task: Task) {
        let managedObjectContext = (UIApplication.shared.delegate as! AppDelegate).persistentContainer.viewContext
        let newTask = NSEntityDescription.insertNewObject(forEntityName: "TaskCD", into: managedObjectContext ) as! TaskCD
        newTask.title = task.title
        newTask.completed = task.completed
        newTask.color = task.color
        newTask.id = task.id
        newTask.dateCreated = task.dateCreated
        newTask.dateCompleted = task.dateCompleted
        newTask.dateAddedToToDoList = task.dateAddedToToDoList
        
        do {
            try managedObjectContext.save()
        } catch {
            print(error)
        }
    }
    
    public func read() -> [Task] {
        let managedObjectContext = (UIApplication.shared.delegate as! AppDelegate).persistentContainer.viewContext
        let fetchRequest = NSFetchRequest<NSFetchRequestResult>(entityName: "TaskCD")
        let result = try? managedObjectContext.fetch(fetchRequest)
        let tasks = result as! [TaskCD]
        
        var taskArray:[Task] = []
        for task in tasks {
            taskArray.append(Task(task: task))
        }
        
        return taskArray
    }
    
    // reads the task as is stored Core Data w not modifications
    public func readOneTask(task: Task) -> Task {
        let managedObjectContext = (UIApplication.shared.delegate as! AppDelegate).persistentContainer.viewContext
        let fetchRequest = NSFetchRequest<NSFetchRequestResult>(entityName: "TaskCD")
        fetchRequest.predicate = NSPredicate(format: "id = %@", task.id!.uuidString)
        let result = try? managedObjectContext.fetch(fetchRequest)
        let tasks = result as! [TaskCD]

        return Task(task: tasks[0])
    }
    
    public func update(task: Task) {
        let managedObjectContext = (UIApplication.shared.delegate as! AppDelegate).persistentContainer.viewContext
        let fetchRequest = NSFetchRequest<NSFetchRequestResult>(entityName: "TaskCD")
        fetchRequest.predicate = NSPredicate(format: "id = %@", task.id!.uuidString)
        let result = try? managedObjectContext.fetch(fetchRequest)
        let tasks = result as! [TaskCD]
        
        tasks[0].title = task.title
        tasks[0].completed = task.completed
        tasks[0].color = task.color
        tasks[0].dateCreated = task.dateCreated
        tasks[0].dateCompleted = task.dateCompleted
        tasks[0].dateAddedToToDoList = task.dateAddedToToDoList
        
        do {
            try managedObjectContext.save()
        } catch {
            print(error)
        }
    }
    
    public func delete(task: Task) {
        let managedObjectContext = (UIApplication.shared.delegate as! AppDelegate).persistentContainer.viewContext
        let fetchRequest = NSFetchRequest<NSFetchRequestResult>(entityName: "TaskCD")
        fetchRequest.predicate = NSPredicate(format: "id = %@", task.id!.uuidString)
        let result = try? managedObjectContext.fetch(fetchRequest)
        let tasks = result as! [TaskCD]
        
        managedObjectContext.delete(tasks[0])
        
        do {
            try managedObjectContext.save()
        } catch {
            print(error)
        }
    }
}
