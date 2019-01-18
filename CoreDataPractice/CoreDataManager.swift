//
//  CoreDataManager.swift
//  CoreDataPractice
//
//  Created by apple on 18/01/19.
//  Copyright © 2019 iOSProofs. All rights reserved.
//

import Foundation
import CoreData

class CoreDataManager {
    
    private init() { }
    
    static var shared = CoreDataManager()
    
    lazy var persistentContainer: NSPersistentContainer = {
        let container = NSPersistentContainer(name: "CoreDataPractice")
        container.loadPersistentStores(completionHandler: { (storeDescription, error) in
            if let error = error as NSError? {
               
                fatalError("Unresolved error \(error), \(error.userInfo)")
            }
        })
        return container
    }()
    
    lazy var context = self.persistentContainer.viewContext
    
    func save () {
        if context.hasChanges {
            do {
                try context.save()
            } catch {
                let nserror = error as NSError
                fatalError("Unresolved error \(nserror), \(nserror.userInfo)")
            }
        }
    }
    
    func createNewObject() {
        
    }
    
    func fetchCars() -> [Car] {
        let fetchRequest = NSFetchRequest<NSFetchRequestResult>(entityName: "Car")
        do {
         return try context.fetch(fetchRequest) as? [Car] ?? []
        } catch {
            print("Error occurred during fetch")
        }
        return []
    }
    
    func deleteObject() {
        
    }
    
    func updateObject() {
        
    }
}
