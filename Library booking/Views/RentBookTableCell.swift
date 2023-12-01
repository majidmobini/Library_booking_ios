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
