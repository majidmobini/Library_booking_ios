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
    override func awakeFromNib() {
        super.awakeFromNib()
        // Initialization code
    }

    override func setSelected(_ selected: Bool, animated: Bool) {
        super.setSelected(selected, animated: animated)

        // Configure the view for the selected state
    }

    @IBAction func onMore(_ sender: Any) {
    }
}
