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
    
    init(task: Task) {
        self.task = task
        self.newTitle = task.title!
        
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
            self.displayColor = NOT_COMPLETED_TASK_BG_COLOR
            self.displayBorderColor = BLACK_DIVIDER_COLOR
        }
    }
    
    let screenSize = UIScreen.main.bounds
    
    var displayColor: String
    var displayBorderColor: String
    var titleDisplayColor: String
    var statusImage: String
    var newTitle: String {
        didSet {
            objectWillChange.send()
            self.task.title = self.newTitle
            updateTask()
        }
    }
    
    var task: Task
    
    func updateTask() {
        Services.shared.updateTask(task: self.task)
    }
    
    func toggleTaskCompletion() {
        self.task.completed.toggle()
        self.task.dateCompleted = Date()
        
        Services.shared.updateTask(task: self.task)
    }
    
    func deleteTask() {
        Services.shared.deleteTask(task: self.task)
        print("deleted")
    }
    
//    func deleteTaskUndoActionRegister(){
//      self.undoManager?.registerUndo(withTarget: self, handler: { (selfTarget) in
//        selfTarget.deleteTask()
//
//      })
//    }
}
