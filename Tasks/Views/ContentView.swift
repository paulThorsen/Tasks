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
    @State private var newTaskText = ""
    
    var body: some View {
        NavigationView {
            ScrollView{
                VStack {
                    HStack {
                        TextField("Add task...", text: self.$newTaskText)
                        Button(action: {
                            self.contentViewModel.addTask(title: self.newTaskText)
                            self.newTaskText = ""
                        }) {
                            Image(systemName: "plus")
                        }
                        .disabled(newTaskText.count == 0 ? true : false)
                    }
                    TaskListView(taskListViewModel: TaskListViewModel())
                    .navigationBarTitle("Tasks", displayMode: .inline)
                }
            }
        }
    }
}

struct ContentView_Previews: PreviewProvider {
    static var previews: some View {
        return ContentView(contentViewModel: ContentViewModel())
    }
}
