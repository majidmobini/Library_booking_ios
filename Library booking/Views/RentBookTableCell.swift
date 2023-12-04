//
//  RentBookTableCell.swift
//  Library booking
//
//  Created by Majid Mobini on 11/30/23.
//

import UIKit

class RentBookTableCell: UITableViewCell {

    @IBOutlet weak var lbDate: UILabel!
    @IBOutlet weak var lbMember: UILabel!
    @IBOutlet weak var viRow: UIView!
    @IBOutlet weak var lbBookName: UILabel!
    @IBOutlet weak var imMore: UIImageView!
    @IBOutlet weak var btnMore: UIButton!
    
    var row : Int!
    var rent : RentClass?
    override func awakeFromNib() {
        super.awakeFromNib()
        viRow.roundCorner()
        // Initialization code
    }

    override func setSelected(_ selected: Bool, animated: Bool) {
        super.setSelected(selected, animated: animated)

        // Configure the view for the selected state
    }
    
    func setUp(item : RentClass , row : Int)
    {
        lbDate.text = Utils.formatDate(date: item.rentDate)
        lbMember.text = item.member.name
        lbBookName.text = item.book.name
        self.rent = item
        self.row = row
        imMore.isHidden = item.isReturned
        btnMore.isHidden = item.isReturned
        
    }
    
   

    @IBAction func onMore(_ sender: Any) {
        if let topVc = Utils.getTopViewController() , let rent = rent
        {
            let alert = UIAlertController(title: nil, message: nil, preferredStyle: .actionSheet)
            alert.addAction(UIAlertAction(title: "Edit".localize(), style: .default , handler: { ac in
                let vc = AddRentDialog(rent: rent)
                vc.modalPresentationStyle = .overCurrentContext
                vc.modalTransitionStyle = .coverVertical
                topVc.present(vc, animated: true)

            }))
            alert.addAction(UIAlertAction(title: "Book returned".localize(), style: .default , handler: { ac in
                
                _ = DbHelper.dbInstance.rentReturned(rent)
                NotificationCenter.default.post(name: Constants.LocalNotifications.tableReload.name(), object: nil, userInfo:nil)
            }))
            alert.addAction(UIAlertAction(title: "Delete", style: .default , handler: { ac in
                Utils.showYesNoDialog(vc: topVc, title: "Warning", text: "Do you want to delete this item?") { alert in
                    _ = DbHelper.dbInstance.deleteRent(rent)
                    NotificationCenter.default.post(name: Constants.LocalNotifications.tableReload.name(), object: nil, userInfo:nil)
                }
            }))
            
            alert.addAction(UIAlertAction(title: "Cancel", style: .default))
            
            alert.fixIpad(view: topVc.view)
            topVc.present(alert, animated: true)
        }
    }
}

extension RentBookTableCell : ListViewControllerDelegate {
    func onRowClicked(vc: UIViewController, item: Any, index: Int) {
        if let rent = item as? RentClass
        {
            print(rent.book.name)
        }
    }
}
