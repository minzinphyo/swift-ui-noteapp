//
//  EditNoteView.swift
//  noteapp
//
//  Created by Min Zin Phyo on 12/06/2024.
//

import SwiftUI

struct EditNoteView: View {
    
    @EnvironmentObject var vm: NoteViewModel
       
       @State var note: NoteEntity?
       @State private var title: String = ""
       @State private var content: String = ""
    
       @FocusState private var contentEditorInFocus: Bool
    
       @Environment(\.dismiss) var dismiss
    
    var body: some View {
        ScrollView{
            VStack(alignment: .leading,spacing: 20){
                TextField("Title",text: $title,axis: .vertical)
                    .font(.title.bold())
                    .submitLabel(.next)
                    .onChange(of: title, {
                        guard let newValueLastChar = title.last else { return }
                        if newValueLastChar == "\n" {
                           title.removeLast()
                           contentEditorInFocus = true
                        }
                    })
            }
            .padding(10)
        }
        .navigationBarTitleDisplayMode(.inline)
                .toolbar {
                    ToolbarItem(placement: .keyboard) {
                        HStack {
                            Spacer()
                            Button("Done") {
                                //self.hideKeyboard()
                                // Save to Core Data
                                self.updateNote(title: title, content: content)
                                dismiss()
                            }
                        }
                    }
        }
        .onAppear {
                    
           if let note = note {
              self.title = note.title ?? ""
              self.content = note.content ?? ""
            }
        }
    }
    
    // MARK: Core Data Operations

    func updateNote(title: String, content: String) {
        
        if (title.isEmpty) && (content.isEmpty) {
            return
        }
        
        guard let note = note else { return }
        
        vm.updateNote(note, title: title, content: content)
    }
}

#Preview {
    EditNoteView()
}
