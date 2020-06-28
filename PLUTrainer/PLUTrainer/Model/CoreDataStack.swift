//
//  CoreDataStack.swift
//  PLUTrainer
//
//  Created by Cao Mai on 6/27/20.
//  Copyright © 2020 Mondale. All rights reserved.
//

import Foundation
import CoreData

class CoreDataStack {
    
    private let modelName: String
    private lazy var storeContainer: NSPersistentContainer = {
        let container = NSPersistentContainer(name: self.modelName)
        container.loadPersistentStores { (storeDescription, error) in
            if let error = error as NSError? {
                print("Error: \(error), \(error.userInfo)")
            }
        }
        return container
    }()
    lazy var managedContext: NSManagedObjectContext = {
        // get location of stored core data file
//        print(self.storeContainer.persistentStoreDescriptions.first?.url)
        return self.storeContainer.viewContext
    }()
    
    init(modelName: String) {
        self.modelName = modelName
    }
    
    func saveContext() {
        guard managedContext.hasChanges else { return }
        
        do {
            try managedContext.save()
        } catch let error as NSError {
            print("Error: \(error), \(error.userInfo)")
        }
    }
    
    func fetchPersistedData(completion: @escaping(Result<[Produce]>) -> Void) {
        let fetchRequest: NSFetchRequest<Produce> = Produce.fetchRequest()
        
    }
}

enum Result<T> {
    case success(T)
    case failure(Error)
}
