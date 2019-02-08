//
//  MainScreenViewController.swift
//  MatchTheMembers
//
//  Created by Tyler Reinecke on 2/6/19.
//  Copyright © 2019 Tyler Reinecke. All rights reserved.
//

import UIKit

class MainScreenViewController: UIViewController {
    
    var memberImage : UIImageView!
    var score : Int = 0
    var choices : [UIButton] = []
    var scoreLabel : UILabel!
    var correctName : String!
    var currStreak = 0
    var maxStreak = 0
    var prevThree : [String] = ["None", "None", "None"]
    
    var turnTimer = Timer()
    var turnLabel : UILabel!
    var turnSeconds = 5
    var isTurnRunning = false
    
    var answerTimer = Timer()
    var answerSeconds = 1
    var isAnswerRunning = false
    
    var stats : UIBarButtonItem!
    
    
    override func viewDidLoad() {
        super.viewDidLoad()

        // Do any additional setup after loading the view.
        
        memberImage = UIImageView(frame: CGRect(x: 0, y: 0, width: 350, height: 350))
        memberImage.center = CGPoint(x: view.frame.width / 2, y: view.frame.height / 3 + 30)
        memberImage.clipsToBounds = true
        memberImage.contentMode = .scaleAspectFill
        
        choices.append(UIButton(frame: CGRect(x: 0, y: memberImage.frame.maxY + 100, width: view.frame.width / 1.5, height: 50)))
        choices.append(UIButton(frame: CGRect(x: 0, y: choices[0].frame.maxY + 10, width: view.frame.width / 1.5, height: 50)))
        choices.append(UIButton(frame: CGRect(x: 0, y: choices[1].frame.maxY + 10, width: view.frame.width / 1.5, height: 50)))
        choices.append(UIButton(frame: CGRect(x: 0, y: choices[2].frame.maxY + 10, width: view.frame.width / 1.5, height: 50)))
 
        for button in choices {
            button.center = CGPoint(x: view.frame.width / 2, y: button.frame.midY)
            button.backgroundColor = UIColor.init(red: 46/255, green: 125/255, blue: 246/255, alpha: 1)
            button.titleLabel!.font = UIFont(name: "HelveticaNeue", size: 25)
            button.addTarget(self, action: #selector(choicePressed), for: .touchUpInside)
        }
        
        scoreLabel = UILabel(frame: CGRect(x: 0, y: 0, width: 300, height: 50))
        scoreLabel.textAlignment = .center
        scoreLabel.font = UIFont(name: "HelveticaNeue-Bold", size: 50)
        scoreLabel.textColor = UIColor.init(red: 248/255, green: 207/255, blue: 84/255, alpha: 1)
        scoreLabel.center = CGPoint(x: view.frame.width / 2, y: memberImage.frame.minY - 35)
        
        stats = UIBarButtonItem(image: UIImage(named: "statsIcon"), style: .plain, target: self, action: #selector(statsPressed))
        self.navigationItem.rightBarButtonItem = stats
        
        turnLabel = UILabel(frame: CGRect(x: 0, y: 0, width: 100, height: 75))
        turnLabel.text = "\(turnSeconds)"
        turnLabel.textAlignment = .center
        turnLabel.font = UIFont(name: "HelveticaNeue-Bold", size: 75)
        turnLabel.textColor = UIColor.init(red: 248/255, green: 207/255, blue: 84/255, alpha: 1)
        turnLabel.center = CGPoint(x: view.frame.width / 2, y: memberImage.frame.maxY + 50)
        
        view.addSubview(memberImage)
        view.addSubview(scoreLabel)
        view.addSubview(turnLabel)
        for i in 0...3 {
            view.addSubview(choices[i])
        }
        
        refresh()
    }

    /*
    // MARK: - Navigation

    // In a storyboard-based application, you will often want to do a little preparation before navigation
    override func prepare(for segue: UIStoryboardSegue, sender: Any?) {
        // Get the new view controller using segue.destination.
        // Pass the selected object to the new view controller.
    }
    */
    
    @objc func choicePressed(sender : UIButton) {
        check(button : sender)
    }
    
    @objc func statsPressed() {
        self.performSegue(withIdentifier: "toStatsScreen", sender: self)
    }
    
    override func prepare(for segue: UIStoryboardSegue, sender: Any?) {
        if let nextVC = segue.destination as? StatsScreenViewController {
            nextVC.maxStreak = maxStreak
            nextVC.prevThree = prevThree
        }
    }

    /* Replaces the image, names/color of the 4 buttons, and the score. */
    func refresh() {
        correctName = Constants.names.randomElement()!
        memberImage.image = Constants.getImageFor(name: correctName)
        var names = [String]()
        names.append(correctName)
        for _ in 0...2 {
            var recent = getRandomName()
            while recent == correctName {
                recent = getRandomName()
            }
            names.append(recent)
        }
        names.shuffle()
        var i = 0
        for name in names {
            choices[i].setTitle(name, for: .normal)
            i += 1
        }
        
        for button in choices {
            button.backgroundColor = UIColor.init(red: 46/255, green: 125/255, blue: 246/255, alpha: 1)
        }
        
        scoreLabel.text = "Score: " + String(score)
        if !isTurnRunning {
            runTurnTimer()
        }
    }
    
    /* Checks if the button pressed is correct. */
    func check(button : UIButton) {
        if !isAnswerRunning {
            resetTurnTimer(timeOut: false)
            if button.currentTitle == correctName {
                currStreak += 1
                maxStreak = max(currStreak, maxStreak)
                addToPrevThree(result: "Correct 👍")
                button.backgroundColor = .green
                runAnswerTimer()
                score += 1
            } else {
                currStreak = 0
                addToPrevThree(result: "Incorrect 👎")
                button.backgroundColor = .red
                runAnswerTimer()
            }
        }
    }
    
    /* Updates the previous three results. */
    func addToPrevThree(result: String) {
        prevThree[2] = prevThree[1]
        prevThree[1] = prevThree[0]
        prevThree[0] = result
    }
    
    /* Gets random name. */
    func getRandomName() -> String {
        return Constants.names.randomElement()!
    }
    
    //5 Second Turn Timer
    func runTurnTimer() {
        turnTimer = Timer.scheduledTimer(timeInterval: 1, target: self, selector: (#selector(updateTurnTimer)), userInfo: nil, repeats: true)
        isTurnRunning = true
    }
    
    @objc func updateTurnTimer() {
        if turnSeconds < 2 {
            resetTurnTimer(timeOut : true)
        } else {
            turnSeconds -= 1
            turnLabel.text = "\(turnSeconds)"
        }
    }
    
    func resetTurnTimer(timeOut : Bool) {
        turnTimer.invalidate()
        isTurnRunning = false
        turnSeconds = 5
        turnLabel.text = "\(turnSeconds)"
        if timeOut {
            addToPrevThree(result: "No response 🤦‍♂️")
            for button in choices {
                button.backgroundColor = .red
            }
            runAnswerTimer()
        }
    }
    
    //1 Second Answer Timer
    func runAnswerTimer() {
        answerTimer = Timer.scheduledTimer(timeInterval: 1, target: self, selector: (#selector(updateAnswerTimer)), userInfo: nil, repeats: false)
        isAnswerRunning = true
    }
    
    @objc func updateAnswerTimer() {
        resetAnswerTimer()
        refresh()
    }
    
    func resetAnswerTimer() {
        answerTimer.invalidate()
        answerSeconds = 1
        isAnswerRunning = false
    }
}
