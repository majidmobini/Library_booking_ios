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
    
    private let BOOK_DB_ID_NO = 0
    private let BOOK_DB_NAME_NO = 1
    private let BOOK_DB_YEAR_NO = 2
    private let BOOK_DB_WRITER_NO = 3
    private let BOOK_DB_PUBLISHER_NO = 4
    private let BOOK_DB_COUNT_NO = 5
    
    
    private let MEMBERE_DB_COLUMN_ID = "id";
    private let MEMBERE_DB_COLUMN_NAME = "name";
    private let MEMBERE_DB_COLUMN_DATE_INT = "dateInt";
    private let MEMBERE_DB_COLUMN_PHONE_NO = "phoneNo";
    
    private let MEMBERE_DB_ID_NO = 0
    private let MEMBERE_DB_NAME_NO = 1
    private let MEMBERE_DB_DATE_INT_NO = 2
    private let MEMBERE_DB_PHONE_NO = 3
    
    private let RENT_DB_COLUMN_ID = "id";
    private let RENT_DB_COLUMN_BOOK_NAME = "bookName";
    private let RENT_DB_COLUMN_MEMBER_NAME = "memberName";
    private let RENT_DB_COLUMN_DATE_INT = "dateInt";
    private let RENT_DB_COLUMN_BOOK_ID = "bookId";
    private let RENT_DB_COLUMN_MEMBER_ID = "memberId";
    private let RENT_DB_COLUMN_DATE_RETURN_INT = "dateIntReturn";
    private let RENT_DB_COLUMN_IS_RETURNED = "isReturned";
    
    private let RENT_DB_ID_NO = 0
    private let RENT_DB_BOOK_NAME_NO = 1
    private let RENT_DB_MEMBER_NAME_NO = 2
    private let RENT_DB_DATE_INT_NO = 3
    private let RENT_DB_BOOK_ID_NO = 4
    private let RENT_DB_MEMBER_ID_NO = 5
    private let RENT_DB_DATE_RETURN_NO = 6
    private let RENT_DB_ISRETURNED_NO = 7
    
    
    
    
    private func openBdFromPath( _ dbPath : String)  -> OpaquePointer?
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
    
    private func openBookDatabase() -> OpaquePointer? {
        let documentsDirectory = URL.documents.absoluteString
        let dbPath = documentsDirectory.appending(BOOK_DB_FILE)
        return openBdFromPath(dbPath)
        
    }
    
    private func openMemberDatabase() -> OpaquePointer? {
        let documentsDirectory = URL.documents.absoluteString
        let dbPath = documentsDirectory.appending(MEMBERE_DB_FILE)
        return openBdFromPath(dbPath)
    }
    
    private func openRentDatabase() -> OpaquePointer? {
        let documentsDirectory = URL.documents.absoluteString
        let dbPath = documentsDirectory.appending(RENT_DB_FILE)
        return openBdFromPath(dbPath)
    }
    
    private func executeStatmentString( _ statmentString : String , db : OpaquePointer) -> Bool
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
        sqlite3_close(db)
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
    func deleteBookWithId( _ id : Int) -> Bool
    {
        let statementString = "DELETE FROM \(BOOK_DB) WHERE \(BOOK_DB_COLUMN_ID)=\(id)"
        if let db = openBookDatabase()
        {
            return executeStatmentString(statementString, db: db)
        }
        return false
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
    
    private func getStatmentFromString( _ statementString : String , db : OpaquePointer) -> OpaquePointer?
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
       
        if let db = openRentDatabase()
        {
            if let statement = getStatmentFromString(statementString, db: db)
            {
                if (sqlite3_step(statement) == SQLITE_ROW)
                {
                    let count = sqlite3_column_int(statement, 0)
                    sqlite3_finalize(statement)
                    return Int(count)
                }
                sqlite3_finalize(statement)
                
            } else {
                print("Error executing")
            }
            sqlite3_close(db)
        } else {
            print("\(statementString) not prepared.")
        }
        return 0
    }
    
    func getBookNumbers() -> Int
    {
        let statementString = "SELECT SUM (\(BOOK_DB_COLUMN_COUNT)) FROM \(BOOK_DB);"
        if let db = openBookDatabase()
        {
            if let statement = getStatmentFromString(statementString, db: db)
            {
                if (sqlite3_step(statement) == SQLITE_ROW)
                {
                    let count = sqlite3_column_int(statement, 0)
                    sqlite3_finalize(statement)
                    return Int(count)
                }
                sqlite3_finalize(statement)
                
            } else {
                print("Error executing")
            }
            sqlite3_close(db)
        } else {
            print("\(statementString) not prepared.")
        }
        return 0
    }
    
    //MARK: Member functions
    
    func insertMember(_ member : MemberClass) -> Bool
    {
        return insertMember(member, id: -1)
    }
    func editMember(_ member : MemberClass) -> Bool
    {
        return insertMember(member, id: member.id)
    }
    func deleteMemberWithId( _ id : Int) -> Bool
    {
        let statementString = "DELETE FROM \(MEMBERE_DB) WHERE \(MEMBERE_DB_COLUMN_ID)=\(id)"
        if let db = openMemberDatabase()
        {
            return executeStatmentString(statementString, db: db)
        }
        return false
    }
    func insertMember( _ member : MemberClass , id : Int) -> Bool
    {
        let value = "'\(member.name)' , \(member.phoneNo), '\(member.date.getIntTimeStamp())'"
        let columns = "\(MEMBERE_DB_COLUMN_NAME) ,\(MEMBERE_DB_COLUMN_PHONE_NO),\(MEMBERE_DB_COLUMN_DATE_INT) "
        
        var statementString = "INSERT INTO \(MEMBERE_DB) (\(columns)) VALUES (\(value));"
        if id > -1
        {
            statementString = "REPLACE INTO \(MEMBERE_DB) (\(MEMBERE_DB_COLUMN_ID),\(columns)) VALUES (\(id),\(value);"
        }
        
        if let db = openBookDatabase()
        {
            return executeStatmentString(statementString, db: db)
        }
        return false
    }
    
    //MARK: Get Objects class
    /*
     name : to serarch in book name or member name , empty to search all
     isReturn : 0 not returned  , 1 returned
     */
    func getIntFrom( _ statement : OpaquePointer , row : Int) -> Int
    {
        return Int(sqlite3_column_int(statement, Int32(row)))
    }
    func getStringFrom( _ statement : OpaquePointer , row : Int) -> String
    {
        return String(cString: sqlite3_column_text(statement, Int32(row)))
    }
    func getRents(name : String) -> [RentClass]
    {
        return getRents(name: name, isReturned: 0)
    }
    func getRents( name : String , isReturned : Int) -> [RentClass]
    {
        var rentList : [RentClass] = []
        var statmentString = "select * from \(RENT_DB) where \(RENT_DB_COLUMN_IS_RETURNED) = \(isReturned)"
        if !name.isEmpty
        {
            statmentString = "select * from "+RENT_DB+" where "+RENT_DB_COLUMN_BOOK_NAME+" like '%"+name+"%' OR "+RENT_DB_COLUMN_MEMBER_NAME+"  like '%"+name+"%'"
        }
        
        if let db = openRentDatabase()
        {
            if let statement = getStatmentFromString(statmentString, db: db)
            {
                while (sqlite3_step(statement) == SQLITE_ROW)
                {
                    let newRent = RentClass(book: BookClass(), member: MemberClass())
                    newRent.id = getIntFrom(statement, row: RENT_DB_ID_NO)
                    newRent.book.id = getIntFrom(statement, row: RENT_DB_BOOK_ID_NO)
                    newRent.book.name = getStringFrom(statement, row: RENT_DB_BOOK_NAME_NO)
                    newRent.member.id = getIntFrom(statement, row: RENT_DB_MEMBER_ID_NO)
                    newRent.member.name = getStringFrom(statement, row: RENT_DB_MEMBER_NAME_NO)
                    newRent.rentDate = Date(timeIntervalSince1970: TimeInterval(getIntFrom(statement, row: RENT_DB_DATE_INT_NO)))
                    newRent.returnDate = Date(timeIntervalSince1970: TimeInterval(getIntFrom(statement, row: RENT_DB_DATE_RETURN_NO)))
                    newRent.isReturned =  getIntFrom(statement, row: RENT_DB_ISRETURNED_NO) == 1
                    rentList.append(newRent)
                }
                sqlite3_finalize(statement)
                
            } else {
                print("Error executing")
            }
            sqlite3_close(db)
        } else {
            print("\(statmentString) not prepared.")
        }
        
        return rentList
        
    }
    
    func getMembers( name : String) -> [MemberClass]
    {
        var members : [MemberClass] = []
        var statmentString = "select * from \(MEMBERE_DB);"
        if !name.isEmpty
        {
            statmentString = "select * from \(MEMBERE_DB) where \(MEMBERE_DB_COLUMN_NAME) like '%"+name+"%'"
        }
        
        if let db = openMemberDatabase()
        {
            if let statement = getStatmentFromString(statmentString, db: db)
            {
                while (sqlite3_step(statement) == SQLITE_ROW)
                {
                    let newMember = MemberClass()
                    newMember.id = getIntFrom(statement, row: MEMBERE_DB_ID_NO)
                    newMember.name = getStringFrom(statement, row: MEMBERE_DB_NAME_NO)
                    newMember.date = Date(timeIntervalSince1970: TimeInterval(getIntFrom(statement, row: MEMBERE_DB_DATE_INT_NO)))
                    newMember.phoneNo = getStringFrom(statement, row: MEMBERE_DB_PHONE_NO)
                    
                    members.append(newMember)
                }
                sqlite3_finalize(statement)
            }
            else {
                print("Error executing")
            }
            sqlite3_close(db)
        }
        else {
            print("\(statmentString) not prepared.")
        }
        return members
    }
    
    func getBooks( name : String) -> [BookClass]
    {
        var booksList : [BookClass] = []
        var statmentString = "select * from \(BOOK_DB);"
        if !name.isEmpty
        {
            statmentString = "select * from \(BOOK_DB) where \(BOOK_DB_COLUMN_NAME) like '%"+name+"%'"
        }
        
        if let db = openBookDatabase()
        {
            if let statement = getStatmentFromString(statmentString, db: db)
            {
                while (sqlite3_step(statement) == SQLITE_ROW)
                {
                    let newBook : BookClass = BookClass()
                    newBook.id = getIntFrom(statement, row: BOOK_DB_ID_NO)
                    newBook.name = getStringFrom(statement, row: BOOK_DB_NAME_NO)
                    newBook.year = getIntFrom(statement, row: BOOK_DB_YEAR_NO)
                    newBook.writer = getStringFrom(statement, row: BOOK_DB_WRITER_NO)
                    newBook.publisher = getStringFrom(statement, row: BOOK_DB_PUBLISHER_NO)
                    newBook.count = getIntFrom(statement, row: BOOK_DB_COUNT_NO)
                    booksList.append(newBook)
                }
                sqlite3_finalize(statement)
            }
            else {
                print("Error executing")
            }
            sqlite3_close(db)
        }
        else {
            print("\(statmentString) not prepared.")
        }
        
        return booksList
        
    }
    
}

