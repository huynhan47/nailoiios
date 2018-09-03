//
//  ViewController.swift
//  MultiCollect
//
//  Created by Posco ICT VN on 7/9/18.
//  Copyright © 2018 Posco ICT VN. All rights reserved.
//

import UIKit
import GoogleMobileAds
import iAd
import Toast_Swift
import SQLite

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
    var puzzText = ["L","A","I","C","H","U","2","0","1","8","S","T","U","D","I","O"]
    //var orgPuzzText = ["L","A","I","C","H","U"]
    var answerText   = [" ", " ", " "," "," "," "," "," "] as Array
    var mappingText = [1,2,3,4,5,6,7,8,1,2,3,4,5,6,7,8] as Array
    var currentIndex = 0 as Int?;
    var totalIndex = 0;
    var Index : Int = 0;
    var height = CGFloat(3) ;
    let max = UIScreen.main.bounds .width;
    var spacing = CGFloat(3) ;
    var size = 3 ;
    @IBOutlet weak var Banner: GADBannerView!
    let path = Bundle.main.path(forResource: "laichu1", ofType: "sqlite")
    
    var imgQuestionName :String = "h_0007";
    var finishList :String? = "\"0000\"";
    let defaults = UserDefaults.standard;
    var OrgPuzzleString = "";
    var currentQuestionID : String?;
    
    
    //Ad
    lazy var adBannerView: GADBannerView = {
        let adBannerView = GADBannerView(adSize: kGADAdSizeSmartBannerPortrait)
        adBannerView.adUnitID = "ca-app-pub-3940256099942544/2934735716"
        adBannerView.delegate = self
        adBannerView.rootViewController = self
        
        return adBannerView
    }()
    
    
    @IBAction func LetShare(_ sender: Any) {
        let activityVC = UIActivityViewController(activityItems: ["String to share"],applicationActivities: nil)
        present(activityVC, animated: true, completion: nil)
        if let popOver = activityVC.popoverPresentationController {
            popOver.sourceView = self.view
            //popOver.sourceRect =
            //popOver.barButtonItem
        }
        
    }
    
    override func viewDidLoad() {
        super.viewDidLoad()
        
        print(shuffle(array: puzzText))
        from.delegate = self;
        from.dataSource = self;
        
        target.delegate = self;
        target.dataSource = self;
        // Do any additional setup after loading the view, typically from a nib.
        
        
        // make UI
        //From UI
        let numberOfItemsPerRow = 8;
        let flowLayout = target.collectionViewLayout as! UICollectionViewFlowLayout
        
        spacing = max / 212;
        let totalSpace = flowLayout.sectionInset.left
            + flowLayout.sectionInset.right +
             (spacing * CGFloat(numberOfItemsPerRow - 1))
        size = Int((max - totalSpace) / CGFloat(numberOfItemsPerRow))
        
        heightConstFrom.constant = (CGFloat(size) + 10)*2
        from.contentInset.bottom = 10;
        from.reloadData();
      
        
        //Target UI
        let numberOfItemsPerRowTarget = 8;
        let flowLayoutTarget = target.collectionViewLayout as! UICollectionViewFlowLayout
        
        spacing = max / 212;
        let totalSpaceTarget = flowLayoutTarget.sectionInset.left
            + flowLayoutTarget.sectionInset.right +
            (spacing * CGFloat(numberOfItemsPerRowTarget - 1))
        size = Int((max - totalSpaceTarget) / CGFloat(numberOfItemsPerRowTarget))
        
        heightConst.constant = CGFloat(size) + 10
        target.contentInset.top = 0;
        target.reloadData();
        
        //Ad
        
        Banner.adUnitID="ca-app-pub-3940256099942544/2934735716";
        Banner.rootViewController = self
        Banner.load(GADRequest());
        ////////
        imgQuestion.image = UIImage(named: "clock");
        ///////
        
        //lbl
        //lblBitscore = UILabel(frame: CGRect(x: 0, y: 0, width: 200, height: 21)
        
        //lblBitscore.backgroundColor = UIColor(patternImage: UIImage(named: "bitscore")!)
        //lbl
        
        //DataBase
        var db = try? Connection();
        let laichus = Table("laichu");
        let id = Expression<String?>("id")
        let letters = Expression<String?>("letters")
        do{
            db = try Connection(path!)
        }
        catch{
            let err1 = error as NSError
            print("error occurred, here are the details1:\n \(err1)")
            
        }
        //for laichu in try db!.prepare(laichus) {
        //    print("id: \(laichu[id]), name: \(user[name]), email: \(user[email])")
            // id: 1, name: Optional("Alice"), email: alice@mac.com
        //}
        do {
            
            for laichu in try db!.prepare(laichus) {
                print("id: \(laichu[id]!)")
                // id: 1, name: Optional("Alice"), email: alice@mac.com
            }
            // SELECT * FROM "users"
        }
        catch{
            let err2 = error as NSError
            print("error occurred, here are the details2:\n \(err2)")
            
        }
        
        //try! db!.prepare(laichus)
   
        let question = laichus.filter(letters == "B_I_E_T_T_H_U")
        
        for row in try! db!.prepare(question)
        {
            print("id ne 0: \(row[id]!)")
        }
      
        finishList =  defaults.string(forKey: "finishList");
        if (finishList == nil)
        {
            finishList = "\"0000\"";
        }
        print(finishList!)
        
        //defaults.set("\"0003\"", forKey: "finishList")
        //finishList =  defaults.string(forKey: "finishList");
        //if (finishList == nil)
        //{
        //    finishList = "\"0005\"";
        //}
        print(finishList!)
        
        //User Default - End
        
        let sql = "SELECT * FROM LAICHU WHERE ID  NOT IN (" + finishList! + ") ORDER BY ID ASC LIMIT 1 "
        print("sql ne: " + sql)
        for row in try! db!.prepare(sql)
        {
            print("id ne 1: \(row[1]!)")
            currentQuestionID =  (row[0]) as? String
            imgQuestionName =  "h_" + currentQuestionID!
            OrgPuzzleString = row[2] as! String
            answerText = Array<String>(repeating: " ", count: OrgPuzzleString.split(separator: "_").count)
            totalIndex = answerText.count;
            let orgPuzzle = OrgPuzzleString.split(separator: "_")
            var orgPuzzleArray : [String] = []
            for i in 0 ..< orgPuzzle.count
            {
                if (orgPuzzle[i] != "_")
                {
                    orgPuzzleArray.append(String(orgPuzzle[i]))
                }
            }
            puzzText =  shuffle(array:  genRandomText(orgTextArray: orgPuzzleArray, length: 16))
            
        }
        print("imgQuestionName ne :"  +  imgQuestionName);
        imgQuestion.image = UIImage(named: imgQuestionName);
        
        //User Default - Start
        
        
       
        
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
            return OrgPuzzleString.split(separator: "_").count;
        }
        else
            //if collectionView == self.from
        {
            return puzzText.count;
            
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
    func captureScreen() -> UIImage {
        var window: UIWindow? = UIApplication.shared.keyWindow
        window = UIApplication.shared.windows[0] as? UIWindow
        UIGraphicsBeginImageContextWithOptions(window!.frame.size, window!.isOpaque, 0.0)
        window!.layer.render(in:UIGraphicsGetCurrentContext()!)
        let image = UIGraphicsGetImageFromCurrentImageContext()
        UIGraphicsEndImageContext()
        return image!;
    }
    
    func collectionView(_ collectionView: UICollectionView, didSelectItemAt indexPath: IndexPath) {
        
         if collectionView == self.target
         {
            print(indexPath.row)
            currentIndex?-=1;
            puzzText[Int(mappingText[indexPath.row])] =  answerText[indexPath.row]; // revert puzzle text
    
            answerText[indexPath.row] = " "; //delete answer text
        }
         else if collectionView == self.from
         {
           
            answerText[currentIndex!] = puzzText[indexPath.row] // display answer text
            mappingText[currentIndex!] = indexPath.row; //track the index of answer texr
            puzzText[indexPath.row] = " "; // delete the puzzle text
            print(answerText[currentIndex!])
            currentIndex?+=1;
            
            if(currentIndex == totalIndex)
            {
                validAnswer();
            }
            
        }
        //let  height = collectionView.collectionViewLayout.collectionViewContentSize.height;
        //heightConst.constant = height

        target.reloadData();
        from.reloadData();
        
       ////performSegue(withIdentifier: "Bingo", sender: self)
        //self.view.makeToast("This is a piece of toast", duration: 2.0, point: CGPoint(x: 110.0, y: 110.0), title: "Toast Title", image: UIImage(named: "clock.png")) { didTap in
        //    if didTap {
        //        print("completion from tap")
        //    } else {
        //        print("completion without tap")
        //    }
      //  }
        
        ///self.view.makeToast("This is a piece of toast", duration: 2.0, point: CGPoint(x: 110.0, y: 110.0), ///title: "Toast Title", image: captureScreen()) { didTap in
         ///   if didTap {
         ///       print("completion from tap")
          ///  } else {
          ///      print("completion without tap")
           /// }
       /// }
        
        ///let extractedExpr = captureScreen();
        ///let activityVC = UIActivityViewController(activityItems: [["String to share"], extractedExpr],applicationActivities: nil)
       /// present(activityVC, animated: true, completion: nil)
       /// if let popOver = activityVC.popoverPresentationController {
        ///    popOver.sourceView = self.view
        ///..}
            
    }
    func collectionView(_ collectionView: UICollectionView, layout collectionViewLayout: UICollectionViewLayout, sizeForItemAt indexPath: IndexPath) -> CGSize {
        

        //print("size");
        //print(size)
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
        let AnswerString = answerText.joined(separator: "_");
        ///let OrgPuzzleString = orgPuzzText.joined();
        if (AnswerString == OrgPuzzleString)
        {
            print("Bingo");
            finishList! += (",\"" + currentQuestionID! + "\"")
            defaults.set(finishList!, forKey: "finishList")
        }
        else
        {
            print("Wrong");
        }
        
    }
    
   
    
    func genRandomText(orgTextArray : [String], length : Int) -> [String]{
        let textRemain = length - orgTextArray.count;
        var resultArray = orgTextArray;
        let abcString : String = "ABCDEFGHIKLMNOPQRSTUVXY";
       
        ///let abcArray : [Character] = Array(abcString)
        for _ in 1...textRemain
        {
            let offset = Int(arc4random_uniform(23));
            resultArray.append(abcString.subString(from : offset, to: (offset)));
        }
        return resultArray
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

extension ViewController: UITableViewDelegate {
    func tableView(_ tableView: UITableView, viewForHeaderInSection section: Int) -> UIView? {
        return adBannerView
    }
    
    func tableView(_ tableView: UITableView, heightForHeaderInSection section: Int) -> CGFloat {
        return adBannerView.frame.height
    }
}

extension ViewController: GADBannerViewDelegate {
    func adViewDidReceiveAd(_ bannerView: GADBannerView) {
        print("Banner loaded successfully")
        
        // Reposition the banner ad to create a slide down effect
        let translateTransform = CGAffineTransform(translationX: 0, y: -bannerView.bounds.size.height)
        bannerView.transform = translateTransform
        
        UIView.animate(withDuration: 0.5) {
            bannerView.transform = CGAffineTransform.identity
        }
    }
    
    func adView(_ bannerView: GADBannerView, didFailToReceiveAdWithError error: GADRequestError) {
        print("Fail to receive ads")
        print(error)
    }
}

extension String {
    func subString(from: Int, to: Int) -> String {
        let startIndex = self.index(self.startIndex, offsetBy: from)
        let endIndex = self.index(self.startIndex, offsetBy: to)
        return String(self[startIndex...endIndex])
    }
}

