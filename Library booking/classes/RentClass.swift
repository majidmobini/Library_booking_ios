//
//  RentClass.swift
//  Library booking
//
//  Created by Majid Mobini on 11/25/23.
//

import Foundation

class RentClass {
    var id : Int = -1
    var book : BookClass 
    var member : MemberClass
    var rentDate : Date = Date()
    var returnDate : Date = Date()
    var isReturned : Bool = false

    
    init(book : BookClass , member : MemberClass)
    {
        self.book = book
        self.member = member
    }
}
