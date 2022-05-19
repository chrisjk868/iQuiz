//
//  ViewController.swift
//  iQuiz
//
//  Created by Christopher Ku on 5/8/22.
//

import UIKit
import Network
import Foundation

class ViewController: UIViewController {

    @IBOutlet weak var subjectTable: UITableView!
    @IBOutlet weak var settingsBtn: UIBarButtonItem!
    
    // MARK: - SubjectElement
    public struct SubjectElement: Codable {
        let title, desc: String
        let questions: [Question]
    }

    // MARK: - Question
    public struct Question: Codable {
        let text, answer: String
        let answers: [String]
    }
    
    typealias Subject = [SubjectElement]
    
    var data_store : Data?
    var subjects : [String] = []
    var subject_desc : [String] = []
    var subject_questions : [String : [String]] = [:]
    var subject_answer_choices : [String : [[String]]] = [:]
    var subject_answers : [String : [String : [String]]] = [:]
    var subjects_info : Subject? = nil
    var maths_correctness : [Bool]?
    var marvel_correctness : [Bool]?
    var science_correctness : [Bool]?
    var vcs : [UIViewController] = []
    
    override func viewDidLoad() {
        super.viewDidLoad()
        // Do any additional setup after loading the view.
        let nib = UINib(nibName: "SubjectTableCell", bundle: nil)
//      https://tednewardsandbox.site44.com/questions.json
        subjectTable.register(nib, forCellReuseIdentifier: "SubjectTableCell")
        subjectTable.delegate = self
        subjectTable.dataSource = self
//        let math_vc = UIStoryboard(name: "Main", bundle: .main).instantiateViewController(withIdentifier: "Maths")
//        let marvel_vc = UIStoryboard(name: "Main", bundle: .main).instantiateViewController(withIdentifier: "Marvel")
//        let science_vc = UIStoryboard(name: "Main", bundle: .main).instantiateViewController(withIdentifier: "Science")
//        vcs.append(contentsOf: [math_vc, marvel_vc, science_vc])
        let dir = FileManager.default.urls(for: .documentDirectory, in: .userDomainMask).first
        data_store = FileManager.default.contents(atPath: dir!.path + "/response.txt")
        let monitor = NWPathMonitor()
        monitor.pathUpdateHandler = { _ in
            if Reachability.isConnectedToNetwork(){
                print("==============================")
                print("Internet Connection Available!")
                print("==============================")
            } else {
                print("================================")
                print("Internet Connection unavailable!")
                print("================================")
                DispatchQueue.main.async {
                    let networkAlert = UIAlertController(title: "Network Unavailable", message: "Retrieve locally stored quiz?", preferredStyle: UIAlertController.Style.alert)
                    networkAlert.addAction(UIAlertAction(title: NSLocalizedString("Yes", comment: "Default action"),
                                                         style: .default,
                                                         handler: { _ in
                        if self.data_store == nil {
                            let noDataAlert = UIAlertController(title: "Can't find local data", message: "Please ensure you have retrieved the quiz online before.", preferredStyle: UIAlertController.Style.alert)
                            noDataAlert.addAction(UIAlertAction(title: NSLocalizedString("OK", comment: "Default action"), style: .default, handler: { _ in }))
                            self.present(noDataAlert, animated: true, completion: nil)
                        } else {
                            self.getLocalData(data_store: self.data_store!)
                            self.updateData()
                            DispatchQueue.main.async {
                                self.updateTable()
                                self.subjectTable.reloadData()
                            }
                        }
                    }))
                    self.present(networkAlert, animated: true, completion: nil)
                }
            }
        }
        let queue = DispatchQueue(label: "InternetConnectionMonitor")
        monitor.start(queue: queue)
    }
    
    @IBAction func settingsClick(_ sender: Any) {
        let settingsAlert = UIAlertController(title: "Settings", message: "Retrieve online quiz", preferredStyle: UIAlertController.Style.alert)
        settingsAlert.addTextField { (textField) in
            textField.placeholder = "Enter URL"
        }
        
        settingsAlert.addAction(
            UIAlertAction(title: NSLocalizedString("Check Now", comment: "Default action"),
                          style: .default,
                          handler: { [weak settingsAlert] (_) in
                              let textField = settingsAlert?.textFields![0]
                              if textField!.text != "" {
                                  let url : URL? = URL(string: textField!.text!)
                                  if url != nil {
                                      self.getData(from: url!)
                                  } else {
                                      print("Empty URL")
                                      self.invalidUrlHandler()
                                  }
                              } else {
                                  self.invalidUrlHandler()
                              }
                          }))
        self.present(settingsAlert, animated: true, completion: nil)
    }
    
    func getData(from url: URL) {
        let session = URLSession.shared.dataTask(with: url) {
            (data, response, error) in guard let data = data else {
                print("Data is nil");
                self.invalidUrlHandler()
                return
            }
            if response != nil {
                if (response! as! HTTPURLResponse).statusCode % 100 == 5 {
                    print("Server Error")
                }
                if (response! as! HTTPURLResponse).statusCode != 200 {
                    print("Something went wrong! \(error!)")
                }
            }
            do {
                let questions = try JSONDecoder().decode(Subject.self, from: data)
                self.subjects_info = questions
                if let dir = FileManager.default.urls(for: .documentDirectory, in: .userDomainMask).first {
                    let fileURL = dir.appendingPathComponent("response.txt")
                    do {
                        try data.write(to: fileURL)
                    } catch {
                        print(error)
                    }
                }
            } catch {
                print("Online Quiz Retreival Error: \(error)")
            }
            // Update data & attributes of quiz
            self.updateData()
            DispatchQueue.main.async {
                self.updateTable()
                self.subjectTable.reloadData()
            }
            UserDefaults.standard.set(url.absoluteString, forKey: "url")
            print(UserDefaults.standard.string(forKey: "url"))
        }
        session.resume()
    }
    
    func getLocalData(data_store: Data) {
        do {
            let offline_data = try JSONDecoder().decode(Subject.self, from: data_store)
            self.subjects_info = offline_data
            var subjects : [String] = []
            var subject_desc : [String] = []
            var subject_answers : [String : [String : [String]]] = [:]
            for subject in self.subjects_info! {
                subjects.append(subject.title)
                subject_desc.append(subject.desc)
                subject_answers[subject.title] = ["answers" : []]
                for question in subject.questions {
                    subject_answers[subject.title]!["answers"]!.append(question.answers[Int(question.answer)! - 1])
                }
            }
            self.subjects = subjects
            self.subject_desc = subject_desc
            self.subject_answers = subject_answers
        } catch {
            print("Local data failure: \(error)")
        }
    }
    
    func invalidUrlHandler() {
        DispatchQueue.main.async {
            let invalidUrlAlert = UIAlertController(title: "Invalid URL", message: "Please enter a valid URL", preferredStyle: UIAlertController.Style.alert)
            invalidUrlAlert.addAction(UIAlertAction(title: NSLocalizedString("OK", comment: "Default action"), style: .default, handler: { _ in
            }))
            self.present(invalidUrlAlert, animated: true, completion: nil)
        }
    }
    
    func updateTable() {
        let science_vc = QuestionScene()
        let marvel_vc = QuestionScene()
        let maths_vc = QuestionScene()
        self.vcs.append(science_vc)
        self.vcs.append(marvel_vc)
        self.vcs.append(maths_vc)
        
        // Append relevant information to each nib
        science_vc.title = "Science Question 1"
        science_vc.curr_subject = "Science"
        science_vc.curr_question = 0
        science_vc.curr_questions = self.subject_questions["Science!"]
        science_vc.curr_answer_choices = self.subject_answer_choices["Science!"]
        science_vc.curr_answers = self.subject_answers["Science!"]!["answers"]
        
        marvel_vc.title = "Marvel Question 1"
        marvel_vc.curr_subject = "Marvel"
        marvel_vc.curr_question = 0
        marvel_vc.curr_questions = self.subject_questions["Marvel Super Heroes"]
        marvel_vc.curr_answer_choices = self.subject_answer_choices["Marvel Super Heroes"]
        marvel_vc.curr_answers = self.subject_answers["Marvel Super Heroes"]!["answers"]
        
        maths_vc.title = "Maths Question 1"
        maths_vc.curr_subject = "Maths"
        maths_vc.curr_question = 0
        maths_vc.curr_questions = self.subject_questions["Mathematics"]
        maths_vc.curr_answer_choices = self.subject_answer_choices["Mathematics"]
        maths_vc.curr_answers = self.subject_answers["Mathematics"]!["answers"]
        
    }
    
    func updateData() {
        var subjects : [String] = []
        var subject_desc : [String] = []
        var subject_questions : [String : [String]] = [:]
        var subject_answer_choices : [String : [[String]]] = [:]
        var subject_answers : [String : [String : [String]]] = [:]
        for subject in self.subjects_info! {
            subjects.append(subject.title)
            subject_desc.append(subject.desc)
            subject_questions[subject.title] = []
            subject_answer_choices[subject.title] = []
            subject_answers[subject.title] = ["answers" : []]
            for question in subject.questions {
                subject_questions[subject.title]!.append(question.text)
                subject_answer_choices[subject.title]!.append(question.answers)
                subject_answers[subject.title]!["answers"]!.append(question.answers[Int(question.answer)! - 1])
            }
        }
        self.subjects = subjects
        self.subject_desc = subject_desc
        self.subject_questions = subject_questions
        self.subject_answer_choices = subject_answer_choices
        self.subject_answers = subject_answers
        self.maths_correctness = Array(repeating: false, count: self.subject_answers["Mathematics"]!["answers"]!.count)
        self.marvel_correctness = Array(repeating: false, count: self.subject_answers["Marvel Super Heroes"]!["answers"]!.count)
        self.science_correctness = Array(repeating: false, count: self.subject_answers["Science!"]!["answers"]!.count)
    }
    
}

extension ViewController: UITableViewDelegate {
     
    func tableView(_ tableView: UITableView, didSelectRowAt indexPath: IndexPath) {

        navigationController?.pushViewController(vcs[indexPath.row], animated: true)
        
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
        cell.subjectImage.image = UIImage(named: subjects[indexPath.row])
        return cell
    }
    
}
