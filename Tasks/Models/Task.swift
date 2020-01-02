//
//  Task.swift
//  Tasks
//
//  Created by Paul Thorsen on 12/31/19.
//  Copyright © 2019 Paul Thorsen. All rights reserved.
//
//  This class is a represents a normal Task object. 

import Foundation

public class Task: Identifiable {
    
    // Initializer that converts a Core Data Task to a normal task
    init(task: TaskCD) {
        self.dateCreated = task.dateCreated
        self.dateAddedToToDoList = task.dateAddedToToDoList
        self.dateCompleted = task.dateCompleted
        self.title = task.title
        self.completed = task.completed
        self.color = task.color
        self.id = task.id
    }
    
    init(title: String) {
        self.dateCreated = Date()
        self.dateAddedToToDoList = Date()
        self.dateCompleted = Date()
        self.title = title
        self.completed = false
        self.color = "orange_color"
        self.id = UUID()
    }
    
    public var dateCreated: Date?
    public var dateAddedToToDoList: Date?
    public var dateCompleted: Date?
    public var title: String?
    public var completed: Bool
    public var color: String?
    public var id: UUID?
}
