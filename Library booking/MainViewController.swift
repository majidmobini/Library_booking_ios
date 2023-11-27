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

}

extension MainViewController : UITableViewDelegate , UITableViewDataSource
{
    func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        let cell = tableView.dequeueReusableCell(withIdentifier: "mainBtnCell") as! MainScreenBtnsCell
        cell.setUpCell(row: indexPath.row)
        return cell
    }
    
    func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        Constants.MainScreenBtnName.allCases.count
    }
    func tableView(_ tableView: UITableView, heightForRowAt indexPath: IndexPath) -> CGFloat {
        return 60
    }
}

