//
//  CoreDataManager.swift
//  noteapp
//
//  Created by Min Zin Phyo on 08/06/2024.
//

import CoreData

class CoreDataManager {
    
    let container: NSPersistentContainer
    
    init() {
        container = NSPersistentContainer(name: "NoteContainer")
    }
    
    func loadCoreData(completion: @escaping (Bool) -> Void){
        container.loadPersistentStores { description, error in
            DispatchQueue.main.async {
                if let error = error{
                    print("Core Data loading error : \(error.localizedDescription)")
                    completion(false)
                }else{
                   completion(true)
                }
            }
        }
    }
}
