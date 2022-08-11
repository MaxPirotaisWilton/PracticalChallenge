//
//  Person.swift
//  PracticalChallenge
//
//  Created by Max Pirotais-Wilton on 10/08/22.
//

import Foundation

struct Person {
    
    var title, fName, lName: String
    
    var gender : String
    
    var dob: Date
    
    var email: String
    
    var phone, cell: String
    
    var thumbnailURL, fullPictureURL: String
    
}

func ModelToPerson(result:Result) -> Person {
    
    //for date of birth, convert string into date
    let dateFormatter = DateFormatter()
    dateFormatter.locale = Locale(identifier: "en_US_POSIX") // set locale to reliable US_POSIX
    dateFormatter.dateFormat = "yyyy-MM-dd'T'HH:mm:ss.SSSZ"
    let date = dateFormatter.date(from:result.dob.date)!
    
    let calendar = Calendar.current
    let components = calendar.dateComponents([.year, .month, .day, .hour], from: date)
    
    let finalDate = calendar.date(from:components) ?? Date()
    
    let person: Person = Person(title: result.name.title,
                                fName: result.name.first,
                                lName: result.name.last,
                                gender: result.gender,
                                dob: finalDate,
                                email: result.email,
                                phone: result.phone,
                                cell: result.cell,
                                thumbnailURL: result.picture.thumbnail,
                                fullPictureURL: result.picture.large)
    
    return person
}

func ModelToPeople(results: [Result]) -> [Person] {
    var people: [Person] = []
    for result in results{
        people.append(ModelToPerson(result: result))
    }
    return people
}
