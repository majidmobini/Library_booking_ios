//
//  Constants.swift
//  Library booking
//
//  Created by Majid Mobini on 11/25/23.
//

import Foundation

class Constants {
    enum MainScreenBtnName : String, CaseIterable {
        case bookList = "Book List"
        case memberList = "Member List"
        case rentedBooksList = "Rented books list"
        case addBook = "Add book"
        case addMember = "Add member"
        case rentBook = "Rent Book"
        case createBackUp = "Create back Up"
        case restoreBackUp = "Restore Backup"
        
        func name() -> String
        {
            return self.rawValue.localize()
        }
    }
}
