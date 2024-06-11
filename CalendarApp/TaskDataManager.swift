//
//  TaskDataManager.swift
//  NoteCal
//
//  Created by Rodrigo Adauto Ortiz on 5/06/24.
//

import Foundation
import SwiftData
import CloudKit

class TaskDataManager {
    
    static func saveNewTask(task: Task, modelContext: ModelContext) {
        modelContext.insert(task)
    }
    
    static func updateTask(task: Task, modelContext: ModelContext) {
        guard let _ = try? modelContext.save() else { return }
    }
    
    static func deleteTask(task: Task, modelContext: ModelContext) {
        modelContext.delete(task)
    }
    
}
