//
//  ScrumsView.swift
//  Scrumdinger
//
//  Created by nat on 21/11/2023.
//

import SwiftUI

struct ScrumsView: View {
    let scrums: [DailyScrum]
    
    var body: some View {
        //  initialise a list view
        List(scrums) { scrum in
            CardView(scrum: scrum).listRowBackground(scrum.theme.mainColor)
        }
    }
}

struct ScrumsView_Previews: PreviewProvider {
    static var previews: some View {
        ScrumsView(scrums: DailyScrum.sampleData)
    }
}
