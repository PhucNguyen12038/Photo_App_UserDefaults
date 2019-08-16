//
//  ViewController.swift
//  PhotoFeed_NSUserDefaults
//
//  Created by nhp on 8/13/19.
//  Copyright © 2019 nhp. All rights reserved.
//

import UIKit

class ViewController: UIViewController {
    
    @IBOutlet weak var dateLabel: UILabel!
    
    @IBOutlet weak var updateButton: UIButton!
    
    override func viewDidLoad() {
        super.viewDidLoad()
        // Do any additional setup after loading the view.
        updateDateLabel2()
    }

    func updateDateLabel1(){
        self.dateLabel.text = NSDate().description
    }
    
    func updateDateLabel2(){
        let lastUpdate = UserDefaults.standard.object(forKey: "buttonTapped") as? NSDate
        if let hasLastUpdate = lastUpdate {
            self.dateLabel.text = hasLastUpdate.description
        }
        else{
            self.dateLabel.text = "No date saved."
        }
    }

    @IBAction func onUpdateButton(_ sender: Any) {
        let now = NSDate()
        UserDefaults.standard.set(now, forKey: "buttonTapped")
        self.updateDateLabel2()
    }
}

