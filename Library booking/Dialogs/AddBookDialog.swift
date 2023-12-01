//
//  AddBookDialog.swift
//  Library booking
//
//  Created by Majid Mobini on 11/27/23.
//

import UIKit

class AddBookDialog: UIViewController {
    //MARK: properties
    
    @IBOutlet weak var viAll: UIView!
    @IBOutlet weak var btSave: UIButton!
    @IBOutlet weak var btCancel: UIButton!
    @IBOutlet weak var tfCount: UITextField!
    @IBOutlet weak var tfYear: UITextField!
    @IBOutlet weak var tfPublisher: UITextField!
    @IBOutlet weak var tfWriter: UITextField!
    @IBOutlet weak var tfName: UITextField!
    @IBOutlet weak var lbTitle: UILabel!
    
    
    var book : BookClass?
    override func viewDidLoad() {
        super.viewDidLoad()
        setupUI()
        // Do any additional setup after loading the view.
       
    }
    
    func setupUI()
    {
        btSave.makeRoundButton()
        btCancel.makeRoundButton()
        viAll.roundCorner()
        if let book = book
        {
            tfName.text = book.name
            tfYear.text = "\(book.year)"
            tfCount.text = "\(book.count)"
            tfWriter.text = book.writer
            tfPublisher.text = book.publisher
        }
        tfName.becomeFirstResponder()
    }
    init()
    {
        super.init(nibName: nil, bundle: .main)
    }
    init(book : BookClass)
    {
        self.book = book
        super.init(nibName: nil, bundle: .main)
        
    }
    
    required init?(coder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }
    
    @IBAction func onCancel(_ sender: Any) {
        self.dismiss(animated: true)
    }
    @IBAction func onSave(_ sender: Any) {
        if book == nil
        {
            book = BookClass()
        }
        book!.name = tfName.text!
        book!.year = Int(tfYear.text!) ?? 0
        book!.writer = tfWriter.text!
        book!.publisher = tfPublisher.text!
        book!.count = Int(tfCount.text!) ?? 1
        if book!.year == 0
        {
            print("Please enter year")
        }
        if !DbHelper.dbInstance.insertBook(book!,id: book!.id)
        {
            Utils.showMessageDialog(vc: self, title: "Error", text: "Cannot add the book")
        }
        else
        {
            self.dismiss(animated: true)
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
