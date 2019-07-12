//
//  SHCoreSpot1907TableViewController.swift
//  SwiftDemo160801
//
//  Created by rrd on 2019/7/11.
//  Copyright © 2019 huangaengoln. All rights reserved.
//

import UIKit

class SHCoreSpot1907TableViewController: UITableViewController {
    var lastSelectedFriend: Person?
    
    override func viewDidLoad() {
        super.viewDidLoad()
        tableView.register(UITableViewCell.self, forCellReuseIdentifier: "Cell")
        
        SHDataSource.instance.savePeopleToIndex()
    }
    
    override func prepare(for segue: UIStoryboardSegue, sender: Any?) {
        let destination = segue.destination as! SHCoreSpotlightDetailViewController
        destination.person = lastSelectedFriend!
    }
    
    func showFriend(id: String) {
        lastSelectedFriend = SHDataSource.instance.friendFrom(id)
        performSegue(withIdentifier: "showFriend", sender: self)
    }
}
extension SHCoreSpot1907TableViewController  {
    
    override func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        let cell = tableView.dequeueReusableCell(withIdentifier: "Cell")
        let person = SHDataSource.instance.people[indexPath.row]
        cell?.textLabel?.text = person.name
        
        return cell!
    }
    
    override func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        return SHDataSource.instance.people.count
    }
    
    // This shouldn't be necessary as the tap action is in the Storyboard, but it doesn't seem to be working in beta 1.
    override func tableView(_ tableView: UITableView, didSelectRowAt indexPath: IndexPath) {
        let selectedIndex = tableView.indexPathForSelectedRow?.row
        lastSelectedFriend = SHDataSource.instance.people[selectedIndex!]
        
        performSegue(withIdentifier: "showFriend", sender: self)
    }
}
