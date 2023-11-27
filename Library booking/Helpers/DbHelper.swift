//
//  DbHelper.swift
//  Library booking
//
//  Created by Majid Mobini on 11/26/23.
//

import Foundation
import SQLite3


class DbHelper {
    
    static let dbInstance = DbHelper()
    
    private let BOOK_DB_FILE = "BOOK_DB.db"
    private let MEMBERE_DB_FILE = "MEMBERE_DB.db"
    private let RENT_DB_FILE = "RENT_DB.db"
    
    private let BOOK_DB = "BOOK_DB"
    private let MEMBERE_DB = "MEMBERE_DB"
    private let RENT_DB = "RENT_DB"
    
    private let BOOK_DB_COLUMN_ID = "id";
    private let BOOK_DB_COLUMN_NAME = "name";
    private let BOOK_DB_COLUMN_YEAR = "year";
    private let BOOK_DB_COLUMN_writer = "writer";
    private let BOOK_DB_COLUMN_PUBLISHER = "publisher";
    private let BOOK_DB_COLUMN_COUNT = "count";
    
    private let MEMBERE_DB_COLUMN_ID = "id";
    private let MEMBERE_DB_COLUMN_NAME = "name";
    private let MEMBERE_DB_COLUMN_DATE_INT = "dateInt";
    private let MEMBERE_DB_COLUMN_PHONE_NO = "phoneNo";
    
    private let RENT_DB_COLUMN_ID = "id";
    private let RENT_DB_COLUMN_BOOK_NAME = "bookName";
    private let RENT_DB_COLUMN_MEMBER_NAME = "memberName";
    private let RENT_DB_COLUMN_DATE_INT = "dateInt";
    private let RENT_DB_COLUMN_BOOK_ID = "bookId";
    private let RENT_DB_COLUMN_MEMBER_ID = "memberId";
    private let RENT_DB_COLUMN_DATE_RETURN_INT = "dateIntReturn";
    private let RENT_DB_COLUMN_IS_RETURNED = "isReturned";
    
    
    
    func openBdFromPath( _ dbPath : String)  -> OpaquePointer?
    {
        var db: OpaquePointer?
        if sqlite3_open(dbPath, &db) == SQLITE_OK {
            print("Successfully opened connection to database at \(dbPath)")
            return db
        } else {
            print("Unable to open database.")
        }
        return db
    }
    
    func openBookDatabase() -> OpaquePointer? {
        let documentsDirectory = URL.documents.absoluteString
        let dbPath = documentsDirectory.appending(BOOK_DB_FILE)
        return openBdFromPath(dbPath)
        
    }
    
    func openMemberDatabase() -> OpaquePointer? {
        let documentsDirectory = URL.documents.absoluteString
        let dbPath = documentsDirectory.appending(MEMBERE_DB_FILE)
        return openBdFromPath(dbPath)
    }
    
    func openRentDatabase() -> OpaquePointer? {
        let documentsDirectory = URL.documents.absoluteString
        let dbPath = documentsDirectory.appending(RENT_DB_FILE)
        return openBdFromPath(dbPath)
    }
    
    func executeStatmentString( _ statmentString : String , db : OpaquePointer) -> Bool
    {
        var state = false
        var statement: OpaquePointer?
        if sqlite3_prepare_v2(db, statmentString, -1, &statement, nil) == SQLITE_OK {
            if sqlite3_step(statement) == SQLITE_DONE {
                print("Executed")
                state = true
            } else {
                print("Error executing")
                
            }
        } else {
            print("\(statmentString) not prepared.")
        }
        if statement != nil
        {
            sqlite3_finalize(statement)
        }
        return state
    }
    
    func createTables()
    {
        let bookDbString = "create table IF NOT EXISTS " + BOOK_DB +
        " (\(BOOK_DB_COLUMN_ID) integer primary key, \(BOOK_DB_COLUMN_NAME) text, \(BOOK_DB_COLUMN_YEAR) integer,\(BOOK_DB_COLUMN_writer) text, \(BOOK_DB_COLUMN_PUBLISHER) text,\(BOOK_DB_COLUMN_COUNT) integer);"
        
        let memberDbString = "create table IF NOT EXISTS " + MEMBERE_DB +
        " (\(MEMBERE_DB_COLUMN_ID) integer primary key, \(MEMBERE_DB_COLUMN_NAME) text, \(MEMBERE_DB_COLUMN_DATE_INT) integer,\(MEMBERE_DB_COLUMN_PHONE_NO) text);"
        
        let rentDbString = "create table IF NOT EXISTS " + RENT_DB +
        " (\(RENT_DB_COLUMN_ID) integer primary key, \(RENT_DB_COLUMN_BOOK_NAME) text, \(RENT_DB_COLUMN_MEMBER_NAME) text,\(RENT_DB_COLUMN_DATE_INT) integer,\(RENT_DB_COLUMN_BOOK_ID) integer , \(RENT_DB_COLUMN_MEMBER_ID) integer,\(RENT_DB_COLUMN_DATE_RETURN_INT) integer, \(RENT_DB_COLUMN_IS_RETURNED) integer DEFAULT 0);"
        
        
        if let db = openBookDatabase()
        {
            _ = executeStatmentString(bookDbString, db: db)
        }
        if let db = openMemberDatabase()
        {
            _ = executeStatmentString(memberDbString, db: db)
        }
        if let db = openRentDatabase()
        {
            _ = executeStatmentString(rentDbString, db: db)
        }
    }
    
    
    //    private let RENT_DB_COLUMN_ID = "id";
    //MARK: RENT DB FUNCTIONS
    func  insertRent(rent : RentClass) -> Bool
    {
        return insertRent(rent ,id: -1)
    }
    func  editRent( _ rent : RentClass) -> Bool
    {
        return insertRent(rent, id: rent.id)
    }
    func deleteRent( _ rent : RentClass) -> Bool
    {
        let statementString = "DELETE FROM \(RENT_DB) WHERE \(RENT_DB_COLUMN_ID)=\(rent.id)"
        if let db = openRentDatabase()
        {
            return executeStatmentString(statementString, db: db)
        }
        return false
    }
    func insertRent( _ rent : RentClass , id : Int) -> Bool
    {
        let value = "'\(rent.book.name)', '\(rent.member.name)',\(rent.rentDate),\(rent.book.id),\(rent.member.id),\(rent.returnDate) ,\(rent.isReturned ? "1" : "0")"
        let columns = "\(RENT_DB_COLUMN_BOOK_NAME) ,\(RENT_DB_COLUMN_MEMBER_NAME),\(RENT_DB_COLUMN_DATE_INT) ," +
        "\(RENT_DB_COLUMN_BOOK_ID) , \(RENT_DB_COLUMN_MEMBER_ID) , \(RENT_DB_COLUMN_DATE_RETURN_INT) , \(RENT_DB_COLUMN_IS_RETURNED)"
        
        var statementString = "INSERT INTO \(RENT_DB) (\(columns)) VALUES (\(value));"
        if id > -1
        {
            statementString = "REPLACE INTO \(RENT_DB) (\(RENT_DB_COLUMN_ID),\(columns)) VALUES (\(id),\(value);"
        }
        
        if let db = openRentDatabase()
        {
            return executeStatmentString(statementString, db: db)
        }
        return false
    }
    
    func rentReturned( _ rent  :RentClass ) -> Bool
    {
        let statementString = "UPDATE \(RENT_DB) SET \(RENT_DB_COLUMN_IS_RETURNED)=1,\(RENT_DB_COLUMN_DATE_RETURN_INT)=\(Date().getIntTimeStamp()) WHERE \(RENT_DB_COLUMN_ID)=\(rent.id);"
        
        if let db = openRentDatabase()
        {
            return executeStatmentString(statementString, db: db)
        }
        return false
        
    }
    
    //MARK: Book db functions
    func  insertBook( _ book : BookClass ) -> Bool
    {
        return insertBook(book , id: -1 )
    }
    func editBook ( _ book : BookClass) -> Bool
    {
        return insertBook(book, id: book.id)
    }
    func insertBook( _ book : BookClass , id : Int) -> Bool
    {
        let value = "'\(book.name)' , \(book.year), '\(book.writer)' , '\(book.publisher)' , \(book.count)"
        let columns = "\(BOOK_DB_COLUMN_NAME) ,\(BOOK_DB_COLUMN_YEAR),\(BOOK_DB_COLUMN_writer) ," +
        "\(BOOK_DB_COLUMN_PUBLISHER) , \(BOOK_DB_COLUMN_COUNT)"
        var statementString = "INSERT INTO \(BOOK_DB) (\(columns)) VALUES (\(value));"
        if id > -1
        {
            statementString = "REPLACE INTO \(BOOK_DB) (\(BOOK_DB_COLUMN_ID),\(columns)) VALUES (\(id),\(value);"
        }
        
        if let db = openBookDatabase()
        {
            return executeStatmentString(statementString, db: db)
        }
        return false
    }
    
    func getStatmentFromString( _ statementString : String , db : OpaquePointer) -> OpaquePointer?
    {
        var statement: OpaquePointer?
        if sqlite3_prepare_v2(db, statementString, -1, &statement, nil) == SQLITE_OK
        {
            return statement
        }
        return statement
    }
    func getRentedBookCount( _ bookId : Int ) -> Int
    {
        let statementString = "SELECT COUNT (*) FROM \(RENT_DB) WHERE \(RENT_DB_COLUMN_IS_RETURNED) = 0 " +
        " AND \(RENT_DB_COLUMN_BOOK_ID)= \(bookId);"
       
        if let db = openBookDatabase()
        {
            if let statement = getStatmentFromString(statementString, db: db)
            {
                if (sqlite3_step(statement) == SQLITE_ROW)
                {
                    let count = sqlite3_column_int(statement, 0)
                    return Int(count)
                }
            } else {
                print("Error executing")
            }
        } else {
            print("\(statementString) not prepared.")
        }
        return 0
    }
    
}

