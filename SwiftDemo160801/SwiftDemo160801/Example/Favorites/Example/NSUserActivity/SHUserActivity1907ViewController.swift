//
//  SHUserActivity1907ViewController.swift
//  SwiftDemo160801
//
//  Created by rrd on 2019/7/10.
//  Copyright © 2019 huangaengoln. All rights reserved.
//

import UIKit

class SHUserActivity1907ViewController: UITableViewController {

    let datasource = SHDataSource()
    
    var lastSelectedFriend: Person?
    
    override func viewDidLoad() {
        super.viewDidLoad()
        tableView.register(UITableViewCell.self, forCellReuseIdentifier: "Cell")
        
        datasource.savePeopleToIndex()
    }
    
    override func prepare(for segue: UIStoryboardSegue, sender: Any?) {
        let destination = segue.destination as! SHUserActivityDetailViewController
        destination.person = lastSelectedFriend!
    }
    
    func showFriend(id: String) {
        lastSelectedFriend = datasource.friendFrom(id)
        performSegue(withIdentifier: "showFriend", sender: self)
    }
}

extension SHUserActivity1907ViewController  {
    
    override func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        let cell = tableView.dequeueReusableCell(withIdentifier: "Cell")
        let person = datasource.people[indexPath.row]
        cell?.textLabel?.text = person.name
        
        return cell!
    }
    
    override func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        return datasource.people.count
    }
    
    // This shouldn't be necessary as the tap action is in the Storyboard, but it doesn't seem to be working in beta 1.
    override func tableView(_ tableView: UITableView, didSelectRowAt indexPath: IndexPath) {
        let selectedIndex = tableView.indexPathForSelectedRow?.row
        lastSelectedFriend = datasource.people[selectedIndex!]
        
        performSegue(withIdentifier: "showFriend", sender: self)
    }
}
