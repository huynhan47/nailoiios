//
//  ViewController.swift
//  MultiCollect
//
//  Created by Posco ICT VN on 7/9/18.
//  Copyright © 2018 Posco ICT VN. All rights reserved.
//

import UIKit

class ViewController: UIViewController , UICollectionViewDelegate,UICollectionViewDataSource,UICollectionViewDelegateFlowLayout{


    @IBOutlet weak var target: UICollectionView!
    @IBOutlet weak var from: UICollectionView!
    
    var puzzText = ["a","r","3","4","6","6","7","8","a","r","3","4","6","6","7","8"]
    var orgPuzzText = ["a","r","3","4","6","6","7","8","a","r","3","4","6","6","7","8"]
    var answerText   = [" ", " ", " "," "," "," ", " "," ", " ", " "," "," "," ", " "," ", " "] as Array
    var mappingText = [1,2,3,4,5,6,7,8,1,2,3,4,5,6,7,8] as Array
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
            //cell.backgroundColor = UIColor.red;
            cell.targetLabel.text = answerText[indexPath.row]
            
            cell.contentView.layer.cornerRadius = 10.0
            cell.contentView.layer.borderWidth = 3.0
            cell.contentView.layer.borderColor = UIColor.white.cgColor
            cell.contentView.backgroundColor = UIColor.red;
            cell.contentView.layer.masksToBounds = true
         
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
            puzzText[Int(mappingText[indexPath.row])] =  answerText[indexPath.row]; // revert puzzle text
    
            answerText[indexPath.row] = " "; //delete answer text
            target.reloadData();
            from.reloadData()
        }
         else if collectionView == self.from{
           
            answerText[currentIndex!] = puzzText[indexPath.row] // display answer text
            mappingText[currentIndex!] = indexPath.row; //track the index of answer texr
            puzzText[indexPath.row] = " "; // delete the puzzle text
            print(answerText[currentIndex!])
            currentIndex?+=1;
            target.reloadData();
            from.reloadData();
            
        }
    }
    func collectionView(_ collectionView: UICollectionView, layout collectionViewLayout: UICollectionViewLayout, sizeForItemAt indexPath: IndexPath) -> CGSize {
        let width = UIScreen.main.bounds.width
        return CGSize(width: (width - 10)/11, height: (width - 10)/11) // width & height are the same to make a square cell
    }
    
}

