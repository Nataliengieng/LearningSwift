/*
 See LICENSE folder for this sample’s licensing information.
 */

import SwiftUI
import AVFoundation

struct MeetingView: View {
    //  pass a constant scrum binding in the MeetingView() initialiser
    @Binding var scrum: DailyScrum
    //  @StateObject means the view owns the source of truth for the object
    @StateObject var scrumTimer = ScrumTimer()
    
    private var player: AVPlayer { AVPlayer.sharedDingPlayer }
    
    var body: some View {
        ZStack {
            RoundedRectangle(cornerRadius: 16.0).fill(scrum.theme.mainColor)
            VStack {
                MeetingHeaderView(secondsElapsed: scrumTimer.secondsElapsed, secondsRemaining: scrumTimer.secondsRemaining, theme: scrum.theme)
                Circle()
                    .strokeBorder(lineWidth: 24)
                MeetingFooterView(speakers: scrumTimer.speakers, skipAction: scrumTimer.skipSpeaker)
            }
        }
        .padding()
        .foregroundColor(scrum.theme.accentColor)
        //  reset and start the scrum
        .onAppear {
            startScrum()
        }
        //  The timer stops each time an instance of MeetingView leaves the screen, indicating that a meeting has ended.
        .onDisappear {
            endScrum()
        }
        .navigationBarTitleDisplayMode(.inline)
    }
    
        
    private func startScrum() {
        scrumTimer.reset(lengthInMinutes: scrum.lengthInMinutes, attendees: scrum.attendees)
        scrumTimer.speakerChangedAction = {
            player.seek(to: .zero)
            player.play()
        }
        scrumTimer.startScrum()
    }
    
    private func endScrum() {
        scrumTimer.stopScrum()
        let newHistory = History(attendees: scrum.attendees)
        scrum.history.insert(newHistory, at: 0)
    }
}

struct MeetingView_Previews: PreviewProvider {
    static var previews: some View {
        MeetingView(scrum: .constant(DailyScrum.sampleData[0]))
    }
}
