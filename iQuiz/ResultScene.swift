//
//  ResultScene.swift
//  iQuiz
//
//  Created by Christopher Ku on 5/17/22.
//

import UIKit

class ResultScene: UIViewController {

    var curr_subject : String  =  ""
    var num_questions : Int?
    
    @IBOutlet weak var scoreLabel: UILabel!
    @IBOutlet weak var scoreDescriptor: UILabel!
    
    
    override func viewDidLoad() {
        super.viewDidLoad()
        
        // Do any additional setup after loading the view.

        switch curr_subject {
        case "Maths":
            var numCorrect = 0
            if let rootVC = navigationController?.viewControllers.first as? ViewController {
                numCorrect = rootVC.maths_correctness!.filter{$0 == true}.count
            }
            scoreLabel.text = "Score: \(numCorrect) out of \(num_questions!)"
            if numCorrect / num_questions! == 1 {
                scoreDescriptor.text = "Well done! You got it all correct!"
                scoreDescriptor.textColor = .systemGreen
            } else {
                scoreDescriptor.text = "You can do better! Try again!"
                scoreDescriptor.textColor = .systemRed
            }
        case "Marvel":
            var numCorrect = 0
            if let rootVC = navigationController?.viewControllers.first as? ViewController {
                numCorrect = rootVC.marvel_correctness!.filter{$0 == true}.count
            }
            scoreLabel.text = "Score: \(numCorrect) out of \(num_questions!)"
            if numCorrect / num_questions! == 1 {
                scoreDescriptor.text = "Well done! You got it all correct!"
                scoreDescriptor.textColor = .systemGreen
            } else {
                scoreDescriptor.text = "You can do better! Try again!"
                scoreDescriptor.textColor = .systemRed
            }
        case "Science":
            var numCorrect = 0
            if let rootVC = navigationController?.viewControllers.first as? ViewController {
                numCorrect = rootVC.science_correctness!.filter{$0 == true}.count
            }
            scoreLabel.text = "Score: \(numCorrect) out of \(num_questions!)"
            if numCorrect / num_questions! == 1 {
                scoreDescriptor.text = "Well done! You got it all correct!"
                scoreDescriptor.textColor = .systemGreen
            } else {
                scoreDescriptor.text = "You can do better! Try again!"
                scoreDescriptor.textColor = .systemRed
            }
        default:
            return
        }
        
    }

    @IBAction func backBtnClick(_ sender: Any) {
        navigationController?.popToRootViewController(animated: true)
    }
    
    /*
    // MARK: - Navigation

    // In a storyboard-based application, you will often want to do a little preparation before navigation
    override func prepare(for segue: UIStoryboardSegue, sender: Any?) {
        // Get the new view controller using segue.destination.
        // Pass the selected object to the new view controller.
    }
    */

}
