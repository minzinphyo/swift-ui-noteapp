//
//  ListItemView.swift
//  noteapp
//
//  Created by Min Zin Phyo on 12/06/2024.
//

import SwiftUI

struct ListItemView: View {
    
    var note : NoteEntity
    
    var body: some View {
        VStack(alignment: .leading,spacing: 5){
            Text(note.title ?? "New Note")
                .lineLimit(1)
                .font(.title3)
                .fontWeight(.bold)
            Text(note.content ?? "New Content")
                .lineLimit(1)
                .fontWeight(.light)
        }
    }
}
