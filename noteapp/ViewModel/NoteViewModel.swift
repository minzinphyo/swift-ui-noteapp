//
//  NoteViewModel.swift
//  noteapp
//
//  Created by Min Zin Phyo on 08/06/2024.
//

import Foundation
import CoreData

class NoteViewModel: ObservableObject {
    
    let manager : CoreDataManager
    @Published var notes: [NoteEntity] = []
    @Published var isDataLoaded = false
    
    init(manager: CoreDataManager) {
        self.manager = manager
        loadData()
    }
    
    func loadData(){
        manager.loadCoreData{ [weak self] success in
            DispatchQueue.main.async {
                self?.isDataLoaded = success
                if success{
                    self?.fetchNotes()
                }
            }
        }
    }
    
    func fetchNotes(with searchText: String = ""){
        let request: NSFetchRequest<NoteEntity> = NoteEntity.fetchRequest()
        request.sortDescriptors = [NSSortDescriptor(key: "timestamp", ascending: false)]
               
               if !searchText.isEmpty {
                   request.predicate = NSPredicate(format: "title CONTAINS %@", searchText)
               }

               do {
                   notes = try manager.container.viewContext.fetch(request)
               } catch {
                   print("Error fetching notes: \(error)")
               }
    }
    
    func createNote() -> NoteEntity {
        let newNote = NoteEntity(context: manager.container.viewContext)
        newNote.id = UUID()
        newNote.timestamp = Date()
        saveData()
        fetchNotes()
        
      return newNote
    }
    
    func deleteNote(_ note: NoteEntity) {
        manager.container.viewContext.delete(note)
        saveData()
        fetchNotes() // Refresh notes list
    }

    func updateNote(_ note: NoteEntity, title: String, content: String) {
        note.title = title
        note.content = content
        saveData()
        fetchNotes() // Refresh notes list
    }
    
    func searchNotes(with searchText: String) {
        fetchNotes(with: searchText)
    }
    
    private func saveData(){
        do{
            try manager.container.viewContext.save()
        }catch{
            print("Error save \(error)")
        }
    }
}
