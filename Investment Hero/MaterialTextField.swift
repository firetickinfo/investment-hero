import UIKit

class MaterialTextField: UITextField {
    override func awakeFromNib() {
        layer.cornerRadius = 2.0
        layer.borderColor = UIColor(red: SHADOW_COLOUR, green: SHADOW_COLOUR, blue: SHADOW_COLOUR, alpha: 0.1).cgColor
        layer.borderWidth = 1.0
    }
    
    override func textRect(forBounds bounds: CGRect) -> CGRect {
        //Shift text by 10 to the right (to not have text right at the edge)
        return bounds.insetBy(dx: 10, dy: 0)
    }
    override func editingRect(forBounds bounds: CGRect) -> CGRect {
        //Same this as above but for editing...
        return bounds.insetBy(dx: 10, dy: 0)
    }
}
