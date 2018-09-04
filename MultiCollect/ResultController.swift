//
//  ResultController.swift
//  MultiCollect
//
//  Created by Posco ICT VN on 8/14/18.
//  Copyright © 2018 Posco ICT VN. All rights reserved.
//

import Foundation
import UIKit
class ResultController : UIViewController
{
    var answerString : String = " ";
    @IBOutlet weak var answerLabel: UILabel!
    @IBAction func btnPlay(_ sender: Any) {
    }
    override func viewDidLoad() {
        super.viewDidLoad()
        answerLabel.text = answerString;
    }
}
