//
//  MoodL.swift
//  Mandala
//
//  Created by Robert Whitewick on 03/05/2023.
//

import UIKit

class MoodListViewController: UITableViewController {
    var moodEntries: [MoodEntry] = []
    
    override func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        return moodEntries.count
    }
    
    override func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        let moodEntry = moodEntries[indexPath.row]
        
        let cell = tableView.dequeueReusableCell(withIdentifier: "UITableViewCell", for: indexPath)
        
        cell.imageView?.image = moodEntry.mood.image
        cell.textLabel?.text = "I was \(moodEntry.mood.name)"
        
        let dateString = DateFormatter.localizedString(from: moodEntry.timestamp,
                                                       dateStyle: .medium,
                                                       timeStyle: .short)
        cell.detailTextLabel?.text = "on \(dateString)"
        
        return cell
    }
}
