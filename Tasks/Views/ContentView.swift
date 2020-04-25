//
//  ContentView.swift
//  Tasks
//
//  Created by Paul Thorsen on 12/28/19.
//  Copyright © 2019 Paul Thorsen. All rights reserved.
//

import SwiftUI

struct ContentView: View {
    @ObservedObject var contentViewModel: ContentViewModel
    
    var body: some View {
        NavigationView {
            ZStack(alignment: .top) {
                ScrollView {
                    TaskListView(taskListViewModel: TaskListViewModel())
                        
                }
                .offset(y: COLOR_SELECTION_WIDTH + SECTION_WIDTH)
                VStack(spacing: LIST_SPACING) {
                    AddColorSquareBlock(selection: self.$contentViewModel.createTaskColorSelection)
                    Rectangle()
                        .frame(height: SECTION_WIDTH)
                        .foregroundColor(Color(DIVIDER_COLOR))
                    Spacer()
                }
            }
            .navigationBarTitle("Tasks", displayMode: .inline)
        }
        .onAppear(perform: {
            let center = UNUserNotificationCenter.current()
            center.requestAuthorization(options: [.badge])
               { (granted, error) in
               }
        })
    }
}

struct ContentView_Previews: PreviewProvider {
    static var previews: some View {
        let managedObjectContext = (UIApplication.shared.delegate as! AppDelegate).persistentContainer.viewContext
        for i in 1...4 {
            let newTask = TaskCD(context: managedObjectContext)
            newTask.dateCreated = Date()
            newTask.dateAddedToToDoList = Date()
            newTask.dateCompleted = Date()
            newTask.title = "test title"
            newTask.completed = i % 2 as NSNumber as! Bool
            newTask.color = "orange_color"
            newTask.id = UUID()
        }
        
        do {
            try managedObjectContext.save()
        } catch {
            print(error)
        }
        return ContentView(contentViewModel: ContentViewModel())
        .environment(\.managedObjectContext, managedObjectContext)
    }
}
