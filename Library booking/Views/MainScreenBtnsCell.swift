//
//  MainScreenBtns.swift
//  Library booking
//
//  Created by Majid Mobini on 11/25/23.
//

import UIKit

protocol MainScreenBtnsCellDelegate : AnyObject  {
    func btnPressed(btn : UIButton )
}

class MainScreenBtnsCell: UITableViewCell {

    //Mark : variables
    @IBOutlet weak var btn: UIButton!
    
    weak var delegate : MainScreenBtnsCellDelegate?
    
    override func awakeFromNib() {
        super.awakeFromNib()
        btn.makeRoundButton()
               
        //Initialization code
    }

    @IBAction func onTounchCancel(_ sender: Any) {
        btn.backgroundColor = UIColor.init(named: "ButtonBackgroung")
    }
    @IBAction func onTouchDown(_ sender: Any) {
        btn.backgroundColor = UIColor(named: "PrimaryDark")
    }
    @IBAction func onBtnPressed(_ sender: UIButton) {
        btn.backgroundColor = UIColor.init(named: "ButtonBackgroung")
        if let delegate = delegate
        {
            delegate.btnPressed(btn: sender)
        }
    }
   
    func setUpCell(row : Int)
    {
        btn.setTitle(Constants.MainScreenBtnName.allCases[row].rawValue, for: .normal)
    }
    
}
