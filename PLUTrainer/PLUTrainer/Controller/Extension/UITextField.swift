//
//  UITextField.swift
//  PLUTrainer
//
//  Created by Cao Mai on 7/13/20.
//  Copyright © 2020 Mondale. All rights reserved.
//

import UIKit.UITextField

///https://stackoverflow.com/questions/1347779/how-to-navigate-through-textfields-next-done-buttons
extension UITextField { // Gives you done button when end of textfields, otherwise get next button to move to next UItextfield, (form entry helper)
    class func connectFields(fields:[UITextField]) -> Void {
        guard let last = fields.last else {
            return
        }
        for i in 0 ..< fields.count - 1 {
            fields[i].returnKeyType = .next
            fields[i].addTarget(fields[i+1], action: #selector(self.becomeFirstResponder), for: .editingDidEndOnExit)
        }
        last.returnKeyType = .done
        last.addTarget(last, action: #selector(UIResponder.resignFirstResponder), for: .editingDidEndOnExit)
    }
}
