//
//  DetailView.swift
//  Scrumdinger
//
//  Created by nat on 21/11/2023.
//

import SwiftUI

struct DetailView: View {
    @Binding var scrum: DailyScrum
    
    @State private var editingScrum = DailyScrum.emptyScrum
    @State private var isPresentingEditView = false
    
    var body: some View {
        List {
            Section(header: Text("Meeting Info")) {
                //  set navigation link and set MeetingView as the destination
                NavigationLink(destination: MeetingView(scrum: $scrum)) {
                    Label("Start Meeting", systemImage: "timer")
                        .font(.headline)
                    .foregroundColor(.accentColor)
                }
                HStack {
                    Label("Length", systemImage: "clock")
                    Spacer()
                    Text("\(scrum.lengthInMinutes) minutes")
                }
                .accessibilityElement(children: .combine)
                HStack {
                    Label("Theme", systemImage: "paintpalette")
                    Spacer()
                    //  add padding, foreground and background colours
                    //  and a corner radius
                    Text(scrum.theme.name).padding(4).foregroundColor(scrum.theme.accentColor).background(scrum.theme.mainColor).cornerRadius(4)
                }
                .accessibilityElement(children: .combine)
            }
            //  group the attendee information
            Section(header: Text("Attendees")) {
                ForEach(scrum.attendees) { attendee in
                    Label(attendee.name, systemImage: "person")
                }
            }
            Section(header: Text("History")) {
                if scrum.history.isEmpty {
                    Label("No meeting yet", systemImage: "calendar.badge.exclamationmark")
                }
                ForEach(scrum.history) { history in
                    HStack {
                        Image(systemName: "calendar")
                        Text(history.date, style: .date)
                    }
                }
            }
        }
        .navigationTitle(scrum.title)
        .toolbar {
            //  Edit button that sets isPresentingEditView to true
            Button("Edit") {
                isPresentingEditView = true
                editingScrum = scrum
            }
        }
        //  when isPresentingEditView is true, the DetailEditView is showed using a modal sheet that partially covers the underlying content
        .sheet(isPresented: $isPresentingEditView) {
            NavigationStack {
                DetailEditView(scrum: $editingScrum)
                    .navigationTitle(scrum.title)
                    .toolbar {
                        ToolbarItem(placement: .cancellationAction) {
                            //  buttons that indicates to the user that they are canceling changes and returning to DetailView
                            Button("Cancel") {
                                isPresentingEditView = false
                            }
                        }
                        ToolbarItem(placement: .confirmationAction) {
                            //  buttons that saves the changes and return to DetailView
                            Button("Done") {
                                isPresentingEditView = false
                                scrum = editingScrum
                            }
                        }
                    }
            }
        }
    }
}

struct DetailView_Previews: PreviewProvider {
    static var previews: some View {
        NavigationStack {
            DetailView(scrum: .constant(DailyScrum.sampleData[0]))
        }
    }
}
