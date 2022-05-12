//
//  CheckBox.swift
//  iQuiz
//
//  Created by Christopher Ku on 5/11/22.
//

import UIKit

class CheckBox: UIView {
    
    var isChecked : Bool = false
    
    override init(frame: CGRect) {
        super.init(frame: frame)
        layer.borderWidth = 0.5
        layer.borderColor = UIColor.secondaryLabel.cgColor
        layer.cornerRadius = frame.size.width / 2.0
        backgroundColor = .systemBackground
    }
    
    required init?(coder: NSCoder) {
        fatalError()
    }
    
    func setChecked(_ isChecked: Bool) {
        self.isChecked = isChecked
        if self.isChecked {
            backgroundColor = .systemBlue
        } else {
            backgroundColor = .systemBackground
        }
    }

}
