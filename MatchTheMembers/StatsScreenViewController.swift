//
//  StatsScreenViewController.swift
//  MatchTheMembers
//
//  Created by Tyler Reinecke on 2/7/19.
//  Copyright © 2019 Tyler Reinecke. All rights reserved.
//

import UIKit

class StatsScreenViewController: UIViewController {

    var maxStreak : Int!
    var prevThree : [String]!
    
    var streakPreface : UILabel!
    var streakLabel : UILabel!
    var recentLabel : UILabel!
    var oneLabel : UILabel!
    var twoLabel : UILabel!
    var threeLabel : UILabel!
    
    override func viewDidLoad() {
        super.viewDidLoad()

        // Do any additional setup after loading the view.
        
        streakPreface = UILabel(frame: CGRect(x: 0, y: 0, width: 300, height: 50))
        streakPreface.text = "Highest Streak: "
        streakPreface.font = UIFont(name: "HelveticaNeue-Bold", size: 40)
        streakPreface.textColor = UIColor.init(red: 75/255, green: 146/255, blue: 204/255, alpha: 1)
        streakPreface.center = CGPoint(x: view.frame.width / 2, y: view.frame.width / 4 + 100)
        streakPreface.textAlignment = .center
        
        streakLabel = UILabel(frame: CGRect(x: 0, y: 0, width: view.frame.width, height: 50))
        if let max = maxStreak {
            streakLabel.text = "\(max)"
        } else {
            streakLabel.text = "0"
        }
        streakLabel.font = UIFont(name: "HelveticaNeue", size: 35)
        streakLabel.textColor = UIColor.init(red: 248/255, green: 207/255, blue: 84/255, alpha: 1)
        streakLabel.center = CGPoint(x: view.frame.width / 2, y: streakPreface.frame.maxY + 50)
        streakLabel.textAlignment = .center
        
        recentLabel = UILabel(frame: CGRect(x: 0, y: 0, width: 300, height: 100))
        recentLabel.text = "Most Recent Answers: "
        recentLabel.lineBreakMode = .byWordWrapping
        recentLabel.numberOfLines = 2
        recentLabel.font = UIFont(name: "HelveticaNeue-Bold", size: 40)
        recentLabel.textColor = UIColor.init(red: 75/255, green: 146/255, blue: 204/255, alpha: 1)
        recentLabel.center = CGPoint(x: view.frame.width / 2, y: streakLabel.frame.maxY + 100)
        recentLabel.textAlignment = .center
        
        oneLabel = UILabel(frame: CGRect(x: 0, y: 0, width: 300, height: 50))
        oneLabel.text = "1. \(prevThree[0])"
        oneLabel.font = UIFont(name: "HelveticaNeue", size: 35)
        oneLabel.textColor = UIColor.init(red: 248/255, green: 207/255, blue: 84/255, alpha: 1)
        oneLabel.center = CGPoint(x: view.frame.width / 2, y: recentLabel.frame.maxY + 50)
        oneLabel.textAlignment = .center
        
        twoLabel = UILabel(frame: CGRect(x: 0, y: 0, width: 300, height: 50))
        twoLabel.text = "2. \(prevThree[1])"
        twoLabel.font = UIFont(name: "HelveticaNeue", size: 35)
        twoLabel.textColor = UIColor.init(red: 248/255, green: 207/255, blue: 84/255, alpha: 1)
        twoLabel.center = CGPoint(x: view.frame.width / 2, y: oneLabel.frame.maxY + 50)
        twoLabel.textAlignment = .center
        
        threeLabel = UILabel(frame: CGRect(x: 0, y: 0, width: 300, height: 50))
        threeLabel.text = "3. \(prevThree[2])"
        threeLabel.font = UIFont(name: "HelveticaNeue", size: 35)
        threeLabel.textColor = UIColor.init(red: 248/255, green: 207/255, blue: 84/255, alpha: 1)
        threeLabel.center = CGPoint(x: view.frame.width / 2, y: twoLabel.frame.maxY + 50)
        threeLabel.textAlignment = .center
        
        view.addSubview(streakPreface)
        view.addSubview(streakLabel)
        view.addSubview(recentLabel)
        view.addSubview(oneLabel)
        view.addSubview(twoLabel)
        view.addSubview(threeLabel)
        
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
