//
//  ToDoTaskModalView.swift
//  Tasks
//
//  Created by Paul Thorsen on 12/30/19.
//  Copyright © 2019 Paul Thorsen. All rights reserved.
//

import SwiftUI

struct TaskModalView: View {
    @ObservedObject var taskModalViewModel: TaskModalViewModel
    
    var body: some View {
        VStack {
            ColorSquareBlock(taskColor: .constant(taskModalViewModel.task.color!))
            Text("Hello, World!")
        }
    }
}

struct ToDoTaskModalView_Previews: PreviewProvider {
    static var previews: some View {
        TaskModalView(taskModalViewModel: TaskModalViewModel(task: Task(title: "test title")))
    }
}
