//
//  Task.swift
//  VolunteerVortex
//
//  Created by George Gilmartin on 12/3/15.
//  Copyright © 2015 George Gilmartin. All rights reserved.
//

import Foundation

class Task {
    var taskName: String? = ""
    var taskTime: String? = ""
    var taskDescription: String? = ""
    var taskID: Int = 0
    
    init(taskName: String, taskTime: String, taskDescription: String, taskID: Int) {
        self.taskName = taskName
        self.taskTime = taskTime
        self.taskDescription = taskDescription
        self.taskID = taskID
    }
}