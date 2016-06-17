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
    @IBOutlet weak var imageHeightConst: NSLayoutConstraint!

    private let defaultImageHeight : CGFloat = 200.0

    override func viewDidLoad() {
        super.viewDidLoad()
        
        self.tableView.contentInset.top = defaultImageHeight
        self.imageHeightConst.constant = defaultImageHeight

        self.tableView.delegate = self
        self.tableView.dataSource = self
        
        print("\(self.tableView.contentOffset.y)")
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
        cell.textLabel?.text = "\(indexPath.row)"

        return cell
    }

    func tableView(tableView: UITableView, heightForRowAtIndexPath indexPath: NSIndexPath) -> CGFloat {
        
        return 44
    }
    
    // MARK: - UIScrollViewDelegate
    func scrollViewDidScroll(scrollView: UIScrollView) {
        self.imageHeightConst.constant = self.tableView.contentOffset.y * -1
    }
}
