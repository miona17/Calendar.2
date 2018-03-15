//
//  ViewController.swift
//  カレンダーその二
//
//  Created by 倉茂未央那 on 2018/01/20.
//  Copyright © 2018年 倉茂未央那. All rights reserved.
//

import UIKit

class ViewController: UIViewController ,UICollectionViewDataSource,UICollectionViewDelegate,UICollectionViewDelegateFlowLayout{ //← 追記
    var myCollectionView : UICollectionView!
    let dateManager = DateManager()
    
    let weekArray = ["Sun", "Mon", "Tue", "Wed", "Thu", "Fri", "Sat"]
    let numOfDays = 7
    let cellMargin : CGFloat = 2.0
    
   
    @IBOutlet weak var calenderCollectionView: UICollectionView!
    @IBOutlet weak var headerTitle: UILabel!
    
    
    override func viewDidLoad() {
        super.viewDidLoad()
    
        calenderCollectionView.delegate = self
        calenderCollectionView.dataSource = self
        
        headerTitle.text = dateManager.CalendarHeader()
    }
    
    override func didReceiveMemoryWarning() {
        super.didReceiveMemoryWarning()
        
    }
    
    func numberOfSections(in collectionView: UICollectionView) -> Int {
        return 2
    }
    
    func collectionView(_ collectionView: UICollectionView, numberOfItemsInSection section: Int) -> Int {
        if(section == 0){
            return numOfDays
        }else{
            return dateManager.daysAcquisition()
        }
    }
    
    func collectionView(_ collectionView: UICollectionView, cellForItemAt indexPath: IndexPath) -> UICollectionViewCell {
        
        
        let cell = collectionView.dequeueReusableCell(withReuseIdentifier: "CalendarCell", for: indexPath) as! CalendarCell
        if(indexPath.section == 0){
            cell.backgroundColor = UIColor.white
            cell.textLabel.text = weekArray[indexPath.row]
            
        }else{
            cell.backgroundColor = UIColor.white
            cell.textLabel.text = dateManager.conversionDateFormat(index: indexPath.row)
        }
        if (indexPath.row % 7 == 0) {
            cell.textLabel.textColor = UIColor.red
        } else if (indexPath.row % 7 == 6) {
            cell.textLabel.textColor = UIColor.blue
        } else {
            cell.textLabel.textColor = UIColor.gray
        }
        return cell
    }
    
    
    func collectionView(_ collectionView: UICollectionView, didSelectItemAt indexPath: IndexPath) {
        print("Num：\(indexPath.row) Section:\(indexPath.section)")
    }
    
    func collectionView(_ collectionView: UICollectionView, layout collectionViewLayout: UICollectionViewLayout, sizeForItemAt indexPath: IndexPath) -> CGSize {
        let numberOfMargin:CGFloat = 8.0
        let widths:CGFloat = (collectionView.frame.size.width - cellMargin * numberOfMargin)/CGFloat(numOfDays)
        let heights:CGFloat = widths * 1.0
        
        return CGSize(width:widths,height:heights)
    }
    
    
    func collectionView(_ collectionView: UICollectionView, layout collectionViewLayout: UICollectionViewLayout, insetForSectionAt section: Int) -> UIEdgeInsets {
        return UIEdgeInsetsMake(0.0 , 0.0 , 0.0 , 0.0 )  //マージン(top , left , bottom , right)
    }
    
    func collectionView(_ collectionView: UICollectionView, layout collectionViewLayout: UICollectionViewLayout, minimumInteritemSpacingForSectionAt section: Int) -> CGFloat {
        return cellMargin
    }
   
    func collectionView(_ collectionView: UICollectionView, layout collectionViewLayout: UICollectionViewLayout, minimumLineSpacingForSectionAt section: Int) -> CGFloat {
        return cellMargin
    }

    @IBAction func prevMonthBtn(_ sender: UIButton) {
        dateManager.preMonthCalendar()
        calenderCollectionView.reloadData()
        headerTitle.text = dateManager.CalendarHeader()
    }
    
    @IBAction func nextMonthBtn(_ sender: UIButton) {
        dateManager.nextMonthCalendar()
        calenderCollectionView.reloadData()
        headerTitle.text = dateManager.CalendarHeader()
    }
    
}
