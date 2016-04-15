//
//  PhoneFormatEditor.swift
//  UIPageViewController
//
//  Created by andy synotive on 8/04/2016.
//  Copyright © 2016 Vea Software. All rights reserved.
//

import Foundation

class MyPhoneEditor: TKDataFormPhoneEditor {

override init(frame: CGRect) {
    self.init(frame: frame)
    if self != nil {
        self.textField = TKTextField(frame: CGRectMake(0, 0, self.bounds.size.width, 31))
        self.textField.keyboardType = .PhonePad
        textField.addTarget(self, action: "notifyValueChange", forControlEvents: .EditingChanged)
        self.textField.delegate = self
        self.addSubview(textField)
        self.gridLayout.addDefinitionForView(textField, atRow: 0, column: 2, rowSpan: 1, columnSpan: 1)
    }
}

override init(property: TKEntityProperty) {
    self.init(property: property)
    if self != nil {
        self.upEditor = property
    }
}

override init(property: TKEntityProperty, owner: TKDataForm) {
    self.init(property: property, owner: owner)
    if self != nil {
        self.upEditor = property
    }
}

func isTextEditor() -> Bool {
    return true
}

func setupEditor(property: TKEntityProperty) {
    self.textField.placeholder = self.property.hintText
    if property.valueCandidate && !(property.valueCandidate is NSNull.self) {
        self.textField.text = property.valueCandidate.description
    }
    self.value = property.valueCandidate
}

func editor() -> UIView {
    return textField
}

func updateControlValue() {
    self.textField.text = self.value.description
}

func update() {
    super.update()
    self.textField.enabled = !self.enabled ? self.enabled : !self.property.readOnly
}

func notifyValueChange() {
    self.formatText()
    self.value = textField.text!
    self.owner.editorValueChanged(self)
}

func formatText() {
    var text: NSMutableString = NSMutableString.stringWithString(textField.text!)
    if text.length == 0 {
        return
    }
    var last: String = text.substringFromIndex(text.length - 1)
    if text.length == 5 {
        if (last == " ") {
            text.deleteCharactersInRange(NSMakeRange(text.length - 1, 1))
        }
        else {
            text.insertString(" ", atIndex: 4)
        }
    }
    else if text.length == 9 {
        if (last == " ") {
            text.deleteCharactersInRange(NSMakeRange(text.length - 1, 1))
        }
        else {
            text.insertString(" ", atIndex: 8)
        }
    }
    else if text.length > 12 {
        text.deleteCharactersInRange(NSMakeRange(text.length - 1, 1))
    }
    
    self.textField.text = text
}

override func textFieldShouldReturn(textField: UITextField) -> Bool {
    textField.resignFirstResponder()
    return false
}

func textFieldShouldBeginEditing(textField: UITextField) -> Bool {
    self.owner.editorOnFocus = self
    return true
}

}