

import UIKit


class CustomButton: UIButton {
    private var action:(()->Void)?
    init(titleColor:UIColor, backgroundColor:UIColor?,action: (()->Void)?) {
        self.action = action
        super.init(frame: .zero)
        self.setTitleColor(titleColor, for: .normal)
        if let backgroundColor = backgroundColor {
            self.backgroundColor = backgroundColor}
        
        
        self.addTarget(self, action: #selector(buttonAction), for: .touchUpInside)
    }
    
    @objc func buttonAction() {
        action?()
    }
    
    required init?(coder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }

    override var isHighlighted: Bool {
        didSet {
            if (isHighlighted) {
                alpha = 0.8
            } else {
                alpha = 1
            }
        }
    }
    override var isSelected: Bool {
        didSet {
            if (isSelected) {
                alpha = 0.8
            } else {
                alpha = 1
            }
        }
    }
}
