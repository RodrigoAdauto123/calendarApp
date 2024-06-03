//
//  TaskItem.swift
//  CalendarApp
//
//  Created by Rodrigo Adauto Ortiz on 21/05/24.
//

import SwiftUI

struct TaskItem: View {
    
    @Binding var tasks: [Task]
    var task: Task
    
    var body: some View {
        NavigationStack {
            HStack {
                VStack(alignment: .leading) {
                    Text(task.time.getHourAndMinute())
                        .font(.system(size: 10))
                        .foregroundStyle(Color.gray)
                        .italic()
                    Text(task.title)
                        .font(.system(size: 18))
                        .bold()
                    Text(task.descriptionTask)
                        .font(.system(size: 12))
                        .foregroundStyle(Color.gray)
                }
                .padding(.leading, 30)
                
                Spacer()
                Spacer()
                VStack {
                    NavigationLink {
                        NewTask(task: $tasks, dateTask: task.date,
                                selectedTask: task)
                    } label: {
                        Text("Edit")
                            .font(.system(size: 12))
                            .bold()
                            .padding(.bottom, 10)
                    }
                    .buttonStyle(PlainButtonStyle())
                    Image(systemName: "bell.fill")
                }
                .padding(.horizontal, 30)
            }
        }
    }
}


#Preview {
    @State var tasks1: [Task] = []
    let newTask = Task(title: "qwer", descriptionTask: "description", date: Date(), time: Date(), alarm: Date())
    return TaskItem(tasks: $tasks1, task: newTask)
}
