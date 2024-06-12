//
//  ContentView.swift
//  noteapp
//
//  Created by Min Zin Phyo on 08/06/2024.
//

import SwiftUI

struct ContentView: View {
    
    @EnvironmentObject var noteViewModel: NoteViewModel
    
    var body: some View {
        
        Group{
            if noteViewModel.isDataLoaded {
                NoteView()
            }else{
                ProgressView("Loading....")
            }
        }
    }
}

#Preview {
    ContentView()
}
