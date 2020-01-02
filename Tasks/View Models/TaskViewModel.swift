//
//  TaskViewModel.swift
//  Tasks
//
//  Created by Paul Thorsen on 12/28/19.
//  Copyright © 2019 Paul Thorsen. All rights reserved.
//

import Foundation
import SwiftUI
import Combine

public class TaskViewModel: ObservableObject {
//    let didChange = PassthroughSubject<TaskViewModel, Never>()
    
    init(task: Task) {
        self.task = task
        
        // if completed
        if task.completed {
            self.titleDisplayColor = TASK_TITLE_COMPLETED_COLOR
            self.statusImage = COMPLETED_STATUS_ICON
            self.displayColor = COMPLETED_TASK_BG_COLOR
            self.displayBorderColor = DIVIDER_COLOR
        }
        // if not completed
        else {
            self.titleDisplayColor = TASK_TITLE_NOT_COMPLETED_COLOR
            self.statusImage = NOT_COMPLETED_STATUS_ICON
            self.displayColor = task.color!
            self.displayBorderColor = BLACK_DIVIDER_COLOR
        }
    }
    
    let screenSize = UIScreen.main.bounds
    
    var displayColor: String
    var displayBorderColor: String
    var titleDisplayColor: String
    var statusImage: String
    var task: Task
    
    func toggleTaskCompletion() {
        // if adding back to To-Do list, new date for dateAddedToToDoList
        if self.task.completed {
            self.task.dateAddedToToDoList = Date()
        }
        self.task.completed.toggle()
        self.task.dateCompleted = Date()
        
        Services.shared.updateTask(task: task)
    }
    
    func deleteTask() {
        Services.shared.deleteTask(task: task)
    }
    
}
