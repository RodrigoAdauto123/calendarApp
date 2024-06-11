//
//  Task.swift
//  CalendarApp
//
//  Created by Rodrigo Adauto Ortiz on 21/05/24.
//

import Foundation
import SwiftData

@Model
class Task: Identifiable {
    let id = UUID()
    var title: String?
    var descriptionTask: String?
    var date: Date?
    var time: Date?
    
    init(title: String, descriptionTask: String, date: Date, time: Date) {
        self.title = title
        self.descriptionTask = descriptionTask
        self.date = date
        self.time = time
    }
}
