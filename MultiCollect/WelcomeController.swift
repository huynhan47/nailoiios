//
//  WelcomeController.swift
//  MultiCollect
//
//  Created by Posco ICT VN on 8/15/18.
//  Copyright © 2018 Posco ICT VN. All rights reserved.
//

import Foundation
import UIKit
import SQLite

class WelcomeController : UIViewController
{ 
    let defaults = UserDefaults.standard;
    var score : String? = " ";
    @IBOutlet weak var lblScore: UILabel!
    @IBOutlet weak var lblBitCoin: UILabel!
    let path = Bundle.main.path(forResource: "laichu1", ofType: "sqlite")
    var totalQuestionCount :String = " ";
    
    override func viewDidLoad() {
        score =  defaults.string(forKey: "score");
        if (score == nil)
        {
            score = "100";
        }
        print(score!)
        super.viewDidLoad();
        lblBitCoin.text = score;
        
        var db = try? Connection();
        let laichus = Table("laichu");
        let id = Expression<String?>("id")
        let letters = Expression<String?>("letters")
        do{
            db = try Connection(path!)
        }
        catch{
            
        }
        
        let sql_count = "SELECT count(*) FROM LAICHU"
        for row in try! db!.prepare(sql_count)
        {
            //print("total ne 1: \(row[0]!)")
            totalQuestionCount = String(row[0]! as! Int64)
             print("total ne 1: \(row[0]!)" + totalQuestionCount)
        }
        lblScore.text = totalQuestionCount;
        print("total ne 1:" +  lblScore.text! )
        
    }
}
