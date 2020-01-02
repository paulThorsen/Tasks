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
    
    func addTask(title: String) {
        let task = Task(title: title)
        dao.create(task: task)
    }
    
    func updateTask(task: Task) {
        dao.update(task: task)
    }
    
    func deleteTask(task: Task) {
        dao.delete(task: task)
    }
}
