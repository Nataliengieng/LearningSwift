//
//  DetailEditView.swift
//  Scrumdinger
//
//  Created by nat on 22/11/2023.
//

import SwiftUI

struct DetailEditView: View {
    //  State property wrapper defines the source of truth for value types
    //  private property can only be accessed within this view
    @Binding var scrum: DailyScrum
    @State private var newAttendeeName = ""
    
    var body: some View {
        //  creating a form
        Form {
            Section(header: Text("Meeting Info")) {
                //  $ -> create a binding to scrum.title
                TextField("Title", text: $scrum.title)
                //  HStack and Slider for the meeting length
                HStack {
                    //  step value is 1 to limit the user to choosing whole numbers
                    Slider(value: $scrum.lengthInMinutesAsDouble, in: 5...30, step: 1) {
                        //  VoiceOver uses the text to identify the purpose of the slider
                        Text("Length")
                    }
                    .accessibilityValue("\(scrum.lengthInMinutes) minutes")
                    Spacer()
                    Text("\(scrum.lengthInMinutes) minutes").accessibilityHidden(/*@START_MENU_TOKEN@*/true/*@END_MENU_TOKEN@*/)
                }
                ThemePicker(selection: $scrum.theme)
                //  another section to form to display the scrum attendees
                Section(header: Text("Attendees")) {
                    //  ForEach view to display each attendee
                    ForEach(scrum.attendees) { attendee in
                        Text(attendee.name)
                    }
                    //remove attendees from the scrum data
                    .onDelete { indices in scrum.attendees.remove(atOffsets: indices)
                    }
                    //  to add new attendee
                    HStack {
                        TextField("New Attendee", text: $newAttendeeName)
                        //  create a new attendee and appends the new attendee to the attendees array
                        Button(action: {
                            withAnimation {
                                let attendee = DailyScrum.Attendee(name: newAttendeeName)
                                scrum.attendees.append(attendee)
                                newAttendeeName = ""
                            }
                        }) {
                            Image(systemName: "plus.circle.fill").accessibilityLabel("Add attendee")
                        }
                        //  disable the button if the field is empty
                        .disabled(newAttendeeName.isEmpty)
                    }
                }
            }
        }
    }
}

struct DetailEditView_Preview: PreviewProvider {
    static var previews: some View {
        DetailEditView(scrum: .constant(DailyScrum.sampleData[0]))
    }
}
