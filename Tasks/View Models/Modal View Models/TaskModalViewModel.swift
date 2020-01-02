//
//  ToDoTaskModalViewModel.swift
//  Tasks
//
//  Created by Paul Thorsen on 12/31/19.
//  Copyright © 2019 Paul Thorsen. All rights reserved.
//

import Foundation

public class TaskModalViewModel: ObservableObject {
    init(task: Task) {
        self.task = task
        if !self.task.completed {
            self.displayColor = self.task.color!
            self.titleDisplayColor = TASK_TITLE_NOT_COMPLETED_COLOR
        }
        else {
            self.titleDisplayColor = TASK_TITLE_COMPLETED_COLOR
            self.displayColor = COMPLETED_TASK_BG_COLOR
        }
    }
    
    var task: Task
    var displayColor: String
    var titleDisplayColor: String
    
}
