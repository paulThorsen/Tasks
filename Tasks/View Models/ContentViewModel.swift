//
//  ContentViewModel.swift
//  Tasks
//
//  Created by Paul Thorsen on 12/28/19.
//  Copyright © 2019 Paul Thorsen. All rights reserved.
//

import Foundation
import SwiftUI
import CoreData

public class ContentViewModel: ObservableObject {
    init() {
        self.createTaskColorSelection = ""
    }
    
    var createTaskColorSelection: String {
        didSet {
            objectWillChange.send()
            if self.createTaskColorSelection != "" {
                self.addTask(title: "", color: self.createTaskColorSelection)
            }
            self.createTaskColorSelection = ""
        }
    }
    
    func addTask(title: String, color: String) {
        Services.shared.addTask(title: title, color: color)
    }
    
    
    
}
