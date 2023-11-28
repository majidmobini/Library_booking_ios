//
//  ViewController.swift
//  Library booking
//
//  Created by Majid Mobini on 11/25/23.
//

import UIKit

class MainViewController: UIViewController {

    @IBOutlet weak var tableBtns: UITableView!
    override func viewDidLoad() {
        super.viewDidLoad()
        tableBtns.tableFooterView = UIView()
        // Do any additional setup after loading the view.
    }
    
    func addABook()
    {
        let vc = AddBookDialog()
        vc.modalPresentationStyle = .overCurrentContext
        vc.modalTransitionStyle = .coverVertical
        self.present(vc, animated: true)
        
    }

}
//MARK: table delegates
extension MainViewController : UITableViewDelegate , UITableViewDataSource , MainScreenBtnsCellDelegate
{
    func btnPressed(btn: UIButton) {
        switch Constants.MainScreenBtnName(rawValue: btn.currentTitle!)
        {
        case .addBook:
            print("add book")
            addABook()
        case .addMember:
            print("add member")
        case .bookList:
            print("add list")
        case .createBackUp:
            print("crea back up")
        case .memberList:
            print("member list")
        case .rentBook:
            print("rent")
        case .rentedBooksList:
            print("ren list")
        case .restoreBackUp:
            print("restore")
        case .none:
            print("none")
        }
    }
    
    func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        let cell = tableView.dequeueReusableCell(withIdentifier: "mainBtnCell") as! MainScreenBtnsCell
        cell.setUpCell(row: indexPath.row)
        cell.delegate = self
        return cell
    }
    
    func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        Constants.MainScreenBtnName.allCases.count
    }
    func tableView(_ tableView: UITableView, heightForRowAt indexPath: IndexPath) -> CGFloat {
        return 60
    }
    
    
}



