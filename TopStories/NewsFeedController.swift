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
    @IBOutlet weak var searchBar: UISearchBar!
    
    // data for table view
    var headlines = [NewsHeadline]() {
        didSet {
            tableView.reloadData()
        }
    }
    
    override func viewDidLoad() {
        super.viewDidLoad()
        tableView.dataSource = self // NewsFeedController is the dataSource object for the table view
        tableView.delegate = self
        searchBar.delegate = self
        loadData()
    }
    
    func loadData() {
        headlines = HeadlineData.getHeadlines() // [NewsHeadline]
    }

    func filterHeadlines(for searchText: String) {
        headlines = HeadlineData.getHeadlines().filter { $0.title.lowercased().contains(searchText.lowercased()) }
    }

}

extension NewsFeedController: UITableViewDataSource {
    func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        return headlines.count
    }
    
    func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        guard let cell = tableView.dequeueReusableCell(withIdentifier: "headlineCell", for: indexPath) as? HeadlineCell else { fatalError("couldn't dequeue a HeadlineCell") }
        
        let headline = headlines[indexPath.row]
        cell.configureCell(for: headline)
        return cell
    }
}

extension NewsFeedController: UITableViewDelegate {
    func tableView(_ tableView: UITableView, heightForRowAt indexPath: IndexPath) -> CGFloat {
        return 180
    }
}

extension NewsFeedController: UISearchBarDelegate {
    func searchBarSearchButtonClicked(_ searchBar: UISearchBar) {
        // dismiss the keyboard
        searchBar.resignFirstResponder()
    }
    
    //TODO: real time search
    //TODO: what happends when the search bar is empty
    
    func searchBar(_ searchBar: UISearchBar, textDidChange searchText: String) {
        guard !searchText.isEmpty else {
            // search text is empty here so we get back all the original headlines using out loadData() method
            loadData()
            return
        }
        filterHeadlines(for: searchText)
        
    }
}
