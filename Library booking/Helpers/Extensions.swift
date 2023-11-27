//
//  Extensions.swift
//  Library booking
//
//  Created by Majid Mobini on 11/25/23.
//

import UIKit


extension UIButton {
    func makeRoundButton()
    {
        self.layer.cornerRadius = self.frame.height/2
        
        self.layer.shadowColor = UIColor.gray.cgColor
        self.layer.shadowOffset = CGSize(width: -2, height: 2)
        self.layer.shadowOpacity = 0.5
        self.layer.shadowPath = UIBezierPath(roundedRect: self.bounds, cornerRadius: self.layer.cornerRadius).cgPath
        self.layer.masksToBounds = false

        
    }
    
}

extension String {
    func localize () -> String
    {
        return NSLocalizedString(self, bundle: .main, comment: "")
    }
}

extension URL {

    static var documents: URL {
        return FileManager
            .default
            .urls(for: .documentDirectory, in: .userDomainMask)[0]
    }
}

extension Date {
   func getIntTimeStamp() -> Int
    {
        return (Int(self.timeIntervalSince1970))
    }
}
