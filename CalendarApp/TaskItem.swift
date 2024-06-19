//
//  TaskItem.swift
//  CalendarApp
//
//  Created by Rodrigo Adauto Ortiz on 21/05/24.
//

import SwiftUI

struct TaskItem: View {
    @Environment(\.modelContext) private var context
    var task: Task
    
    var body: some View {
        NavigationStack {
            HStack {
                VStack(alignment: .leading) {
                    Text(task.time?.getHourAndMinute() ?? .empty)
                        .font(.system(size: 10))
                        .foregroundStyle(Color.gray)
                        .italic()
                    Text(task.title ?? .empty)
                        .font(.system(size: 18))
                        .bold()
                    Text(task.descriptionTask ?? .empty)
                        .font(.system(size: 12))
                }
                .padding(.leading, 30)
                Spacer()
                VStack {
                    NavigationLink {
                        NewTask(dateTask: task.date ?? Date(),
                                selectedTask: task,
                                typeTask: .EDIT)
                    } label: {
                        Image(systemName: "pencil")
                            .foregroundStyle(Color.gray)
                    }
                    
                    Spacer()
                    Button(action: {
                        TaskDataManager.deleteTask(task: task, modelContext: context)
                    }, label: {
                        Image(systemName: "trash")
                            .foregroundStyle(Color.gray)
                    })
                    
                }
                .padding(.horizontal, 30)
            }
        }
    }
}
