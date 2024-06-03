//
//  MainView.swift
//  CalendarApp
//
//  Created by Rodrigo Adauto Ortiz on 21/05/24.
//

import SwiftUI
import SwiftData

struct MainView: View {
    @State private var selectedDate = Date()
    @State private var tasks: [Task] = []
    @Environment(\.modelContext) private var context
    
    init() {
//        let test = Test()
//        test.add(task: Task(title: "nuevo", description: "nuevo", date: Date(), time: Date(), alarm: Date()))
//        test.getTask()
    }
    
    var body: some View {
        
        NavigationStack {
            VStack {
                DatePicker("Choose a day", selection: $selectedDate,
                           displayedComponents: [.date])
                .datePickerStyle(.graphical)
                let taskFilter = tasks.filter { Calendar.current.isDate($0.date,
                                                                        inSameDayAs: selectedDate)}
                ScrollView {
                    ForEach(taskFilter) { task in
                        TaskItem(tasks: $tasks, task: task)
                    }
                }
                Spacer()
                
            }
            .toolbar(content: {
                ToolbarItem(placement: .topBarTrailing) {
                    NavigationLink {
                        NewTask(task: $tasks, dateTask: selectedDate)
                    } label: {
                        Image(systemName: "plus.circle.fill")
                    }
                }
            })
            .navigationBarTitleDisplayMode(.inline)
            .navigationTitle("To do list app")
            .padding()
        }   
    }
}

#Preview {
    MainView()
}
