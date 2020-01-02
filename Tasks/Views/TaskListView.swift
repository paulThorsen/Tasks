//
//  TaskListView.swift
//  Tasks
//
//  Created by Paul Thorsen on 12/28/19.
//  Copyright © 2019 Paul Thorsen. All rights reserved.
//

import SwiftUI

struct TaskListView: View {
    @ObservedObject var taskListViewModel: TaskListViewModel
    @FetchRequest(fetchRequest: TaskCD.getAllTasks()) var tasks: FetchedResults<TaskCD>
    
    var body: some View {
        VStack(spacing: LIST_SPACING) {
            Rectangle()
                .frame(height: DIVIDER_WIDTH)
                .foregroundColor(Color(DIVIDER_COLOR))
                .opacity(TASK_DIVIDER_OPACITY)
                .blendMode(.luminosity)
            ForEach(self.tasks.filter { !$0.completed } .sorted { $0.dateAddedToToDoList ?? Date() > $1.dateAddedToToDoList ?? Date() }) { taskCD in
                TaskView(taskViewModel: TaskViewModel(task: Task(task: taskCD)))
                Rectangle()
                .frame(height: DIVIDER_WIDTH)
                .foregroundColor(Color(DIVIDER_COLOR))
                .opacity(TASK_DIVIDER_OPACITY)
                .blendMode(.luminosity)
                
            }
            ForEach(self.tasks.filter{$0.completed} .sorted { $0.dateAddedToToDoList ?? Date() > $1.dateAddedToToDoList ?? Date() }) { taskCD in
                TaskView(taskViewModel: TaskViewModel(task: Task(task: taskCD)))
                Rectangle()
                .frame(height: DIVIDER_WIDTH)
                .foregroundColor(Color(DIVIDER_COLOR))
                .opacity(TASK_DIVIDER_OPACITY)
                .blendMode(.luminosity)
            }
            Spacer()
        }
    }
}

struct TaskListView_Previews: PreviewProvider {
    static var previews: some View {
        let managedObjectContext = (UIApplication.shared.delegate as! AppDelegate).persistentContainer.viewContext
        for _ in 1...4 {
            let newTask = TaskCD(context: managedObjectContext)
            newTask.dateCreated = Date()
            newTask.dateAddedToToDoList = Date()
            newTask.dateCompleted = Date()
            newTask.title = "test title"
            newTask.completed = false
            newTask.color = "orange_color"
            newTask.id = UUID()
        }
        
        do {
            try managedObjectContext.save()
        } catch {
            print(error)
        }
        return TaskListView(taskListViewModel: TaskListViewModel())
        .environment(\.managedObjectContext, managedObjectContext)
//            .environment(\.colorScheme, .dark)
    }
}
