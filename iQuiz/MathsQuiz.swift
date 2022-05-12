//
//  MathsQuiz.swift
//  iQuiz
//
//  Created by Christopher Ku on 5/9/22.
//

import UIKit

class MathsQuiz: UIViewController {
    
    var answerKey : [String]? = nil
    
    // Question 1
    var currentChoiceOne : String = ""
    @IBOutlet weak var choicesOne: UISegmentedControl!
    var resultOne : Bool? = nil
    @IBOutlet weak var resultOneMessage: UILabel!
    
    // Question 2
    
    override func viewDidLoad() {
        super.viewDidLoad()
        // Do any additional setup after loading the view.
        print(resultOneMessage)
        if let rootVC = navigationController?.viewControllers.first as? ViewController {
            guard let answers = rootVC.subject_attributes["Maths"]!["answerKey"]! as? [String] else {
                print("Error")
                return
            }
            answerKey = answers
        }
    }
    
    @IBAction func homeBtnClick(_ sender: Any) {
        navigationController?.popToRootViewController(animated: true)
    }
    
    @IBAction func getUserAnswerOne(_ sender: Any) {
        currentChoiceOne = choicesOne.titleForSegment(at: choicesOne.selectedSegmentIndex)!
    }
    
    @IBAction func submitAnsOne(_ sender: Any) {
        resultOne = currentChoiceOne == answerKey![0]
        if resultOne! {
//            resultOneMessage.text = "You got it correct!"
//            resultOneMessage.textColor = .systemGreen
        } else {
//            resultOneMessage.text = "Incorrect! Correct answer is \(answerKey![0])"
//            resultOneMessage.textColor = .systemRed
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
