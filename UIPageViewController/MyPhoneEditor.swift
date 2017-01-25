
class MyPhoneEditor: TKDataFormEditor, UITextFieldDelegate {
    
    let textField = MyTextField()
    
    override init(frame: CGRect) {
        super.init(frame: frame)
        textField.frame = CGRect(x: 0, y: 0, width: self.bounds.size.width, height: 31)
        textField.keyboardType = .phonePad
        textField.addTarget(self, action: #selector(MyPhoneEditor.notifyValueChange), for: .editingChanged)
        textField.delegate = self
        self.addSubview(textField)
        self.gridLayout.addDefinition(for: textField, atRow: 0, column: 2, rowSpan: 1, columnSpan: 1)
    }
    
    override init(property: TKEntityProperty) {
        super.init(property: property)
        self.setupEditor(property)
    }
    
    override init(property: TKEntityProperty, owner: TKDataForm) {
        super.init(property: property, owner: owner)
        self.setupEditor(property)
    }
    
    required init?(coder aDecoder: NSCoder) {
        super.init(coder: aDecoder)
    }
    
    override var isTextEditor: Bool {
        get {
            return true
        }
    }
    
    func setupEditor(_ property: TKEntityProperty) {
        self.textField.placeholder = self.property.hintText
        if property.valueCandidate != nil {
            self.textField.text = (property.valueCandidate as AnyObject).description
        }
        self.value = property.valueCandidate
    }
    
    override var editor: UIView {
        get {
            return textField
        }
    }
    
    override func updateControlValue() {
        textField.text = (self.description as AnyObject).description
    }
    
    override func update() {
        super.update()
        textField.isEnabled = self.enabled == false ? self.enabled : !self.property.readOnly
    }
    
    func notifyValueChange() {
        self.formatText()
        self.value = textField.text
        self.owner.editorValueChanged(self)
    }
    
    func formatText() {
        let text: NSMutableString = NSMutableString(string: textField.text!)
        if text.length == 0 {
            return
        }
        let last: String = text.substring(from: text.length - 1)
        if text.length == 5 {
            if (last == " ") {
                text.deleteCharacters(in: NSMakeRange(text.length - 1, 1))
            }
            else {
                text.insert(" ", at: 4)
            }
        }
        else if text.length == 9 {
            if (last == " ") {
                text.deleteCharacters(in: NSMakeRange(text.length - 1, 1))
            }
            else {
                text.insert(" ", at: 8)
            }
        }
        else if text.length > 12 {
            text.deleteCharacters(in: NSMakeRange(text.length - 1, 1))
        }
        
        self.textField.text = text as String
    }
    
    func textFieldShouldReturn(_ textField: UITextField) -> Bool {
        textField.resignFirstResponder()
        return false
    }
    
    func textFieldShouldBeginEditing(_ textField: UITextField) -> Bool {
        self.owner.setEditorOnFocus(self)
        return true
    }

}

class MyTextField: UITextField {
    
    let padding = UIEdgeInsets(top: 0, left: 10, bottom: 0, right: 0);
    
    override func textRect(forBounds bounds: CGRect) -> CGRect {
        return UIEdgeInsetsInsetRect(bounds, padding)
    }
    
    override func placeholderRect(forBounds bounds: CGRect) -> CGRect {
        return UIEdgeInsetsInsetRect(bounds, padding)
    }
    
    override func editingRect(forBounds bounds: CGRect) -> CGRect {
        return UIEdgeInsetsInsetRect(bounds, padding)
    }
}
