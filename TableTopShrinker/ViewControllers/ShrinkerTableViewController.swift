//
//  ShrinkerTableViewController.swift
//  TableTopShrinker
//
//  Created by 佐藤 康次 on 2016/06/16.
//  Copyright © 2016年 佐藤 康次. All rights reserved.
//

import UIKit

class ShrinkerTableViewController: UIViewController, UITableViewDelegate, UITableViewDataSource{
    @IBOutlet weak var tableView: UITableView!
    @IBOutlet weak var imageView: UIImageView!
    @IBOutlet weak var maskView: UIView! //imageViewを白くぼやけさせるためのView
    @IBOutlet weak var imageHeightConst: NSLayoutConstraint!
    @IBOutlet weak var imageTopConst: NSLayoutConstraint!
    @IBOutlet weak var topLayoutGuideView: UIView! //NavigationBarのBottomの位置を知るためのView

    private let defaultImageHeight : CGFloat = 275.0
    private let upperVelocity :CGFloat = 0.5 //imageTopConstを上にずらす時の速さ割合
    private let barAlpha : CGFloat = 0.7 // Navigationbarの透明度
    
    override func viewDidLoad() {
        super.viewDidLoad()
        
        self.tableView.contentInset.top = defaultImageHeight
        self.imageHeightConst.constant = defaultImageHeight
        self.imageTopConst.constant = 0

        self.tableView.delegate = self
        self.tableView.dataSource = self
        
        self.title = "title"
    }
    
    override func viewWillAppear(animated: Bool) {
        super.viewWillAppear(animated)

    }
    
    override func viewDidAppear(animated: Bool) {
        super.viewDidAppear(animated)
        
        self.navigationController?.navigationBar.barTintColor = UIColor(colorLiteralRed: 1, green: 1, blue: 1, alpha: 0.5)
        self.navigationController?.navigationBar.translucent = true
        self.navigationController?.navigationBar.alpha = barAlpha
        
        self.setNavigationbarHidden(true)
        self.setTitleAlpha(0)
    }

    override func didReceiveMemoryWarning() {
        super.didReceiveMemoryWarning()
        // Dispose of any resources that can be recreated.
    }

    // MARK: - Table view data source

    func numberOfSectionsInTableView(tableView: UITableView) -> Int {
        // #warning Incomplete implementation, return the number of sections
        return 1
    }

    func tableView(tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        // #warning Incomplete implementation, return the number of rows
        return 100
    }
    
    func tableView(tableView: UITableView, cellForRowAtIndexPath indexPath: NSIndexPath) -> UITableViewCell {
        
        let cell = tableView.dequeueReusableCellWithIdentifier("Cell", forIndexPath: indexPath)
        cell.textLabel?.text = "cell: \(indexPath.row)番目"

        return cell
    }

    func tableView(tableView: UITableView, heightForRowAtIndexPath indexPath: NSIndexPath) -> CGFloat {
        
        return 44
    }
    
    // MARK: - UIScrollViewDelegate
    func scrollViewDidScroll(scrollView: UIScrollView) {
        // 値変わらないやつを何度も処理走らせるのきもいなあ
        
        if self.tableView.contentOffset.y * -1 >= defaultImageHeight{
            // TableViewをしたに引っ張った時にImageViewのサイズをその分上げる
            self.maskView.hidden = true
            self.imageHeightConst.constant = self.tableView.contentOffset.y * -1
            
            self.setTitleAlpha(0)
        }else{
            // TableViewを上にスクロールするとき
            if self.tableView.contentOffset.y + self.topLayoutGuideView.frame.origin.y >= 0{
                // TableViewのコンテンツがNavigationbarより上に来た時はNavigationbarを表示
                self.setNavigationbarHidden(false)
                return
            }
            
            self.setNavigationbarHidden(true)
            
            // スクロール速度より若干遅めに画像が移動する
            let diff = self.tableView.contentOffset.y + defaultImageHeight
            self.maskView.hidden = false
            self.imageTopConst.constant = diff * -1 * upperVelocity
            
            // 画像を白くぼやけさせる
            let alpha = 1 - self.tableView.contentOffset.y * -1 / defaultImageHeight
            self.maskView.alpha = alpha
            self.setTitleAlpha(alpha)
        }
    }
    
    // MARK: - 
    func setNavigationbarHidden(hidden : Bool){
        // http://qiita.com/mochizukikotaro/items/a4405701dcc706fd643e

        if hidden{
            self.navigationController?.navigationBar.setBackgroundImage(UIImage(), forBarMetrics: .Default)
            self.navigationController?.navigationBar.shadowImage = UIImage()
        }else{
            self.navigationController!.navigationBar.setBackgroundImage(nil, forBarMetrics: .Default)
            self.navigationController!.navigationBar.shadowImage = nil
        }
    }
    
    func setTitleAlpha(alpha : CGFloat){
        let selectedAttributes = [NSForegroundColorAttributeName : UIColor(red:0, green:0, blue:0, alpha:alpha)]
        self.navigationController?.navigationBar.titleTextAttributes = selectedAttributes
    }
}
