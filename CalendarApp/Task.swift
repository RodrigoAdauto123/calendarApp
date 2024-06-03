//
//  Task.swift
//  CalendarApp
//
//  Created by Rodrigo Adauto Ortiz on 21/05/24.
//

import Foundation
import SwiftData

struct Task: Identifiable, Codable {
    let id = UUID()
    let title: String
    let descriptionTask: String
    let date: Date
    let time: Date
    let alarm: Date
}

//@Model
//struct Task: Identifiable {
//    @Attribute(.unique) let id = UUID()
//    let title: String
//    let descriptionTask: String
//    let date: Date
//    let time: Date
//    let alarm: Date
//    
//    init(title: String, descriptionTask: String, date: Date, time: Date, alarm: Date) {
//        self.title = title
//        self.descriptionTask = descriptionTask
//        self.date = date
//        self.time = time
//        self.alarm = alarm
//    }
//}
