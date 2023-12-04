//
//  ListViewController.swift
//  Library booking
//
//  Created by Majid Mobini on 11/30/23.
//

import UIKit

protocol ListViewControllerDelegate : AnyObject {
    func onRowClicked( vc : UIViewController , item : Any , index : Int)
}

class ListViewController: UIViewController  {
    
    var vcTitle : String!
    var allItems : [Any]!
    var showingItems : [Any]! = []
    var cellIdentifier : Constants.ListTableCellName!
    var rowHeight : CGFloat!
    weak var delegate : ListViewControllerDelegate!
    
    
    @IBOutlet weak var nsTableViewDistancsFromTop: NSLayoutConstraint!
    @IBOutlet weak var uiSegmentSelctor: UISegmentedControl!
    @IBOutlet weak var uiSearchBar: UISearchBar!
    @IBOutlet weak var tableView: UITableView!
    
    override func viewDidLoad() {
        super.viewDidLoad()
        //tableView.tableFooterView = UIView()
        
        NotificationCenter.default.addObserver(self, selector: #selector(reloadData(_:)), name:Constants.LocalNotifications.tableReload.name() , object: nil)
        
        
     // Do any additional setup after loading the view.
    }
    
    override func viewWillAppear(_ animated: Bool) {
        super.viewWillAppear(animated)
        self.navigationItem.title = vcTitle
        fillItems()
        applySearching(text: "")
        
    }
    
    deinit {
        NotificationCenter.default.removeObserver(self)
        print("List view deinited")
    }
    
    @objc func reloadData(_ notification: Notification) {
        fillItems()
        applySearching(text: uiSearchBar.text!)
    }
    
    @IBAction func onSegmentChanged(_ sender: UISegmentedControl) {
        fillItems()
        applySearching(text: uiSearchBar.text!)
    }
    func customInit(vcTitle: String!, cellIdentifier: Constants.ListTableCellName!, rowHeight: CGFloat! ) {
        self.vcTitle = vcTitle
        self.cellIdentifier = cellIdentifier
        self.rowHeight = rowHeight
        
   
    }
    
    func fillItems()
    {
        switch cellIdentifier
        {
        case .bookListCell:
            allItems = DbHelper.dbInstance.getBooks(name: "")
            nsTableViewDistancsFromTop.constant = 0
            uiSegmentSelctor.isHidden = true
        case .renListCell:
            allItems = DbHelper.dbInstance.getRents(name: "", isReturned: uiSegmentSelctor.selectedSegmentIndex)
            nsTableViewDistancsFromTop.constant = 40
            uiSegmentSelctor.isHidden = false
        case .memberListCell:
            allItems = DbHelper.dbInstance.getMembers(name: "")
            nsTableViewDistancsFromTop.constant = 0
            uiSegmentSelctor.isHidden = true
        case .none:
            print("Do nothing")
        }
    }
    

    @IBAction func back(_ sender: UIBarButtonItem) {
        self.dismiss(animated: true, completion: nil)
    }
    
    
    func applySearching(text : String)
    {
        showingItems.removeAll()
        if text.isEmpty
        {
            showingItems.append(contentsOf: allItems)
            tableView.reloadData()
            return
        }
        switch cellIdentifier
        {
        case .bookListCell:
           showingItems = allItems.filter({($0 as! BookClass).name.lowercased().contains(text.lowercased()) ||
                ($0 as! BookClass).writer.lowercased().contains(text.lowercased()) ||
                ($0 as! BookClass).publisher.lowercased().contains(text.lowercased())
            })
        case .renListCell:
            showingItems = allItems.filter({($0 as! RentClass).book.name.lowercased().contains(text.lowercased()) ||
                ($0 as! RentClass).member.name.lowercased().contains(text.lowercased())
             })
        case .memberListCell:
            showingItems = allItems.filter({($0 as! MemberClass).name.lowercased().contains(text.lowercased()) ||
                ($0 as! MemberClass).phoneNo.lowercased().contains(text.lowercased())
             })
        case .none:
            print("Do nothing")
        }
        tableView.reloadData()
    }
}

extension ListViewController : UISearchBarDelegate {
    func searchBar(_ searchBar: UISearchBar, textDidChange searchText: String) {
        applySearching(text: searchText)
    }
}

extension ListViewController : UITableViewDelegate , UITableViewDataSource
{
    func tableView(_ tableView: UITableView, heightForRowAt indexPath: IndexPath) -> CGFloat {
       return rowHeight
    }
    func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        let cell = tableView.dequeueReusableCell(withIdentifier: cellIdentifier.rawValue)
        let item = showingItems[indexPath.row]
        switch cellIdentifier
        {
            case .bookListCell:
                (cell as! BookListTableCell).setUp(item: item as! BookClass, row: indexPath.row)
                
            case .renListCell:
                (cell as! RentBookTableCell).setUp(item: item as! RentClass, row: indexPath.row)
            case .memberListCell:
                (cell as! MemberListTableCell).setUp(item: item as! MemberClass, row: indexPath.row)
            case .none:
                print("Do nothing")
        }
        
        return cell!
        
    }
    func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        
        return showingItems.count
    }
//    func tableView(_ tableView: UITableView, didSelectRowAt indexPath: IndexPath) {
//        let item = showingItems[indexPath.row]
//        delegate.onRowClicked(vc: self, item: item, index: indexPath.row)
//    }
}




