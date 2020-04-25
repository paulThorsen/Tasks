//
//  Services.swift
//  Tasks
//
//  Created by Paul Thorsen on 12/31/19.
//  Copyright © 2019 Paul Thorsen. All rights reserved.
//

import Foundation
import SwiftUI

public class Services {
    
    private init() {
        self.dao = CoreDataDAO()
    }
    
    let dao: DAOProtocol
    static let shared = Services()
    
    func addTask(title: String, color: String) {
        let task = Task(title: title, color: color)
        dao.create(task: task)
        UIApplication.shared.applicationIconBadgeNumber += 1
    }
    
    func updateTask(task: Task) {
        dao.update(task: task)
    }
    
    func deleteTask(task: Task) {
        dao.delete(task: task)
        if (!task.completed) {
            UIApplication.shared.applicationIconBadgeNumber -= 1
        }
    }

    func readTasks() -> [Task]{
        return dao.read()
    }
}
