//
//  MemeTableViewController.swift
//  MemeMe
//
//  Created by Travis Baker on 5/16/17.
//  Copyright © 2017 Travis Baker. All rights reserved.
//

import UIKit

class MemeTableViewController: UITableViewController {
    
    var memes: [Meme]!
    
    override func viewDidLoad() {
        super.viewDidLoad()
        self.tableView.rowHeight = 100
        getMemes()
    }
    
    override func viewWillAppear(_ animated: Bool) {
        getMemes()
    }
    
    /// Retrieves the memes
    func getMemes() {
        memes = Meme.getAllMemes()
        self.tableView.reloadData()
    }
    
    // MARK: - Table view data source
    
    override func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        return memes.count
    }
    
    override func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        let cell = tableView.dequeueReusableCell(withIdentifier: "MemeTableViewCell", for: indexPath) as! MemeTableViewCell
        
        let meme = memes[indexPath.row]
        
        // Setup the cell
        cell.memedImage.image = meme.memedImage
        cell.memeText.text = "\(meme.topText) \(meme.bottomText)"
        
        return cell
    }
    
    override func tableView(_ tableView: UITableView, didSelectRowAt indexPath: IndexPath) {
        let detailViewController = self.storyboard?.instantiateViewController(withIdentifier: "MemeDetailViewController") as! MemeDetailViewController
        
        detailViewController.memedImage = memes[indexPath.row].memedImage
        
        navigationController?.pushViewController(detailViewController, animated: true)
    }
    
}
