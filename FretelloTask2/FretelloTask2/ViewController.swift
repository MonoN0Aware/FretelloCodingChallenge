//
//  ViewController.swift
//  FretelloTask2
//
//  Created by Decagon on 09/06/2021.
//

import UIKit

class ViewController: UIViewController {
    
    var sessions = Session()
    var dataForRow = [Exercise]()
    
    
    @IBOutlet weak var maxOutputLabel: UILabel!
    
    
    @IBOutlet weak var tableView: UITableView!
    
    override func viewDidLoad() {
        super.viewDidLoad()
        
        tableView.register(UINib(nibName: "SessionTableViewCell", bundle: nil), forCellReuseIdentifier: "cell")
        
        tableView.delegate = self
        tableView.dataSource = self
        decodeJSON()
    }

    func decodeJSON() {
        let url = URL(string: "http://codingtest.fretello.com:3000/data/sessions.json")
        URLSession.shared.dataTask(with: url!) { (data, response, error) in
            
            guard let data = data, error == nil else{
                print ("Something went wrong")
                return
            }
            
            var json:Session?
            do{
                json = try JSONDecoder().decode(Session.self, from: data)
            }
            catch{
                print("error:\(error)")
            }
            guard let result = json else {
                return
            }
            
            let reversed = result.reversed()
            self.sessions += reversed
            var exercisesArr = [[Int]]()
            let practiceSessions = result
           
            
            for session in practiceSessions {
                var exerciseBpmArray = [Int]()
                
                for exercise in session.exercises {
                    exerciseBpmArray.append(exercise.practicedAtBPM )
                }
                exercisesArr.append(exerciseBpmArray)
            }
            
            let maximumOutput = maxAverageBPM(exercisesArr: exercisesArr)
            DispatchQueue.main.async {
                self.maxOutputLabel.text = "The maximum output increase is \(maximumOutput)%"
                self.tableView.reloadData()
            }
            
            self.sessions.append(contentsOf: result)
            
        }.resume()
    }
    
}

extension ViewController:UITableViewDelegate, UITableViewDataSource {
    func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        return sessions[section].exercises.count
    }
    
    func numberOfSections(in tableView: UITableView) -> Int {
        sessions.count
    }
    
    func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        let cell = tableView.dequeueReusableCell(withIdentifier: "cell", for: indexPath) as! SessionTableViewCell
        let currentCell = sessions[indexPath.section].exercises[indexPath.row]
        cell.session = currentCell
        return cell
    }
    func tableView(_ tableView: UITableView, viewForHeaderInSection section: Int) -> UIView? {
        let sectionHeader = UIView()
        sectionHeader.backgroundColor = #colorLiteral(red: 0.1490196078, green: 0.1333333333, blue: 0.1294117647, alpha: 1)
        let sessionNameLabel = UILabel()
        sessionNameLabel.text = (sessions[section].name).uppercased()
        sessionNameLabel.textColor =  #colorLiteral(red: 1, green: 1, blue: 1, alpha: 1)
        sessionNameLabel.frame = CGRect(x: 10, y: -5 , width: self.view.frame.width, height: 40)
        sectionHeader.addSubview(sessionNameLabel)
        let dateLabel = UILabel()
        dateLabel.text = String((sessions[section].practicedOnDate).prefix(10))
        dateLabel.textColor =  #colorLiteral(red: 0.02652717359, green: 0.02652717359, blue: 0.02652717359, alpha: 1)
        dateLabel.frame = CGRect(x: 10, y: 20 , width: self.view.frame.width, height: 40)
        sectionHeader.addSubview(dateLabel)

        return sectionHeader
    }
}

