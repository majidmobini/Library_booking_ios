//
//  MemberListTableCell.swift
//  Library booking
//
//  Created by Majid Mobini on 11/30/23.
//

import UIKit

class MemberListTableCell: UITableViewCell {

    @IBOutlet weak var lbPhone: UILabel!
    @IBOutlet weak var lbName: UILabel!
    @IBOutlet weak var viRow: UIView!
    
    var member : MemberClass?
    var row : Int!
    override func awakeFromNib() {
        super.awakeFromNib()
        viRow.roundCorner()
        // Initialization code
    }

    override func setSelected(_ selected: Bool, animated: Bool) {
        super.setSelected(selected, animated: animated)

        // Configure the view for the selected state
    }
   
    func setUp(item : MemberClass , row : Int)
    {
        lbName.text = item.name
        lbPhone.text = item.phoneNo
        self.member = item
        self.row = row
    }
    
    

    @IBAction func onMore(_ sender: Any) {
        if let topVc = Utils.getTopViewController() , let member = member
        {
            let alert = UIAlertController(title: nil, message: nil, preferredStyle: .actionSheet)
            alert.addAction(UIAlertAction(title: "Edit".localize(), style: .default , handler: { ac in
                let vc = AddMemberDialog(member: member)
                vc.modalPresentationStyle = .overCurrentContext
                vc.modalTransitionStyle = .coverVertical
                topVc.present(vc, animated: true)

            }))

            alert.addAction(UIAlertAction(title: "Delete", style: .default , handler: { ac in
                Utils.showYesNoDialog(vc: topVc, title: "Warning", text: "Do you want to delete this member?") { alert in
                    _ = DbHelper.dbInstance.deleteMemberWithId(member.id    )
                    NotificationCenter.default.post(name: Constants.LocalNotifications.tableReload.name(), object: nil, userInfo: nil)
                }
            }))
            
            alert.addAction(UIAlertAction(title: "Cancel", style: .default))
            
            alert.fixIpad(view: topVc.view)
            topVc.present(alert, animated: true)
        }
    }
}

extension MemberListTableCell : ListViewControllerDelegate {
    func onRowClicked(vc: UIViewController, item: Any, index: Int) {
        if let member = item as? MemberClass
        {
            print(member.name)
        }
    }
}
