//
//  ItemViewController.swift
//  Swiperia
//
//  Created by Dennis Dubbert on 03.10.17.
//  Copyright © 2017 Dennis Dubbert. All rights reserved.
//

import UIKit

class ItemViewController: UIViewController, UITableViewDelegate, UITableViewDataSource {
    
    let clickedColor = UIColor.init(red: 150/255, green: 150/255, blue: 150/255, alpha: 1)
    let openColor = UIColor.init(red: 202/255, green: 202/255, blue: 202/255, alpha: 1)
    
    @IBOutlet weak var multiPlayerTable: UITableView!
    
    @IBOutlet weak var singleplayerButton: UIButton! {
        didSet {
            // Set Basics
            singleplayerButton.layer.borderWidth = 0.7
            singleplayerButton.layer.borderColor = UIColor.black.cgColor
            singleplayerButton.layer.cornerRadius = 15
            singleplayerButton.backgroundColor = clickedColor
        }
    }
    
    @IBAction func singleplayerButtonTapped(_ sender: Any) {
        headerLabel.text = "Singleplayer Items"
        currentMode = .single
        singleplayerButton.backgroundColor = clickedColor
        multiplayerButton.backgroundColor = openColor
        multiPlayerTable.reloadData()
    }
    
    @IBOutlet weak var multiplayerButton: UIButton! {
        didSet {
            // Set Basics
            multiplayerButton.layer.borderWidth = 0.7
            multiplayerButton.layer.borderColor = UIColor.black.cgColor
            multiplayerButton.layer.cornerRadius = 15
            multiplayerButton.backgroundColor = openColor
        }
    }
    
    @IBAction func multiplayerButtonTapped(_ sender: Any) {
        headerLabel.text = "Multiplayer Items"
        currentMode = .multi
        multiplayerButton.backgroundColor = clickedColor
        singleplayerButton.backgroundColor = openColor
        multiPlayerTable.reloadData()
    }
    
    @IBOutlet weak var headerLabel: UILabel!
    
    let singlePlayerItems = ItemManager().getAllItem(ofType: .single)
    let multiPlayerItems = ItemManager().getAllItem(ofType: .multi)
    var currentMode = GameMode.single
    
    override func viewDidLoad() {
        super.viewDidLoad()
        multiPlayerTable.delegate = self
        multiPlayerTable.dataSource = self
    }
    
    func numberOfSections(in tableView: UITableView) -> Int {
        return 1
    }
    
    func tableView(_ tableView: UITableView, heightForRowAt indexPath: IndexPath) -> CGFloat {
        return 100
    }
    
    func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        if currentMode == .single {
            return singlePlayerItems.count
        } else {
            return multiPlayerItems.count
        }
    }
    
    func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {

        let cell = multiPlayerTable.dequeueReusableCell(withIdentifier: "ItemCell", for: indexPath) as! SingleItemCell
        
        if currentMode == .single {
            cell.itemImage.image = UIImage.init(named: singlePlayerItems[indexPath.row].imageName)
            cell.itemText.text = singlePlayerItems[indexPath.row].description
        } else {
            cell.itemImage.image = UIImage.init(named: multiPlayerItems[indexPath.row].imageName)
            cell.itemText.text = multiPlayerItems[indexPath.row].description
        }
        return cell
        
    }

    override func didReceiveMemoryWarning() {
        super.didReceiveMemoryWarning()
        // Dispose of any resources that can be recreated.
    }
    

    /*
    // MARK: - Navigation

    // In a storyboard-based application, you will often want to do a little preparation before navigation
    override func prepare(for segue: UIStoryboardSegue, sender: Any?) {
        // Get the new view controller using segue.destinationViewController.
        // Pass the selected object to the new view controller.
    }
    */

}
