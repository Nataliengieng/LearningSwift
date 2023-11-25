//
//  ScrumsView.swift
//  Scrumdinger
//
//  Created by nat on 21/11/2023.
//

import SwiftUI

struct ScrumsView: View {
    @Binding var scrums: [DailyScrum]
    //  control the presentation of the edit view to create a new scrum
    @State private var isPresentingNewScrumView = false
    //  observer scenePhase and save user data when it becomes inactive
    @Environment(\.scenePhase) private var scenePhase
    let saveAction: ()->Void
    
    var body: some View {
        NavigationStack {
            //  initialise a list view
            List($scrums) { $scrum in
                NavigationLink(destination: DetailView(scrum: $scrum)) {
                    CardView(scrum: scrum)
                }
                .listRowBackground(scrum.theme.mainColor)
            }
            .navigationTitle("Daily Scrums")
            .toolbar {
                Button(action: {
                    isPresentingNewScrumView = true
                }) {
                    Image(systemName: "plus")
                }
                .accessibilityLabel("New Scrum")
            }
        }
        .sheet(isPresented: $isPresentingNewScrumView) {
            NewScrumSheet(scrums: $scrums, isPresentingNewScrumView: $isPresentingNewScrumView)
        }
        //  trigger action if changes detected
        .onChange(of: scenePhase) { phase in
            if phase == .inactive { saveAction() }
        }
    }
}

struct ScrumsView_Previews: PreviewProvider {
    static var previews: some View {
        ScrumsView(scrums: .constant(DailyScrum.sampleData), saveAction: {})
    }
}
