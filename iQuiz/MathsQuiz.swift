//
//  MathsQuiz.swift
//  iQuiz
//
//  Created by Christopher Ku on 5/9/22.
//

import UIKit

class MathsQuiz: UIViewController {
    
    // Answer Key
    var answerKey : [String]? = nil
    
    // Question 1
    var currentChoiceOne : String = ""
    @IBOutlet weak var choicesOne: UISegmentedControl!
    @IBOutlet weak var resultOneMessage: UILabel!
    
    // Question 2
    var currentChoiceTwo: String = ""
    @IBOutlet weak var choicesTwo: UISegmentedControl!
    @IBOutlet weak var resultTwoMessage: UILabel!
    
    // Results
    @IBOutlet weak var scoreLabel: UILabel!
    @IBOutlet weak var descrLabel: UILabel!
    
    
    override func viewDidLoad() {
        super.viewDidLoad()
        // Do any additional setup after loading the view.
        if let rootVC = navigationController?.viewControllers.first as? ViewController {
            guard let answers = rootVC.subject_attributes["Maths"]!["answerKey"]! as? [String] else {
                print("Error")
                return
            }
            answerKey = answers
        }
        updateAnswerOne()
        updateAnswerTwo()
        updateResults()
    }
    
    @IBAction func getUserAnswerOne(_ sender: Any) {
        currentChoiceOne = choicesOne.titleForSegment(at: choicesOne.selectedSegmentIndex)!
    }
    
    @IBAction func submitAnsOne(_ sender: Any) {
        if let rootVC = navigationController?.viewControllers.first as? ViewController {
            currentChoiceOne = choicesOne.titleForSegment(at: choicesOne.selectedSegmentIndex)!
            rootVC.maths_correctness[0] = (currentChoiceOne == answerKey![0])
        }
    }
    
    @IBAction func getUserAnswerTwo(_ sender: Any) {
        currentChoiceTwo = choicesTwo.titleForSegment(at: choicesTwo.selectedSegmentIndex)!
    }
    
    @IBAction func submitAnsTwo(_ sender: Any) {
        if let rootVC = navigationController?.viewControllers.first as? ViewController {
            currentChoiceTwo = choicesTwo.titleForSegment(at: choicesTwo.selectedSegmentIndex)!
            rootVC.maths_correctness[1] = (currentChoiceTwo == answerKey![1])
        }
    }
    
    @IBAction func homeBtnClick(_ sender: Any) {
        navigationController?.popToRootViewController(animated: true)
    }
    
    func updateAnswerOne() {
        if resultOneMessage == nil {
            return
        } else {
            if getCorrectness(qNum: 0) {
                resultOneMessage.text = "You got it correct!"
                resultOneMessage.textColor = .systemGreen
            } else {
                resultOneMessage.text = "Incorrect! Correct answer is \(answerKey![0])"
                resultOneMessage.textColor = .systemRed
            }
        }
    }
    
    func updateAnswerTwo() {
        if resultTwoMessage == nil {
            return
        } else {
            if getCorrectness(qNum: 1) {
                resultTwoMessage.text = "You got it correct!"
                resultTwoMessage.textColor = .systemGreen
            } else {
                resultTwoMessage.text = "Incorrect! Correct answer is \(answerKey![1])"
                resultTwoMessage.textColor = .systemRed
            }
        }
    }
    
    func updateResults() {
        var numCorrect : Int = 0
        if scoreLabel == nil || descrLabel == nil {
            return
        } else {
            if let rootVC = navigationController?.viewControllers.first as? ViewController {
                numCorrect = rootVC.maths_correctness.filter{$0 == true}.count
            }
            scoreLabel.text = "Score: \(numCorrect) out of 2"
            switch numCorrect {
            case 0:
                descrLabel.text = "Try again! You can do better!"
                descrLabel.textColor = .systemRed
            case 1:
                descrLabel.text = "Almost!"
                descrLabel.textColor = .systemYellow
            case 2:
                descrLabel.text = "Perfect!"
                descrLabel.textColor = .systemGreen
            default:
                return
            }
        }
    }
    
    func getCorrectness(qNum : Int) -> Bool {
        if let rootVC = navigationController?.viewControllers.first as? ViewController {
            return rootVC.maths_correctness[qNum]
        } else {
            return false
        }
    }
    
    // MARK: - Navigation

    // In a storyboard-based application, you will often want to do a little preparation before navigation
    override func prepare(for segue: UIStoryboardSegue, sender: Any?) {
        let backItem = UIBarButtonItem()
        backItem.title = navigationItem.title
        navigationItem.backBarButtonItem = backItem
    }

}
