//
//  ResultController.swift
//  MultiCollect
//
//  Created by Posco ICT VN on 8/14/18.
//  Copyright © 2018 Posco ICT VN. All rights reserved.
//

import Foundation
import UIKit
import GoogleMobileAds
class ResultController : UIViewController
{
    var answerString : String = " ";
    var QuynhAkaArray : [String] = ["ok_1","ok_2","ok_3","ok_4","ok_5","ok_6","ok_7"]
    @IBOutlet weak var answerLabel: UILabel!
    @IBOutlet weak var QuynhAkaImg: UIImageView!
    @IBOutlet weak var adBanner: GADBannerView!
    @IBAction func btnPlay(_ sender: Any) {
    }
    
    override func viewDidLoad() {
        super.viewDidLoad()
        answerLabel.text = answerString;
        let index = Int(arc4random_uniform(6));
        QuynhAkaImg.image = UIImage (named :QuynhAkaArray[index])
        adBanner.adUnitID="ca-app-pub-3940256099942544/2934735716";
        adBanner.rootViewController = self
        adBanner.load(GADRequest());
    }
}

//extension ViewController: GADBannerViewDelegate {
//    func adViewDidReceiveAd(_ bannerView: GADBannerView) {
//        print("Banner loaded successfully")
//        
//        // Reposition the banner ad to create a slide down effect
//        let translateTransform = CGAffineTransform(translationX: 0, y: -bannerView.bounds.size.height)
//        bannerView.transform = translateTransform
//        
//        UIView.animate(withDuration: 0.5) {
//            bannerView.transform = CGAffineTransform.identity
//        }
//    }
//    
//    func adView(_ bannerView: GADBannerView, didFailToReceiveAdWithError error: GADRequestError) {
//        print("Fail to receive ads")
//        print(error)
//    }
//    
//}
