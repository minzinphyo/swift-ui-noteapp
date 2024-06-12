//
//  noteappApp.swift
//  noteapp
//
//  Created by Min Zin Phyo on 08/06/2024.
//

import SwiftUI

@main
struct noteappApp: App {
    let coreDataManager = CoreDataManager()
        @StateObject var notesViewModel: NoteViewModel

            init() {
                let viewModel = NoteViewModel(manager: coreDataManager)
                _notesViewModel = StateObject(wrappedValue: viewModel)
            }
    var body: some Scene {
        WindowGroup {
            ContentView()
                .environmentObject(notesViewModel)
        }
    }
}
