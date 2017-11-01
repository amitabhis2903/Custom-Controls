//
//  LoginField.swift
//  Custom Controls
//
//  Created by Ammy Pandey on 25/08/17.
//  Copyright © 2017 Ammy Pandey. All rights reserved.
//

import UIKit

enum FieldType
{
    case Email
    case Password
}

@IBDesignable

class LoginField: UIView, UITextFieldDelegate
{

    //Mark: Properties to hold field type
     @IBInspectable var type: FieldType = .Email
    @IBInspectable var useForEmail: Bool = true
    
    private let topLbl: UILabel = UILabel()
    private let inputTextField: UITextField = UITextField()
    private let bottomlineView: UIView = UIView()
    
    //Mark: Intializer
    //Mark: It's first set the field type before setting the frame intializer
    init(frame: CGRect, type: FieldType)
    {
        self.type = type
        super.init(frame: frame)
        self.setupControls()
    }
    
    override init(frame: CGRect)
    {
        super.init(frame: frame)
        self.setupControls()
    }
    
    required init?(coder aDecoder: NSCoder)
    {
        super.init(coder: aDecoder)
        self.setupControls()
    }
    
    override func awakeFromNib()
    {
        super.awakeFromNib()
        self.type = self.useForEmail ? .Email : .Password
        self.setupControls()
    }
    
    
    // Mark: UI Methods
    
    private func setupControls()
    {
        //Mark: Setting Attributes for Label
        self.addSubview(self.topLbl)
        self.topLbl.frame = CGRect(x: 0, y: self.bounds.height / 2, width: self.bounds.width, height: 20)
        self.topLbl.alpha = 0
        self.topLbl.text = self.type == .Email ? "Email" : "Password"
        self.topLbl.textAlignment = .left
        self.topLbl.textColor = UIColor.blue
        self.topLbl.font =  UIFont.systemFont(ofSize: 12)
        
        //Mark: Setting attributes for UIView
        self.addSubview(bottomlineView)
        self.bottomlineView.backgroundColor = UIColor.lightGray
        self.bottomlineView.frame = CGRect(x: 0, y: self.bounds.height, width: self.bounds.width, height: 1)
        
        //Mark: Setting attributes for UITextField
        self.addSubview(inputTextField)
        self.inputTextField.delegate = self
        self.inputTextField.placeholder = self.type == .Email ? "Email" : "Password"
        self.inputTextField.isSecureTextEntry = self.type == .Password
        self.inputTextField.textAlignment = .left
        self.inputTextField.frame = CGRect(x: 0, y: 19, width: self.bounds.width, height: 20)
        
        self.inputTextField.addTarget(self, action: #selector(LoginField.chechkTopLabel(sender:)), for: .editingChanged)
        
    }
    
    // Mark: UITextFieldDelegate
    func textFieldDidBeginEditing(_ textField: UITextField)
    {
        if (textField.text?.characters.count)! > 0
        {
            self.topLbl.textColor = UIColor.blue
        }
    }
    
    func textFieldDidEndEditing(_ textField: UITextField)
    {
        if (textField.text?.characters.count)! > 0
        {
            self.topLbl.textColor = UIColor.lightGray
        }
        else
        {
            UIView.animate(withDuration: 0.25, animations: { 
                self.topLbl.alpha = 0
            }, completion: { done in
                self.topLbl.textColor = UIColor.blue
                self.topLbl.frame = CGRect(x: 0, y: self.bounds.height / 2, width: self.bounds.width, height: 1)
            })
        }
    }
    
    func textFieldShouldReturn(_ textField: UITextField) -> Bool {
        self.inputTextField.endEditing(true)
        return false
    }
    
    func chechkTopLabel (sender: UITextField!)
    {
       guard (sender.text?.characters.count)! > 0 else
       {
        return
        }
        
        UIView.animate(withDuration: 0.5) { 
            self.topLbl.alpha = 1
            self.topLbl.frame = CGRect(x: 0, y: 2, width: self.bounds.width, height: 20)
        }
        
    }
    
    
    
}
