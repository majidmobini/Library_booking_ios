//
//  BookListTableCell.swift
//  Library booking
//
//  Created by Majid Mobini on 11/30/23.
//

import UIKit

class BookListTableCell: UITableViewCell {

    @IBOutlet weak var lbCount: UILabel!
    @IBOutlet weak var lbYear: UILabel!
    @IBOutlet weak var lbPublisher: UILabel!
    @IBOutlet weak var lbWriterName: UILabel!
    @IBOutlet weak var lbBookName: UILabel!
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
