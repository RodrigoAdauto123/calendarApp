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
    @EnvironmentObject var recorderViewModel: AudioRecorder
    
    var dateTask: Date
    var selectedTask: Task?
    let typeTask: TypeTask
    @State private var titleTask: String = .empty
    @State private var descriptionTask: String = .empty
    @State private var timeTask = Date()
    @State var hasRecording: Bool = false
    
    init(dateTask: Date, selectedTask: Task? = nil, typeTask: TypeTask) {
        self.dateTask = dateTask
        self.selectedTask = selectedTask
        self.typeTask = typeTask
        self._titleTask = State(initialValue: selectedTask?.title ?? .empty)
        self._descriptionTask = State(initialValue: selectedTask?.descriptionTask ?? .empty)
        self._timeTask = State(initialValue: selectedTask?.time ?? Date())
        guard let audioFilename = selectedTask?.audioFilename else { return }
        self._hasRecording = State(initialValue: !audioFilename.isEmpty)
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
                    RecorderView(hasRecording: $hasRecording,
                                 audioRecorderName: selectedTask?.audioFilename ?? .empty,
                                 typeTask: typeTask)
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
                        var newAudioURL: URL?
                        if recorderViewModel.isRecording {
                            recorderViewModel.stopRecording()
                        }
                        if let currentAudioURL = recorderViewModel.currentAudioURL {
                            let documentPath = FileManager.default.urls(for: .documentDirectory, in: .userDomainMask)[0]
                            let newAudioFilename = newTask.id.uuidString + ".m4a"
                            newAudioURL = documentPath.appendingPathComponent(newAudioFilename)
                            guard let newAudioURL else { return }
                            do {
                                try FileManager.default.moveItem(at: currentAudioURL, to: newAudioURL)
                                recorderViewModel.currentAudioFilename = newAudioFilename
                                recorderViewModel.currentAudioURL = newAudioURL
                                newTask.audioFilename = newTask.id.uuidString
                            } catch {
                                print("Failed to rename audio file: \(error)")
                            }
                        }
                        
                        if typeTask == .EDIT {
                            self.selectedTask?.title = newTask.title
                            self.selectedTask?.descriptionTask = newTask.descriptionTask
                            self.selectedTask?.date = newTask.date
                            self.selectedTask?.time = newTask.time
                            if let newAudioURL {
                                self.selectedTask?.audioFilename = newTask.id.uuidString
                            }
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
