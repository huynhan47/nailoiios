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
  
 
    @IBOutlet weak var heightConst: NSLayoutConstraint!
    @IBOutlet weak var heightConstFrom: NSLayoutConstraint!
   
    @IBAction func Bingo(_ sender: Any) {
        performSegue(withIdentifier: "Bingo", sender: self)
    }
    
    @IBOutlet weak var imgQuestion: UIImageView!
    
    @IBOutlet weak var lblBitscore: UILabel!
    var puzzText = ["L","A","I","C","H","U","2","0","1","8","S","T","U","I","O","S"]
    var orgPuzzText = ["L","A","I","C","H","U"]
    var answerText   = [" ", " ", " "," "," "," ", " "," ", " ", " "," "," "," ", " "," ", " "] as Array
    var mappingText = [1,2,3,4,5,6,7,8,1,2,3,4,5,6,7,8] as Array
    var currentIndex = 0 as Int?;
    var totalIndex = 0;
    var Index : Int = 0;
    var height = CGFloat(3) ;
    let max = UIScreen.main.bounds .width;
    var spacing = CGFloat(3) ;
    var size = 3 ;
    override func viewDidLoad() {
        super.viewDidLoad()
        
        
        print(genRandomText(orgTextArray: orgPuzzText, length: 16));
        print(shuffle(array: puzzText))
        from.delegate = self;
        from.dataSource = self;
        
        target.delegate = self;
        target.dataSource = self;
        // Do any additional setup after loading the view, typically from a nib.
        
        
        // make UI
        
        let numberOfItemsPerRow = 8;
        let flowLayout = target.collectionViewLayout as! UICollectionViewFlowLayout
        
        spacing = max / 212;
        let totalSpace = flowLayout.sectionInset.left
            + flowLayout.sectionInset.right +
             (spacing * CGFloat(numberOfItemsPerRow - 1))
        size = Int((max - totalSpace) / CGFloat(numberOfItemsPerRow))
        
        
        heightConst.constant = (CGFloat(size) + (2*10))*2
        heightConstFrom.constant = (CGFloat(size) + (2*10))*2
        
        from.contentInset.bottom = 10;
        target.contentInset.top = 0;
        
        from.reloadData();
        target.reloadData();
        
        
        
        ////////
        
        ///imgQuestion.image = UIImage(named: "quotes");
        
        ///////
        
        //lbl
        //lblBitscore = UILabel(frame: CGRect(x: 0, y: 0, width: 200, height: 21)
        
        //lblBitscore.backgroundColor = UIColor(patternImage: UIImage(named: "bitscore")!)
        //lbl
        
        
    }
    override func viewWillAppear(_ animated: Bool) {
    
        //let  height =  target.collectionViewLayout.collectionViewContentSize.height;
        //heightConst.constant = height
        //print("height1")
        //print(height)
        //target.reloadData();
    }
    
    override func didReceiveMemoryWarning() {
        super.didReceiveMemoryWarning()
        // Dispose of any resources that can be recreated.
    }
    func numberOfSections(in collectionView: UICollectionView) -> Int {
        return 1;
    }
    func collectionView(_ collectionView: UICollectionView, numberOfItemsInSection section: Int) -> Int {
        
        if collectionView == self.target
        {
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
            
            cell.contentView.layer.cornerRadius = 10.0
            cell.contentView.layer.borderWidth = 3.0
            cell.contentView.layer.borderColor = UIColor.white.cgColor
            cell.contentView.backgroundColor = UIColor.blue;
            cell.contentView.layer.masksToBounds = true
            
            
            
            return cell;
        }
    }
    func collectionView(_ collectionView: UICollectionView, didSelectItemAt indexPath: IndexPath) {
        
         if collectionView == self.target
         {
            print(indexPath.row)
            currentIndex?-=1;
            puzzText[Int(mappingText[indexPath.row])] =  answerText[indexPath.row]; // revert puzzle text
    
            answerText[indexPath.row] = " "; //delete answer text
            
            if(currentIndex == totalIndex)
            {
                validAnswer();
            }
           
        }
         else if collectionView == self.from
         {
           
            answerText[currentIndex!] = puzzText[indexPath.row] // display answer text
            mappingText[currentIndex!] = indexPath.row; //track the index of answer texr
            puzzText[indexPath.row] = " "; // delete the puzzle text
            print(answerText[currentIndex!])
            currentIndex?+=1;
        }
        //let  height = collectionView.collectionViewLayout.collectionViewContentSize.height;
        //heightConst.constant = height

        target.reloadData();
        from.reloadData();
        
       performSegue(withIdentifier: "Bingo", sender: self)
    }
    func collectionView(_ collectionView: UICollectionView, layout collectionViewLayout: UICollectionViewLayout, sizeForItemAt indexPath: IndexPath) -> CGSize {
        

        print("size");
        print(size)
        let flowLayout = collectionViewLayout as! UICollectionViewFlowLayout
        flowLayout.minimumInteritemSpacing = spacing;
        //print("height2")
        //height  = CGFloat(size*3);
        //print(height)
 
        return CGSize(width: size, height: size)
        
        //flowLayout.collectionViewContentSize
        //let horizontalSpacing = layout.scrollDirection == .vertical ? layout.minimumInteritemSpacing : layout.minimumLineSpacing
        //let width = UIScreen.main.bounds.width
        //print(CGSize(width: (width - 10)/11, height: (width - 10)/11))
        //return CGSize(width: (width - 10)/11, height: (width - 10)/11) // width & height are the same to make a square cell
    }
    func validAnswer ()
    {
        
    }
    func genRandomText(orgTextArray : Array<Any>, length : Int) -> Array<Any>{
        let  offset = length - orgTextArray.count;
        var resultArray = orgTextArray;
        for _ in 1...offset
        {
            resultArray.append("A");
        }
        return resultArray;
    }
    
    func shuffle(array: Array<String>) -> Array<String >{
        var returnArray = array;
        var m = array.count, i=0;
        var t = "";
        // Chừng nào vẫn còn phần tử chưa được xáo trộn thì vẫn tiếp tục
        while  (m > 0 ){
            // Lấy ra 1 phần tử
            i = Int((drand48() * Double(m)));
            m-=1;
            // Sau đó xáo trộn nó
            t = returnArray[m];
            returnArray[m] = returnArray[i];
            returnArray[i] = t;
        }
        return returnArray;
    }
    
}

