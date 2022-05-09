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
    }

    override func setSelected(_ selected: Bool, animated: Bool) {
        super.setSelected(selected, animated: animated)

        // Configure the view for the selected state
    }
    
}
