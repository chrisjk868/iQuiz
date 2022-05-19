//
//  AnswerScene.swift
//  iQuiz
//
//  Created by Christopher Ku on 5/17/22.
//

import UIKit

class AnswerScene: UIViewController {
    
    var isLast : Bool?
    var correct : Bool?
    var curr_subject : String = ""
    var curr_question : Int?
    var curr_questions : [String]?
    var curr_answer_choices : [[String]]?
    var curr_answers : [String]?
    
    @IBOutlet weak var descriptor: UILabel!
    @IBOutlet weak var resultLabel: UILabel!
    @IBOutlet weak var questionLabel: UILabel!
    @IBOutlet weak var ansChoice1: UILabel!
    @IBOutlet weak var ansChoice2: UILabel!
    @IBOutlet weak var ansChoice3: UILabel!
    @IBOutlet weak var ansChoice4: UILabel!
    
    override func viewDidLoad() {
        super.viewDidLoad()
        // Do any additional setup after loading the view.
        
        ansChoice1.text = curr_answer_choices![curr_question!][0]
        ansChoice2.text = curr_answer_choices![curr_question!][1]
        ansChoice3.text = curr_answer_choices![curr_question!][2]
        ansChoice4.text = curr_answer_choices![curr_question!][3]
        
        ansChoice1.layer.borderColor = UIColor.darkGray.cgColor
        ansChoice1.layer.borderWidth = 3.0
        ansChoice2.layer.borderColor = UIColor.darkGray.cgColor
        ansChoice2.layer.borderWidth = 3.0
        ansChoice3.layer.borderColor = UIColor.darkGray.cgColor
        ansChoice3.layer.borderWidth = 3.0
        ansChoice4.layer.borderColor = UIColor.darkGray.cgColor
        ansChoice4.layer.borderWidth = 3.0
        
        descriptor.isHidden = true
        let correct_index = curr_answer_choices![curr_question!].firstIndex(of: curr_answers![curr_question!])
        
        if correct! {
            resultLabel.text = "Correct!"
            resultLabel.textColor = .systemGreen
        } else {
            descriptor.isHidden = false
            resultLabel.text = "Incorrect"
            resultLabel.textColor = .systemRed
            descriptor.text = "Correct answer is option \(correct_index! + 1)"
        }
        
        switch correct_index {
        case 0:
            ansChoice1.backgroundColor = .systemGreen
        case 1:
            ansChoice2.backgroundColor = .systemGreen
        case 2:
            ansChoice3.backgroundColor = .systemGreen
        case 3:
            ansChoice4.backgroundColor = .systemGreen
        default:
            return
        }
        
    }

    @IBAction func nextBtnClick(_ sender: Any) {
        
        if isLast! {
            let resultScene = ResultScene()
            resultScene.curr_subject = self.curr_subject
            resultScene.num_questions = self.curr_questions!.count
            navigationController?.pushViewController(resultScene, animated: true)
        } else {
            let questionScene = QuestionScene()
            self.curr_question! += 1
            questionScene.curr_subject = self.curr_subject
            questionScene.curr_question = self.curr_question!
            questionScene.curr_questions = self.curr_questions!
            questionScene.curr_answer_choices = self.curr_answer_choices!
            questionScene.curr_answers = self.curr_answers!
            navigationController?.pushViewController(questionScene, animated: true)
        }
        
    }
    
    // MARK: - Navigation

    // In a storyboard-based application, you will often want to do a little preparation before navigation
    override func prepare(for segue: UIStoryboardSegue, sender: Any?) {
        // Get the new view controller using segue.destination.
        // Pass the selected object to the new view controller.
    }

}
