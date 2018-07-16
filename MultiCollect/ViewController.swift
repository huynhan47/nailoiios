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
    
    var puzzText = ["a","r","3","4","6"]
    var orgPuzzText = ["a","r","3","4","6"]
    var answerText   = [" ", " ", " "," "," "] as Array
    var mappingText = [1,2,3,4,5,6,7,8] as Array
    var currentIndex = 0 as Int?;
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
        if collectionView == self.target{
            return puzzText.count;
            
        }
        else
            //if collectionView == self.from
        {
            return answerText.count;
            
        }
    }
    func collectionView(_ collectionView: UICollectionView, cellForItemAt indexPath: IndexPath) -> UICollectionViewCell {
        if collectionView == self.target
        {
            let cell:targetCellUnit = collectionView.dequeueReusableCell(withReuseIdentifier: "targetCellUnit", for: indexPath) as! targetCellUnit
            cell.backgroundColor = UIColor.red;
            cell.targetLabel.text = answerText[indexPath.row]
            return cell;
        }
        else  //if collectionView == self.from
        {
            let cell:fromCellUnit = collectionView.dequeueReusableCell(withReuseIdentifier: "fromCellUnit", for: indexPath) as! fromCellUnit
            cell.fromLabel.text = puzzText[indexPath.row]
            cell.backgroundColor = UIColor.blue;
            return cell;
        }
    }
    func collectionView(_ collectionView: UICollectionView, didSelectItemAt indexPath: IndexPath) {
        
         if collectionView == self.target{
            print(indexPath.row)
            currentIndex?-=1;
            puzzText[Int(mappingText[indexPath.row])] =  answerText[indexPath.row];
            //puzzText[mappingText[indexPath.row]] = answerText[indexPath.row]
            answerText[indexPath.row] = " ";
            target.reloadData();
            from.reloadData()
        }
         else if collectionView == self.from{
           
            answerText[currentIndex!] = puzzText[indexPath.row]
            mappingText[currentIndex!] = indexPath.row;
            puzzText[indexPath.row] = " ";
            print(answerText[currentIndex!])
            currentIndex?+=1;
            target.reloadData();
            from.reloadData();
            
        }
    }
    
}

