//
//  NewHeadline.swift
//  TopStories
//
//  Created by Edward O'Neill on 11/25/19.
//  Copyright © 2019 Edward O'Neill. All rights reserved.
//

import Foundation

// top level JSON - HeadlinesData.self because top level JSON is a dict
struct HeadlineData: Codable {
    let results: [NewsHeadline] // "results" represents the JSON array of stories
}

struct NewsHeadline: Codable {
    let title: String
    let abstract: String
    let byline: String
    let multimedia: [HeadlinePhoto]
}

struct HeadlinePhoto: Codable {
    let url: String
    let format: String
}

extension HeadlineData {
    // parse the "topStoriesTechnology.json" into an [NewsHeadline] objects
    static func getHeadlines() -> [NewsHeadline] {
        var headline = [NewsHeadline]()
        
        // the app Bundle() allows to access (read) our app resources and files, e.g mp3 file or in our case the topStoriesTechnology.json
        
        // get the url to he intended resource
        // here we need the url to the topStoriesTechnology.json file
        guard let fileURL = Bundle.main.url(forResource: "topStories", withExtension: "json") else { fatalError("could not locate json file") }
        
        // get the data from the contents of the fileURL
        do {
            let data = try Data(contentsOf: fileURL)
            
            // parse data to our Swift [NewsHeadline]
            
            let headlinesData = try JSONDecoder().decode(HeadlineData.self, from: data)
            headline = headlinesData.results // [NewsHeadline]
            
            
        } catch {
            fatalError("faild to load contents \(error)")
        }
        
        return headline
    }
}


