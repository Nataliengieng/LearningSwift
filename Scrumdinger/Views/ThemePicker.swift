//
//  ThemePicker.swift
//  Scrumdinger
//
//  Created by nat on 22/11/2023.
//

import SwiftUI

struct ThemePicker: View {
    //  Binding communicates changes to the theme within the theme picker back to the parent view
    @Binding var selection: Theme
    
    var body: some View {
        Picker("Theme", selection: $selection) {
            //  list all cases of Theme
            ForEach(Theme.allCases) { theme in
                ThemeView(theme: theme)
                    .tag(theme)
            }
        }
        //  When a user interacts with a navigation style picker, the system pushes the picker view onto the navigation stack. The picker view displays each theme in a ThemeView that highlights the theme’s color.
        .pickerStyle(.navigationLink)
    }
}


struct ThemePicker_Previews: PreviewProvider {
    static var previews: some View {
        ThemePicker(selection: .constant(.periwinkle))
    }
}
