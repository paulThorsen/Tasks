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
             HStack {
               ForEach(Colors.allCases, id: \.self) { color in
                   HStack {
                    Button(action: { self.taskModalViewModel.changeColor(color: color.rawValue) }) {
                         if self.taskModalViewModel.task.color == color.rawValue {
                                Rectangle()
                                .frame(width: COLOR_SELECTION_WIDTH, height: COLOR_SELECTION_WIDTH)
                                .cornerRadius(COLOR_SELECTION_CORNER_RADIUS)
                                    .foregroundColor(Color(String(color.rawValue)))
                                .overlay(Rectangle().stroke(Color(TASK_ICON_COLOR), lineWidth: COLOR_SELECTION_LINE_WIDTH)
                                    .cornerRadius(COLOR_SELECTION_CORNER_RADIUS)
                                    .clipShape(Rectangle())
                                    .opacity(TASK_ICON_OPACITY))
                            } else {
                                Rectangle()
                                    .cornerRadius(COLOR_SELECTION_CORNER_RADIUS)
                                    .frame(width: COLOR_SELECTION_WIDTH, height:     COLOR_SELECTION_WIDTH)
                            }
                        }
                    }
                    .foregroundColor(Color(String(color.rawValue)))
                }
            }
            
            Text("Hello, World!")
            Spacer()
        }
    }
}

struct ToDoTaskModalView_Previews: PreviewProvider {
    static var previews: some View {
        TaskModalView(taskModalViewModel: TaskModalViewModel(task: Task(title: "test title", color: "red_color")))
    }
}
