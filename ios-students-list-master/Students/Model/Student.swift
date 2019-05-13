//
//  Student.swift
//  Students
//
//  Created by Andrew R Madsen on 8/5/18.
//  Copyright © 2018 Lambda Inc. All rights reserved.
//

import Foundation

struct Student: Codable {
    //When using codable non-optional properties means that we need the values from the JSON.
    var name: String
    var course: String? //if there is no course it will just put 'nil' for the value
    
    
    //Dont do this in a real app.
    var firstName: String {
        return name.components(separatedBy: " ")[0]
    }
    
    var lastName: String {
         return name.components(separatedBy: " ")[1]
    }
}
