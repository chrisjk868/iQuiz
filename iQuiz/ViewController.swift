//
//  ViewController.swift
//  iQuiz
//
//  Created by Christopher Ku on 5/8/22.
//

import UIKit

class ViewController: UIViewController {

    @IBOutlet weak var subjectTable: UITableView!
    @IBOutlet weak var settingsBtn: UIBarButtonItem!
    
    let subjects = [
        "Mathematics",
        "Marvel Super Heroes",
        "Science"
    ]
    
    let subject_desc = [
        "Quiz with general arithmetic questions",
        "Marvel Universe general knowledge questions",
        "Science general knowledge questions"
    ]
    
    let subject_identifiers_imgs = [
        "Maths",
        "Marvel",
        "Science"
    ]
    
    let subject_attributes = [
        "Maths" : [
            "total" : 2,
            "answerKey" : ["144", "60"]
        ],
        "Marvel" : [
            "total" : 2,
            "answerKey" : []
        ],
        "Science" : [
            "total" : 2,
            "answerKey" : []
        ]
    ]
    
//    var vcs : [UIViewController] = []
    
    override func viewDidLoad() {
        super.viewDidLoad()
        // Do any additional setup after loading the view.
        let nib = UINib(nibName: "SubjectTableCell", bundle: nil)
        subjectTable.register(nib, forCellReuseIdentifier: "SubjectTableCell")
        subjectTable.delegate = self
        subjectTable.dataSource = self
//        let math_vc = UIStoryboard(name: "Main", bundle: .main).instantiateViewController(withIdentifier: "Maths")
//        let marvel_vc = UIStoryboard(name: "Main", bundle: .main).instantiateViewController(withIdentifier: "Marvel")
//        let science_vc = UIStoryboard(name: "Main", bundle: .main).instantiateViewController(withIdentifier: "Science")
//        vcs.append(contentsOf: [math_vc, marvel_vc, science_vc])
    }
    
    @IBAction func settingsClick(_ sender: Any) {
        let settingsAlert = UIAlertController(title: "Settings", message: "Settings go here", preferredStyle: UIAlertController.Style.alert)
        settingsAlert.addAction(
            UIAlertAction(title: NSLocalizedString("OK", comment: "Default action"),
                          style: .default,
                          handler: { _ in NSLog("The \"OK\" alert occured.")}))
        self.present(settingsAlert, animated: true, completion: nil)
    }
    
}

extension ViewController: UITableViewDelegate {
    
    func tableView(_ tableView: UITableView, didSelectRowAt indexPath: IndexPath) {
        let index : Int = indexPath.item
        switch index {
        case 0:
            let MathsVC = storyboard?.instantiateViewController(withIdentifier: "Maths") as! MathsQuiz
            navigationController?.pushViewController(MathsVC, animated: true)
        case 1:
            let MarvelVC = storyboard?.instantiateViewController(withIdentifier: "Marvel") as! MarvelQuiz
            navigationController?.pushViewController(MarvelVC, animated: true)
        case 2:
            let ScienceVC = storyboard?.instantiateViewController(withIdentifier: "Science") as! ScienceQuiz
            navigationController?.pushViewController(ScienceVC, animated: true)
        default :
            print("Do Nothing")
        }
        
//        navigationController?.pushViewController(vcs[indexPath.row], animated: true)
    }
    
}

extension ViewController: UITableViewDataSource {
    
    func numberOfSections(in tableView: UITableView) -> Int {
        return 1
    }
    
    func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        return subjects.count
    }
    
    func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        let cell = tableView.dequeueReusableCell(withIdentifier: "SubjectTableCell",
                                                 for: indexPath) as! SubjectTableCell
        cell.subjectLabel.text = subjects[indexPath.row]
        cell.subjectDesc.text = subject_desc[indexPath.row]
        cell.subjectImage.image = UIImage(named: subject_identifiers_imgs[indexPath.row])
        return cell
    }
    
}

