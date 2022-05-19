//
//  QuestionScene.swift
//  iQuiz
//
//  Created by Christopher Ku on 5/17/22.
//

import UIKit

class QuestionScene: UIViewController {
    
    var curr_subject : String = ""
    var curr_question : Int?
    var curr_questions : [String]?
    var curr_answer_choices : [[String]]?
    var curr_answers : [String]?
    var selected_answer : String?
    
    @IBOutlet weak var questionLabel: UILabel!
    @IBOutlet weak var ansChoice1: UILabel!
    @IBOutlet weak var ansChoice2: UILabel!
    @IBOutlet weak var ansChoice3: UILabel!
    @IBOutlet weak var ansChoice4: UILabel!
    
    override func viewDidLoad() {
        super.viewDidLoad()
//         Do any additional setup after loading the view.
//        print(self.curr_subject)
//        print(self.curr_question!)
//        print(self.curr_questions!)
//        print(self.curr_answer_choices!)
//        print(self.curr_answers!)
        
        questionLabel.text = curr_questions![self.curr_question!]
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

        setupAnsOneTap()
        setupAnsTwoTap()
        setupAnsThreeTap()
        setupAnsFourTap()
    }
    
    func setupAnsOneTap() {
        let labelTap = UITapGestureRecognizer(target: self, action: #selector(ansChoiceOneTapped(_:)))
        ansChoice1.isUserInteractionEnabled = true
        ansChoice1.addGestureRecognizer(labelTap)
    }
    
    func setupAnsTwoTap() {
        let labelTap = UITapGestureRecognizer(target: self, action: #selector(ansChoiceTwoTapped(_:)))
        ansChoice2.isUserInteractionEnabled = true
        ansChoice2.addGestureRecognizer(labelTap)
    }
    
    func setupAnsThreeTap() {
        let labelTap = UITapGestureRecognizer(target: self, action: #selector(ansChoiceThreeTapped(_:)))
        ansChoice3.isUserInteractionEnabled = true
        ansChoice3.addGestureRecognizer(labelTap)
    }
    
    func setupAnsFourTap() {
        let labelTap = UITapGestureRecognizer(target: self, action: #selector(ansChoiceFourTapped(_:)))
        ansChoice4.isUserInteractionEnabled = true
        ansChoice4.addGestureRecognizer(labelTap)
    }
    
    @objc func ansChoiceOneTapped(_ sender: UITapGestureRecognizer) {
//        print("answer 1 tapped")
        ansChoice1.backgroundColor = .purple
        ansChoice2.backgroundColor = .clear
        ansChoice3.backgroundColor = .clear
        ansChoice4.backgroundColor = .clear
        selected_answer = ansChoice1.text
    }
    
    @objc func ansChoiceTwoTapped(_ sender: UITapGestureRecognizer) {
//        print("answer 2 tapped")
        ansChoice2.backgroundColor = .purple
        ansChoice1.backgroundColor = .clear
        ansChoice3.backgroundColor = .clear
        ansChoice4.backgroundColor = .clear
        selected_answer = ansChoice2.text
    }
    
    @objc func ansChoiceThreeTapped(_ sender: UITapGestureRecognizer) {
//        print("answer 3 tapped")
        ansChoice3.backgroundColor = .purple
        ansChoice1.backgroundColor = .clear
        ansChoice2.backgroundColor = .clear
        ansChoice4.backgroundColor = .clear
        selected_answer = ansChoice3.text
    }
    
    @objc func ansChoiceFourTapped(_ sender: UITapGestureRecognizer) {
//        print("answer 4 tapped")
        ansChoice4.backgroundColor = .purple
        ansChoice1.backgroundColor = .clear
        ansChoice2.backgroundColor = .clear
        ansChoice3.backgroundColor = .clear
        selected_answer = ansChoice4.text
    }

    
    @IBAction func submitBtnClick(_ sender: Any) {
        
        if selected_answer == nil {
            let selectionAlert = UIAlertController(title: "Didn't select answer", message: "Please select an answer before submitting", preferredStyle: UIAlertController.Style.alert)
            selectionAlert.addAction(UIAlertAction(title: NSLocalizedString("OK", comment: "Default action"), style: .default, handler: { _ in
            }))
            self.present(selectionAlert, animated: true, completion: nil)
        } else {
            
            if let rootVC = navigationController?.viewControllers.first as? ViewController {
                
                switch curr_subject {
                case "Maths":
                    rootVC.maths_correctness![curr_question!] = (selected_answer == curr_answers![curr_question!])
                case "Science":
                    rootVC.science_correctness![curr_question!] = (selected_answer == curr_answers![curr_question!])
                case "Marvel":
                    rootVC.marvel_correctness![curr_question!] = (selected_answer == curr_answers![curr_question!])
                default:
                    return
                }
                
                
            }
            
            let answerScene = AnswerScene()
            answerScene.title = "\(curr_subject) Answer \(curr_question! + 1)"
            answerScene.isLast = (curr_question! == curr_questions!.count - 1)
            answerScene.correct = (selected_answer == curr_answers![curr_question!])
            answerScene.curr_subject = curr_subject
            answerScene.curr_question = curr_question
            answerScene.curr_questions = curr_questions
            answerScene.curr_answer_choices = curr_answer_choices
            answerScene.curr_answers = curr_answers
            navigationController?.pushViewController(answerScene, animated: true)
        }
        
    }
    
    // MARK: - Navigation

    // In a storyboard-based application, you will often want to do a little preparation before navigation
    override func prepare(for segue: UIStoryboardSegue, sender: Any?) {
        // Get the new view controller using segue.destination.
        // Pass the selected object to the new view controller.
    }


}
