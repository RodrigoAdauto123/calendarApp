//
//  NewTask.swift
//  CalendarApp
//
//  Created by Rodrigo Adauto Ortiz on 21/05/24.
//

import SwiftUI
import SwiftData

enum TypeTask {
    case CREATE
    case EDIT
}

struct NewTask: View {
    
    @Environment(\.dismiss) private var dismiss
    @Environment(\.modelContext) private var context
    
    var dateTask: Date
    var selectedTask: Task?
    let typeTask: TypeTask
    @State private var titleTask: String = .empty
    @State private var descriptionTask: String = .empty
    @State private var timeTask = Date()
    
    init(dateTask: Date, selectedTask: Task? = nil, typeTask: TypeTask) {
        self.dateTask = dateTask
        self.selectedTask = selectedTask
        self.typeTask = typeTask
        self._titleTask = State(initialValue: selectedTask?.title ?? .empty)
        self._descriptionTask = State(initialValue: selectedTask?.descriptionTask ?? .empty)
        self._timeTask = State(initialValue: selectedTask?.time ?? Date())
    }
    
    var body: some View {
        VStack {
            Form {
                Section {
                    TextField("Title",
                              text: $titleTask)
                    .keyboardType(.default)
                    TextField("Description",
                              text: $descriptionTask)
                    .keyboardType(.default)
                    HStack {
                        Image(systemName: "clock")
                            .foregroundStyle(Color.gray)
                        DatePicker("Time",
                                   selection: $timeTask,
                                   displayedComponents: .hourAndMinute)
                    }
                } header: {
                    if typeTask == .CREATE {
                        Text("Create a new task")
                    } else {
                        Text("Edit task")
                    }
                }
                
                Section {
                    Button(action: {
                        let newTask = Task(title: titleTask, descriptionTask: descriptionTask, date: dateTask, time: timeTask)
                        if typeTask == .EDIT {
                            self.selectedTask?.title = newTask.title
                            self.selectedTask?.descriptionTask = newTask.descriptionTask
                            self.selectedTask?.date = newTask.date
                            self.selectedTask?.time = newTask.time
                            TaskDataManager.updateTask(task: newTask, modelContext: context)
                        } else {
                            TaskDataManager.saveNewTask(task: newTask, modelContext: context)
                        }
                        dismiss()
                    }) {
                        
                        if typeTask == .CREATE {
                            Text("Create")
                                .frame(maxWidth: .infinity)
                                .foregroundStyle(Color.blue)
                        } else {
                            Text("Save")
                                .frame(maxWidth: .infinity)
                                .foregroundStyle(Color.blue)
                        }
                    }
                }
            }
        }
    }
}
