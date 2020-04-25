//
//  DAOInterface.swift
//  Tasks
//
//  Created by Paul Thorsen on 12/31/19.
//  Copyright © 2019 Paul Thorsen. All rights reserved.
//

import Foundation

public protocol DAOProtocol {
    func create(task: Task)
    func read() -> [Task]
    func update(task: Task)
    func delete(task: Task)
}
