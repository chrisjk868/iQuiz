//
//  MathsQuiz.swift
//  iQuiz
//
//  Created by Christopher Ku on 5/9/22.
//

import UIKit

class MathsQuiz: UIViewController {
    
    let total : Int = 5
    var score : Int = 0
    
    // Responses
    @IBOutlet weak var q1: UISegmentedControl!
    @IBOutlet weak var q2: UISegmentedControl!
    @IBOutlet weak var q3: UISegmentedControl!
    
    override func viewDidLoad() {
        super.viewDidLoad()
        // Do any additional setup after loading the view.
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
