//
//  ViewController.swift
//  explorer
//
//  Created by Yusuke Tanaka on 2018/04/14.
//  Copyright © 2018 Yusuke Tanaka. All rights reserved.
//

import UIKit
import Koloda

private var numberOfCards: UInt = 5

class ViewController: UIViewController {
    @IBOutlet weak var kolodaView: KolodaView!

    private var dataSource: Array<UIImage> = {
        var images: Array<UIImage> = []
        for index in 0..<numberOfCards {
            images.append(UIImage(named: "Card_\(index + 1)")!)
        }
        return images
    }()
    
    override func viewDidLoad() {
        super.viewDidLoad()
        // Do any additional setup after loading the view, typically from a nib.
        kolodaView.dataSource = self
        kolodaView.delegate = self
    }
    
    override func didReceiveMemoryWarning() {
        super.didReceiveMemoryWarning()
        // Dispose of any resources that can be recreated.
    }
}

//MARK: KolodaViewDelegate
extension ViewController: KolodaViewDelegate {
    func kolodaDidRunOutOfCards(koloda: KolodaView) {
        dataSource.insert(UIImage(named: "Card_6")!, at: kolodaView.currentCardIndex - 1)
        let position = kolodaView.currentCardIndex
        kolodaView.insertCardAtIndexRange(position..<position, animated: true)
    }

    func koloda(koloda: KolodaView, didSelectCardAtIndex index: UInt) {
        UIApplication.shared.open(URL(string: "http://yalantis.com/")!, options: [:])
    }
}

//MARK: KolodaViewDataSource
extension ViewController: KolodaViewDataSource {
    func kolodaNumberOfCards(_ koloda: KolodaView) -> Int {
        return Int(dataSource.count)
    }
    
    func kolodaSpeedThatCardShouldDrag(_ koloda: KolodaView) -> DragSpeed {
        return .fast
    }
    
    func koloda(koloda: KolodaView, viewForCardAtIndex index: UInt) -> UIView {
        return UIImageView(image: dataSource[Int(index)])
    }
    
    func koloda(_ koloda: KolodaView, viewForCardAt index: Int) -> UIView {
        return UIImageView(image: dataSource[Int(index)])

//        let view = UIView(frame: koloda.bounds)
//        view.backgroundColor = UIColor.gray
//        return view

//        return Bundle.main.loadNibNamed("OverlayView", owner: self, options: nil)![0] as! UIView
    }
}
