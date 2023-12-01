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
    func showViewcontroler( _ vc : UIViewController)
    {
        vc.modalPresentationStyle = .overCurrentContext
        vc.modalTransitionStyle = .coverVertical
        self.present(vc, animated: true)
    }
    func addABook()
    {
        let vc = AddBookDialog()
        showViewcontroler(vc)
    }
    func addMember()
    {
        let vc = AddMemberDialog()
        showViewcontroler(vc)
    }
    func addRent()
    {
        let vc = AddRentDialog()
        showViewcontroler(vc)
    }
    
    override func prepare(for segue: UIStoryboardSegue, sender: Any?) {
        if let vc = segue.destination as? ListViewController
        {
            if let toGo = sender as? String
            {
                switch toGo
                {
                case Constants.MainScreenBtnName.memberList.rawValue:
                    vc.vcTitle = "Members".localize()
                    print("Goto member list")
                case Constants.MainScreenBtnName.bookList.rawValue:
                    vc.vcTitle = "Books".localize()
                    print("Goto book list")
                case Constants.MainScreenBtnName.rentedBooksList.rawValue:
                    vc.vcTitle = "Rente list".localize()
                    print("Goto rent list")
                default:
                    print("No where")
                }
            }
        }
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
            addMember()
        case .bookList:
            print("add list")
            performSegue(withIdentifier: "goToListSeg", sender: Constants.MainScreenBtnName.bookList.rawValue)
        case .createBackUp:
            print("crea back up")
        case .memberList:
            print("member list")
            performSegue(withIdentifier: "goToListSeg", sender: Constants.MainScreenBtnName.memberList.rawValue)
        case .rentBook:
            addRent()
            print("rent")
        case .rentedBooksList:
            print("ren list")
            performSegue(withIdentifier: "goToListSeg", sender: Constants.MainScreenBtnName.rentedBooksList.rawValue)
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



