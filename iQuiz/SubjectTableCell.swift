//
//  SubjectTableCell.swift
//  iQuiz
//
//  Created by Christopher Ku on 5/8/22.
//

import UIKit

class SubjectTableCell: UITableViewCell {
    
    @IBOutlet var subjectLabel: UILabel!
    @IBOutlet var subjectImage: UIImageView!
    @IBOutlet var subjectDesc: UILabel!

    override func awakeFromNib() {
        super.awakeFromNib()
        // Initialization code
        subjectImage.layer.borderWidth = 1
        subjectImage.layer.masksToBounds = false
        subjectImage.layer.borderColor = UIColor.gray.cgColor
        subjectImage.layer.cornerRadius = subjectImage.frame.height / 2
        subjectImage.clipsToBounds = true
    }

    override func setSelected(_ selected: Bool, animated: Bool) {
        super.setSelected(selected, animated: animated)
        // Configure the view for the selected state
        
    }
    
}
