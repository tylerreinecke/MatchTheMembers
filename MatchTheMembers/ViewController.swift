//
//  ViewController.swift
//  MatchTheMembers
//
//  Created by Tyler Reinecke on 2/6/19.
//  Copyright © 2019 Tyler Reinecke. All rights reserved.
//

import UIKit

class ViewController: UIViewController {

    var MDBLogo : UIImageView!
    var welcomeText : UILabel!
    var promptText : UILabel!
    var startButton : UIButton!
    
    override func viewDidLoad() {
        super.viewDidLoad()
        
        // Do any additional setup after loading the view, typically from a nib.
        
        MDBLogo = UIImageView(frame: CGRect(x: 0, y: 0, width: 500, height: 500))
        MDBLogo.image = UIImage(named: "MDBLogo")
        MDBLogo.center = CGPoint(x: view.frame.width / 2, y: 200)
        
        welcomeText = UILabel(frame: CGRect(x: 0, y: 0, width: view.frame.width, height: 50))
        welcomeText.text = "Match The Members!"
        welcomeText.font = UIFont(name: "HelveticaNeue-Bold", size: 35)
        welcomeText.textColor = UIColor.init(red: 75/255, green: 146/255, blue: 204/255, alpha: 1)
        welcomeText.center = CGPoint(x: view.frame.width / 2, y: MDBLogo.frame.midY + 150)
        welcomeText.textAlignment = .center
        
        promptText = UILabel(frame: CGRect(x: 0, y: 0, width: view.frame.width, height: 50))
        promptText.text = "Press Start to Begin"
        promptText.font = UIFont(name: "HelveticaNeue", size: 30)
        promptText.textColor = UIColor.init(red: 248/255, green: 207/255, blue: 84/255, alpha: 1)
        promptText.center = CGPoint(x: view.frame.width / 2, y: welcomeText.frame.maxY + 50)
        promptText.textAlignment = .center
        
        startButton = UIButton(frame: CGRect(x: 0, y: 0, width: 200, height: 100))
        startButton.center = CGPoint(x: view.frame.width / 2, y: promptText.frame.maxY + 150)
        startButton.setTitle("Start!", for: .normal)
        startButton.titleLabel!.font = UIFont(name: "HelveticaNeue-Bold", size: 50)
        startButton.setTitleColor(.white, for: .normal)
        startButton.backgroundColor = UIColor.init(red: 87/255, green: 181/255, blue: 96/255, alpha: 1)
        startButton.addTarget(self, action: #selector(startPressed), for: .touchUpInside)
        
        view.addSubview(MDBLogo)
        view.addSubview(welcomeText)
        view.addSubview(promptText)
        view.addSubview(startButton)
    }
    
    @objc func startPressed() {
        self.performSegue(withIdentifier: "toMainScreen", sender: self)
    }

}
