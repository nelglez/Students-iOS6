//
//  StudentController.swift
//  Students
//
//  Created by Nelson Gonzalez on 5/13/19.
//  Copyright © 2019 Lambda Inc. All rights reserved.
//

import Foundation


class StudentController {
    
    //Read from the students.json file
    
    private var persistentFileUrl: URL? {
        //Go through app bundle and find the "students.json" file
        
        guard let filePath = Bundle.main.url(forResource: "students", withExtension: "json") else { return nil}
        
        return filePath
    }
    
    //By the end of this function we will have an array of Student objects.
    /*
     
     Completion closures are used for 2 main purposes.
     
     -Let you know when something has finished
     - ^+ Returing some result to another part of the app through the closure
 
 */
    func loadFromPersistentStore(completion: @escaping ([Student]) -> Void) {
        //Simulate a network call (Asynchronous code)
        
        //Queue == thread
        
        //In concurrency, a queue is a list of processes to be executed by the CPU
        
        //Making a backgrounf Queue. a queue that is going to run a concurrent code.
        
        //2 Types of queues:
        
        //-Main Queue: Handle UI. Anything the user can see.
        //-Background Queue
        
        let bgQueue = DispatchQueue(label: "StudentQueue", attributes: .concurrent)
        
        bgQueue.async {
            //This code will be run in background asynchornosuly
            
            let fm = FileManager.default
            
            //Unwrapping the url and making sure a file actually exists.
            guard let url = self.persistentFileUrl, fm.fileExists(atPath: url.path) else {
                completion([])
                return
            }
            
            
            do {
                
                let data = try Data(contentsOf: url)//Should only be used for local urls. Files in the app.
                
                let decoder = JSONDecoder()
                
                let students = try decoder.decode([Student].self, from: data)
                
                //1. Signal that the function is done
                //2. Give whoever is calling this method an array of Student objects
                
                Thread.sleep(forTimeInterval: 2) //Never do this on a real app!
                
               completion(students)
                
            } catch {
                NSLog("Error loading students from file: \(error)")
                completion([])
            }
        }
    }
    
}
