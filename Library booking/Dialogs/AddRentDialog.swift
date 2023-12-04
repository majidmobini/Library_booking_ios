//
//  AddRentDialog.swift
//  Library booking
//
//  Created by Majid Mobini on 11/28/23.
//

import UIKit
import SearchTextField
class AddRentDialog: UIViewController {

    @IBOutlet weak var btSave: UIButton!
    @IBOutlet weak var btCancel: UIButton!
    @IBOutlet weak var tfBookname: SearchTextField!
    @IBOutlet weak var tfMemberName: SearchTextField!
    @IBOutlet weak var tfDate: UITextField!
    @IBOutlet weak var viAll: UIView!
    
    var selectedBook : BookClass?
    var selectedMember : MemberClass?
    var rent : RentClass?
    override func viewDidLoad() {
        super.viewDidLoad()
        setUpUI()
        // Do any additional setup after loading the view.
    }
    
    init()
    {
        super.init(nibName: nil, bundle: .main)
    }
    init(rent : RentClass)
    {
        self.selectedBook = rent.book
        self.selectedMember = rent.member
        self.rent = rent
        super.init(nibName: nil, bundle: .main)
        
    }
    
    required init?(coder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }
    
    
    
    func setUpUI()
    {
        viAll.roundCorner()
        btSave.makeRoundButton()
        btCancel.roundCorner()
        
        let books = DbHelper.dbInstance.getBooks(name: "")
        var items : [SearchTextFieldItem] = []
        for book in books {
            let item = SearchTextFieldItem(title: book.name, subtitle: book.publisher)
            print(item.title)
            items.append(item)
        }
        print(books.count , " Books available")
        setUpSearchableText(textField: tfBookname, items: items)
        tfBookname.itemSelectionHandler = {[weak self] items, itemPosition in
            if let self = self
            {
                let item = items[itemPosition]
                self.tfBookname.text = item.title
                self.selectedBook = books.first(where: {$0.name == item.title && $0.publisher == item.subtitle})
            }
        }

        
        let members = DbHelper.dbInstance.getMembers(name: "")
        items.removeAll()
        for member in members {
            let item = SearchTextFieldItem(title: member.name, subtitle: member.phoneNo)
            print(item.title)
            items.append(item)
        }
        print(members.count , " members available")
        setUpSearchableText(textField: tfMemberName, items: items)
        tfMemberName.itemSelectionHandler = { [weak self] items, itemPosition in
            if let self = self
            {
                let item = items[itemPosition]
                self.tfMemberName.text = item.title
                self.selectedMember = members.first(where: {$0.name == item.title && $0.phoneNo == item.subtitle})
            }
            
        }
        tfBookname.becomeFirstResponder()
        if let rent = rent
        {
            tfBookname.text = rent.book.name
            tfMemberName.text = rent.member.name
            tfDate.text = Utils.formatDate(date: rent.rentDate)
        }
        tfDate.text = Utils.formatDate(date: Date())
    }
    
    func setUpSearchableText(textField : SearchTextField , items : [SearchTextFieldItem])
    {
        textField.filterItems(items)
        textField.comparisonOptions = [.caseInsensitive]
        textField.maxNumberOfResults = 5
        textField.startVisible = true
        //textField.minCharactersNumberToStartFiltering = 2
        // You can also limit the max height of the results list
        textField.maxResultsListHeight = 200
        
    }
    

    @IBAction func onCancel(_ sender: Any) {
        self.dismiss(animated: true)
    }
    @IBAction func onSave(_ sender: Any) {
        guard let member = selectedMember , let book = selectedBook else
        {
            return
        }
        let rent = RentClass(book: book, member: member)
        if DbHelper.dbInstance.insertRent(rent: rent)
        {
            self.dismiss(animated: true)
            NotificationCenter.default.post(name: Constants.LocalNotifications.tableReload.name(), object: nil, userInfo:nil)
        }
        else
        {
            Utils.showMessageDialog(vc: self, title: "Error", text: "Caanot rent the book")
        }
    }
    
    /*
    // MARK: - Navigation

    // In a storyboard-based application, you will often want to do a little preparation before navigation
    override func prepare(for segue: UIStoryboardSegue, sender: Any?) {
        // Get the new view controller using segue.destination.
        // Pass the selected object to the new view controller.
    }
    */

}
