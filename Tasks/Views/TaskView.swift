//
//  TaskView.swift
//  Tasks
//
//  Created by Paul Thorsen on 12/28/19.
//  Copyright © 2019 Paul Thorsen. All rights reserved.
//

import SwiftUI

struct TaskView: View {
    @ObservedObject var taskViewModel: TaskViewModel
    @State var isPresented = false
    @State var beingDeleted = false
    @State var actionFGColor = "delete_color"
    @State var dragOffset = CGSize.zero
    @State var animate = false
    @State var giveHapticFeedback = true
    @State var aboveTrigger = true
    @State var deleteAction = true
    @State var deleteActive = false
    @State var markActive = false
    
    let screenSize = UIScreen.main.bounds
    let lightGenerator = UIImpactFeedbackGenerator(style: .light)
    
    var body: some View {
        ZStack {
//            Rectangle()
//                .frame(width: self.screenSize.width, height: CELL_HEIGHT)
//                .foregroundColor(Color(ACTION_ICON_COLOR))
            ZStack {
                Rectangle()
                    .frame(width: self.screenSize.width, height: CELL_HEIGHT)
                    .foregroundColor(Color(DELETE_COLOR))
                    .offset(x: deleteActive ? 0 : screenSize.width)
                    .animation(.interactiveSpring())
                // Delete action icon
                HStack {
                    Image(DELETE_ICON)
                        .renderingMode(.template)
                        .foregroundColor(self.deleteActive ? Color(ACTION_ICON_COLOR) : Color(DELETE_COLOR))
                        .padding()
                        .animation(.interactiveSpring())
                    Spacer()
                }
                .offset(x: dragOffset.width < TASK_DELETE_TRIGGER || dragOffset.width > -(DELETE_ICON_OFFSET) ? dragOffset.width + screenSize.width + EXTRA_ACTION_OFFSET : screenSize.width - DELETE_ICON_OFFSET)
            }
            ZStack {
                Rectangle()
                    .frame(width: self.screenSize.width, height: CELL_HEIGHT)
                    .foregroundColor(Color(MARK_COLOR))
                    .offset(x: markActive ? 0 : 0 - screenSize.width)
                    .animation(.interactiveSpring())
                // Mark action icon
                HStack {
                    Image(MARK_ICON)
                        .renderingMode(.template)
                        .foregroundColor(markActive ? Color(ACTION_ICON_COLOR) : Color(MARK_COLOR))
                        .padding()
                        .animation(.interactiveSpring())
                    Spacer()
                }
                .offset(x: dragOffset.width > TASK_MARK_TRIGGER || dragOffset.width < MARK_ICON_OFFSET + EXTRA_ACTION_OFFSET ? dragOffset.width - MARK_ICON_OFFSET : 0 + EXTRA_ACTION_OFFSET)
            }
            ZStack {
                Rectangle()
                    .frame(height: CELL_HEIGHT)
                    .foregroundColor(Color(self.taskViewModel.displayColor))
                VStack {
                    Spacer()
                    Rectangle()
                        .frame(height: DIVIDER_WIDTH)
                        .foregroundColor(Color(self.taskViewModel.displayBorderColor))
                        .opacity(TASK_DIVIDER_OPACITY)
                        .blendMode(.luminosity)
                }
                .frame(height: CELL_HEIGHT)
                HStack {
                    Button (action: {
                        self.lightGenerator.impactOccurred()
                        self.taskViewModel.toggleTaskCompletion()
                    }) {
                        if self.taskViewModel.task.completed {
                            Image(self.taskViewModel.statusImage)
                                .renderingMode(.template)
                                .foregroundColor(.green)
                        }
                        else {
                            Image(self.taskViewModel.statusImage)
                                .renderingMode(.template)
                                .foregroundColor(Color(ICON_BLACK_COLOR))
                                .opacity(TASK_ICON_OPACITY)
                                .blendMode(.luminosity)
                        }
                    }
                    Spacer()
                        .frame(width: ICON_SPACER_TITLE)
                    Text(self.taskViewModel.task.title!)
                        .foregroundColor(Color(self.taskViewModel.titleDisplayColor))
                    Spacer()
                    Button (action: {
                        self.isPresented = true
                    }) {
                        if self.taskViewModel.task.completed {
                            Image(SHOW_MORE_ICON)
                                .renderingMode(.template)
                                .foregroundColor(Color(TASK_ICON_COLOR))
                                .opacity(TASK_ICON_OPACITY)
                                .blendMode(.luminosity)
                        }
                        else {
                            Image(SHOW_MORE_ICON)
                                .foregroundColor(.black)
                                .opacity(TASK_ICON_OPACITY)
                                .blendMode(.luminosity)
                        }
                    }
                }
                .padding()
            }
            .animation(self.animate ? .interactiveSpring() : .none)
            .offset(x: self.dragOffset.width)
            
            // Delete and Mark gestures
            .simultaneousGesture(DragGesture()
                .onChanged {
                    value in
                    self.deleteAction = value.translation.width < 0
//                    print(value.translation.width)
                    self.dragOffset = value.translation
                    self.animate = false
                    if value.translation.width < TASK_DELETE_TRIGGER && self.giveHapticFeedback && self.deleteAction {
                        self.lightGenerator.impactOccurred()
                        self.giveHapticFeedback = false
                        self.deleteActive = true
                    }
                    else if value.translation.width > TASK_DELETE_TRIGGER && !self.giveHapticFeedback && self.deleteAction {
                        self.lightGenerator.impactOccurred()
                        self.giveHapticFeedback = true
                        self.deleteActive = false
                    }
                    else if value.translation.width > TASK_MARK_TRIGGER && self.giveHapticFeedback && !self.deleteAction {
                        self.lightGenerator.impactOccurred()
                        self.giveHapticFeedback = false
                        self.markActive = true
                    }
                    else if value.translation.width < TASK_MARK_TRIGGER && !self.giveHapticFeedback && !self.deleteAction {
                        self.lightGenerator.impactOccurred()
                        self.giveHapticFeedback = true
                        self.markActive = false
                    }
                }
                .onEnded {
                    value in
                    self.animate = true
                    self.giveHapticFeedback = true
//                    self.cancelSticks = false
                    if value.translation.width < TASK_DELETE_TRIGGER && self.deleteAction {
                        self.dragOffset.width = -(self.screenSize.width)
                        DispatchQueue.main.asyncAfter(deadline: .now() + 0.2) {
                            self.taskViewModel.deleteTask()
                        }
                    }
                    else if value.translation.width > TASK_MARK_TRIGGER && !self.deleteAction {
                        self.dragOffset = .zero
                        DispatchQueue.main.asyncAfter(deadline: .now() + 0.1) {
                            self.taskViewModel.toggleTaskCompletion()
                        }
                    }
                    else {
                        self.dragOffset = .zero
                    }
                }
            )
        }
        
        .sheet(isPresented: $isPresented) {
            TaskModalView(taskModalViewModel: TaskModalViewModel(task: self.taskViewModel.task))
        }
    }
}

struct TaskView_Previews: PreviewProvider {
    static var previews: some View {
        let task = Task(title: "test title")

        return TaskView(taskViewModel: TaskViewModel(task: task))
            .environment(\.colorScheme, .dark)
    }
}
