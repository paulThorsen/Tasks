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
        context = (UIApplication.shared.delegate as! AppDelegate).persistentContainer.viewContext
    }
    
    let context: NSManagedObjectContext
    func addTask(title: String) {
        Services.shared.addTask(title: title)
    }
    
}
