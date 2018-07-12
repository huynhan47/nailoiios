//
//  ViewController.swift
//  MultiCollect
//
//  Created by Posco ICT VN on 7/9/18.
//  Copyright © 2018 Posco ICT VN. All rights reserved.
//

import UIKit

class ViewController: UIViewController , UICollectionViewDelegate,UICollectionViewDataSource{


    @IBOutlet weak var target: UICollectionView!
    @IBOutlet weak var from: UICollectionView!
    
    var puzzText = ["1","2","3","4","5"]
    var answerText = ["1","2","3","4","5"]

    override func viewDidLoad() {
        super.viewDidLoad()
        
        from.delegate = self;
        from.dataSource = self;
        
        target.delegate = self;
        target.dataSource = self;
        // Do any additional setup after loading the view, typically from a nib.
    }

    override func didReceiveMemoryWarning() {
        super.didReceiveMemoryWarning()
        // Dispose of any resources that can be recreated.
    }
    func numberOfSections(in collectionView: UICollectionView) -> Int {
        return 1;
    }
    func collectionView(_ collectionView: UICollectionView, numberOfItemsInSection section: Int) -> Int {
        return puzzText.count;
    }
    func collectionView(_ collectionView: UICollectionView, cellForItemAt indexPath: IndexPath) -> UICollectionViewCell {
        if collectionView == self.target{
        let cell:targetCellUnit = collectionView.dequeueReusableCell(withReuseIdentifier: "targetCellUnit", for: indexPath) as! targetCellUnit
        cell.backgroundColor = UIColor.red;
        cell.targetLabel.text = puzzText[indexPath.row]
            return cell;
        }
        else{
            let cell:fromCellUnit = collectionView.dequeueReusableCell(withReuseIdentifier: "fromCellUnit", for: indexPath) as! fromCellUnit
           
            cell.backgroundColor = UIColor.blue;
            return cell;
        }
    }
    func collectionView(_ collectionView: UICollectionView, didSelectItemAt indexPath: IndexPath) {
        
         if collectionView == self.target{
            print(indexPath);
            puzzText.append("31");
            answerText[indexPath.row] = " ";
            target.reloadData();
            from.reloadData()
        }
         else{
            answerText.append("7");
            puzzText[indexPath.row] = " ";
            target.reloadData();
            from.reloadData();
            
        }
    }
    
}

