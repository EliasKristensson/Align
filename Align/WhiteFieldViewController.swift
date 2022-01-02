//
//  WhiteFieldViewController.swift
//  Align
//
//  Created by Elias Kristensson on 2020-10-18.
//  Copyright © 2020 Elias Kristensson. All rights reserved.
//

import UIKit

class WhiteFieldViewController: UIViewController {

    var settingsManager: SettingsManager!
    
    @IBOutlet weak var bgWhite: UISwitch!
    @IBOutlet weak var titleText: UILabel!
    
    @IBAction func switchChanged(_ sender: Any) {
        if bgWhite.isOn {
            self.view.backgroundColor = UIColor.white
            titleText.textColor = .black
            titleText.text = "White-field"
        } else {
            self.view.backgroundColor = UIColor.black
            titleText.textColor = .white
            titleText.text = "Black-field"
        }
    }
    
    override func viewDidLoad() {
        super.viewDidLoad()
        
    }
    
}
