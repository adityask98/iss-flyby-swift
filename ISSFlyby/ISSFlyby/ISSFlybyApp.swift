//
//  ISSFlybyApp.swift
//  ISSFlyby
//
//  Created by Aditya Srinivasa on 2023/11/12.
//

import SwiftUI

@main
struct ISSFlybyApp: App {
    var body: some Scene {
        WindowGroup {
            LocationPicker().environmentObject(MarkerData())
        }
    }
}
