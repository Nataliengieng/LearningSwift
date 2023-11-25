//
//  History.swift
//  Scrumdinger
//
//  Created by nat on 24/11/2023.
//

import Foundation

struct History: Identifiable, Codable {
    //  storing the essential details of a scrum session
    let id: UUID
    let date: Date
    var attendees: [DailyScrum.Attendee]
    
    //  initialiser
    init(id: UUID = UUID(), date: Date = Date(), attendees: [DailyScrum.Attendee]) {
        self.id = id
        self.date = date
        self.attendees = attendees
    }
}
