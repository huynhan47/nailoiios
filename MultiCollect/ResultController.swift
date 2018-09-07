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
    var QuynhAkaArray : [String] = ["ok_1","ok_2","ok_3","ok_4","ok_5","ok_6","ok_7"]
    @IBOutlet weak var answerLabel: UILabel!
    @IBOutlet weak var QuynhAkaImg: UIImageView!
    @IBAction func btnPlay(_ sender: Any) {
    }
    override func viewDidLoad() {
        super.viewDidLoad()
        answerLabel.text = answerString;
        let index = Int(arc4random_uniform(6));
        QuynhAkaImg.image = UIImage (named :QuynhAkaArray[index])
        
    }
}
