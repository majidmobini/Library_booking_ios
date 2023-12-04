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
    
    var book : BookClass!
    var row : Int!
    override func awakeFromNib() {
        super.awakeFromNib()
        // Initialization code
        viRow.roundCorner()
    }
    
    
    override func setSelected(_ selected: Bool, animated: Bool) {
        super.setSelected(selected, animated: animated)

        // Configure the view for the selected state
    }
    
    func setUp(item : BookClass , row : Int)
    {
        book = item
        lbCount.text = "\(item.count)"
        lbYear.text =  "\(item.year)"
        lbPublisher.text = item.publisher
        lbWriterName.text = item.writer
        lbBookName.text = item.name
        self.row = row
        
    }
    
  

    @IBAction func onMore(_ sender: Any) {
        if let topVc = Utils.getTopViewController() , let book = book
        {
            let alert = UIAlertController(title: nil, message: nil, preferredStyle: .actionSheet)
            alert.addAction(UIAlertAction(title: "Edit".localize(), style: .default , handler: { ac in
                let vc = AddBookDialog(book: book)
                vc.modalPresentationStyle = .overCurrentContext
                vc.modalTransitionStyle = .coverVertical
                topVc.present(vc, animated: true)

            }))
            alert.addAction(UIAlertAction(title: "Status".localize(), style: .default , handler: { ac in
                
                let count = DbHelper.dbInstance.getRentedBookCount(book.id)
                if count == 0
                {
                    Utils.showMessageDialog(vc: topVc, title: "", text: "No book is available".localize())
                }
                else
                {
                    Utils.showMessageDialog(vc: topVc, title: "", text: "\(count) \(count == 1 ? "book is" : "books are") available.")
                }
            }))
            alert.addAction(UIAlertAction(title: "Delete", style: .default , handler: { ac in
                Utils.showYesNoDialog(vc: topVc, title: "Warning", text: "Do you want to delete this book?") { alert in
                    _ = DbHelper.dbInstance.deleteBookWithId(book.id)
                    NotificationCenter.default.post(name: Constants.LocalNotifications.tableReload.name(), object: nil, userInfo:nil)
                }
            }))
            
            alert.addAction(UIAlertAction(title: "Cancel", style: .default))
            
            alert.fixIpad(view: topVc.view)
            topVc.present(alert, animated: true)
        }
    }
}

//extension BookListTableCell : ListViewControllerDelegate {
//    func onRowClicked(vc: UIViewController, item: Any, index: Int) {
//        if let book = item as? BookClass
//        {
//            print(book.name)
//        }
//    }
//}

