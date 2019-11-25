//
//  ViewController.swift
//  TopStories
//
//  Created by Edward O'Neill on 11/25/19.
//  Copyright © 2019 Edward O'Neill. All rights reserved.
//

import UIKit

class NewsFeedController: UIViewController {

    @IBOutlet weak var tableView: UITableView!
    
    // data for table view
    var headline = [NewsHeadline]() {
        didSet {
            tableView.reloadData()
        }
    }
    
    override func viewDidLoad() {
        super.viewDidLoad()
        tableView.dataSource = self // NewsFeedController is the dataSource object for the table view
        loadData()
    }
    
    func loadData() {
        headline = HeadlineData.getHeadlines() // [NewsHeadline]
    }


}

extension NewsFeedController: UITableViewDataSource {
    func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        return headline.count
    }
    
    func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        let cell = tableView.dequeueReusableCell(withIdentifier: "headlineCell", for: indexPath)
        return cell
    }
}
