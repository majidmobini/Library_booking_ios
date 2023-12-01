//
//  AddMemberDialog.swift
//  Library booking
//
//  Created by Majid Mobini on 11/28/23.
//

import UIKit

class AddMemberDialog: UIViewController {

    //MARK: properties
    @IBOutlet weak var viAll: UIView!
    @IBOutlet weak var tfFullName: UITextField!
    @IBOutlet weak var tfMobileno: UITextField!
    
    @IBOutlet weak var btSave: UIButton!
    @IBOutlet weak var btCancel: UIButton!
    var member : MemberClass?
    
    //MARK: functions
    override func viewDidLoad() {
        super.viewDidLoad()

        // Do any additional setup after loading the view.
        setUpUI()
    }
    
    init() {
        super.init(nibName: nil, bundle: .main)
    }
    
    init(member : MemberClass) {
        self.member = member
        super.init(nibName: nil, bundle: .main)
        
    }
    
    required init?(coder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }
    
    
    func setUpUI()
    {
        viAll.roundCorner()
        btSave.makeRoundButton()
        btCancel.makeRoundButton()
        if let member = member
        {
            tfMobileno.text = member.phoneNo
            tfFullName.text = member.name
        }
        tfFullName.becomeFirstResponder()
    }
    
    @IBAction func onCancel(_ sender: Any) {
        self.dismiss(animated: true)
    }
    @IBAction func onSave(_ sender: Any) {
        if tfFullName.text!.isEmpty || tfMobileno.text!.isEmpty
        {
            Utils.showMessageDialog(vc: self, title: "Error", text: "Full name and Mobile no cannot be empty")
            return
        }
        if member == nil
        {
            member = MemberClass()
            member?.date = Date()
        }
        member?.name = tfFullName.text!
        member?.phoneNo = tfMobileno.text!
        
        if DbHelper.dbInstance.insertMember(member!, id: member!.id)
        {
            self.dismiss(animated: true)
        }
        else
        {
            Utils.showMessageDialog(vc: self, title: "Error", text: "Cannot inser member.")
        }
    }
    


    /*
    // MARK: - Navigation

    // In a storyboard-based application, you will often want to do a little preparation before navigation
    override func prepare(for segue: UIStoryboardSegue, sender: Any?) {
        // Get the new view controller using segue.destination.
        // Pass the selected object to the new view controller.
    }
    */

}
