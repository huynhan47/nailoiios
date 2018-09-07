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
    var totalQuestionCount :String = " "
    var finishList : String? = "\"0000\""
    var finishCount : Int? = 0 ;
    override func viewDidLoad() {
        score =  defaults.string(forKey: "score");
        if (score == nil)
        {
            score = "100";
        }
        print(score!)
        lblBitCoin.text = score;
        
        finishList =  defaults.string(forKey: "finishList");
        if (finishList == nil)
        {
            finishList = "\"0000\"";
        }
        print(finishList!)
        
        
        super.viewDidLoad();
       
        
        var db = try? Connection();
       
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
        finishCount = finishList?.split(separator: ",").count ;
        lblScore.text = String(finishCount! - 1) + "/" + totalQuestionCount;
        print("total ne 1:" +  lblScore.text! )
        
    }
}
