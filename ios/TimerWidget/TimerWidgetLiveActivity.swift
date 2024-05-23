import ActivityKit
import WidgetKit
import SwiftUI

struct LiveActivitiesAppAttributes: ActivityAttributes, Identifiable {
    public typealias LiveDeliveryData = ContentState
    
    public struct ContentState: Codable, Hashable { }
    
    var id = UUID()
}

let sharedDefault = UserDefaults(suiteName: "group.nutcache.live")!

struct TimerWidgetLiveActivity: Widget {
    @State private var timerString = ""
    @State private var isPaused = false
    @State private var isStopped = false
    
    var body: some WidgetConfiguration {
        ActivityConfiguration(for: LiveActivitiesAppAttributes.self) { context in
            let heading = sharedDefault.string(forKey:context.attributes.prefixedKey("heading"))!
            let timerStart = sharedDefault.integer(forKey:context.attributes.prefixedKey("start"))
            
            // Lock screen/banner UI goes here
            VStack() {
                Text(heading + (isStopped ? " Stopped" : ""))
                Text(timerString)
                    .onAppear {
                        let seconds = Int(timerStart) % 60
                        let minutes = Int(timerStart) / 60 % 60
                        let hours = Int(timerStart) / 3600
                        timerString = String(format: "%02d:%02d:%02d", hours, minutes, seconds)
                    }
                HStack(){
                    Link(destination: URL(string: "nutcache://nutcache.com/pause")!) {
                        Text(isPaused ? "Continue" : "Pause")
                    }
                }
            }
            .activityBackgroundTint(Color.cyan)
            .activitySystemActionForegroundColor(Color.black)
            
        } dynamicIsland: { context in
            DynamicIsland {
                // Expanded UI goes here.  Compose the expanded UI through
                // various regions, like leading/trailing/center/bottom
                DynamicIslandExpandedRegion(.leading) {
                    Text("Leading")
                }
                DynamicIslandExpandedRegion(.trailing) {
                    Text("Trailing")
                }
                DynamicIslandExpandedRegion(.bottom) {
                    Text("Bottom bob")
                    // more content
                }
            } compactLeading: {
                Text("L")
            } compactTrailing: {
                Text("T bob")
            } minimal: {
                Text("bob")
            }
            .widgetURL(URL(string: "http://www.apple.com"))
            .keylineTint(Color.red)
        }
    }
}

extension LiveActivitiesAppAttributes {
    func prefixedKey(_ key: String) -> String {
        return "\(id)_\(key)"
    }
}
