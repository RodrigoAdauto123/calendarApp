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
    @Query private var tasks: [Task] = []
    @Environment(\.modelContext) private var context
    
    var body: some View {
        NavigationStack {
            VStack {
                DatePicker("Choose a day", selection: $selectedDate,
                           displayedComponents: [.date])
                .datePickerStyle(.graphical)
                let taskFilter = tasks.filter { Calendar.current.isDate($0.date ?? Date(),
                                                                        inSameDayAs: selectedDate)}
                let taskSorted = taskFilter.sorted { $0.time ?? Date() > $1.time ?? Date() }
                ScrollView {
                    ForEach(taskSorted) { task in
                        TaskItem(task: task)
                            .padding(.bottom, 20)
                    }
                }
                Spacer()
                
            }
            .toolbar(content: {
                ToolbarItem(placement: .topBarTrailing) {
                    NavigationLink {
                        NewTask(dateTask: selectedDate, typeTask: .CREATE)
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
