//
//  Library_bookingTests.swift
//  Library bookingTests
//
//  Created by Majid Mobini on 11/25/23.
//

import XCTest
@testable import Library_booking

final class Library_bookingTests: XCTestCase {

    override func setUpWithError() throws {
        // Put setup code here. This method is called before the invocation of each test method in the class.
        DbHelper.dbInstance.createTables()
        
    }

    override func tearDownWithError() throws {
        // Put teardown code here. This method is called after the invocation of each test method in the class.
    }
    func testDatabase()
    {
        let book = BookClass()
        book.name = "test"
        book.publisher = "publisher"
        book.writer = "writer"
        book.year = 2020
        if DbHelper.dbInstance.insertBook(book)
        {
        
            print("Inserted successfully")
            let books = DbHelper.dbInstance.getBooks(name: "")
            XCTAssertEqual(books[0].name, book.name)
            print(books[0].name)
        
        }
        else
        {
            XCTFail("fail to create")
            print("Cannot insert")
        }
        
    }
    
    func testExample() throws {
        // This is an example of a functional test case.
        // Use XCTAssert and related functions to verify your tests produce the correct results.
        // Any test you write for XCTest can be annotated as throws and async.
        // Mark your test throws to produce an unexpected failure when your test encounters an uncaught error.
        // Mark your test async to allow awaiting for asynchronous code to complete. Check the results with assertions afterwards.
    }

//    func testPerformanceExample() throws {
//        // This is an example of a performance test case.
//        self.measure {
//            // Put the code you want to measure the time of here.
//        }
//    }

}
