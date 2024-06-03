//
//  NewTask.swift
//  CalendarApp
//
//  Created by Rodrigo Adauto Ortiz on 21/05/24.
//

import SwiftUI

enum TypeTask {
    case CREATE
    case EDIT
}

struct NewTask: View {
    
    @Environment(\.dismiss) private var dismiss
    @Binding var task: [Task]
    var dateTask: Date
    var selectedTask: Task?
    let typeTask: TypeTask
    @State private var titleTask = ""
    @State private var descriptionTask = ""
    @State private var timeTask = Date()
    @State private var alarmTask = Date()
    
    init(task: Binding<[Task]>, dateTask: Date, selectedTask: Task? = nil) {
        self._task = task
        self.dateTask = dateTask
        self.selectedTask = selectedTask
        if let selectedTask {
            typeTask = .EDIT
        } else {
            typeTask = .CREATE
        }
        self._titleTask = State(initialValue: selectedTask?.title ?? "")
        self._descriptionTask = State(initialValue: selectedTask?.descriptionTask ?? "")
        self._timeTask = State(initialValue: selectedTask?.time ?? Date())
        self._alarmTask = State(initialValue: selectedTask?.alarm ?? Date())
    }
    
    var body: some View {
        VStack {
            Form {
                Section {
                    TextField("Title",
                              text: $titleTask)
                    TextField("Description",
                              text: $descriptionTask)
                    HStack {
                        Image(systemName: "clock")
                            .foregroundStyle(Color.gray)
                        DatePicker("Time",
                                   selection: $timeTask,
                                   displayedComponents: .hourAndMinute)
                    }
                    HStack {
                        Image(systemName: "bell")
                            .foregroundStyle(Color.gray)
                        DatePicker("Alarm", selection: $alarmTask, displayedComponents: .hourAndMinute)
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
                        let newTask = Task(title: titleTask, descriptionTask: descriptionTask, date: dateTask, time: timeTask, alarm: alarmTask)
                        if typeTask == .EDIT {
                            let newTaskList = task.map { task in
                                if task.id == selectedTask?.id {
                                    return newTask
                                }
                                return task
                            }
                            task = newTaskList
                        } else {
                            task.append(newTask)
                        }
                        dismiss()
                    }) {
                        
                        if typeTask == .CREATE {
                            Text("Create")
                                .frame(maxWidth: .infinity)
                                .foregroundStyle(Color.blue)
                        } else {
                            Text("Edit")
                                .frame(maxWidth: .infinity)
                                .foregroundStyle(Color.blue)
                        }
                    }
                }
            }
        }
    }
}
