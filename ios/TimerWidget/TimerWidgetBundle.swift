//
//  TimerWidgetBundle.swift
//  TimerWidget
//
//  Created by Zakaria Mrad on 2024-05-16.
//

import WidgetKit
import SwiftUI

@main
struct TimerWidgetBundle: WidgetBundle {
    var body: some Widget {
        TimerWidget()
        TimerWidgetLiveActivity()
    }
}
