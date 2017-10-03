//
//  ItemViewController.swift
//  Swiperia
//
//  Created by Dennis Dubbert on 03.10.17.
//  Copyright © 2017 Dennis Dubbert. All rights reserved.
//

import UIKit

class ItemViewController: UIViewController, UITableViewDelegate, UITableViewDataSource {
    
    @IBOutlet weak var multiPlayerTable: UITableView!
    
    @IBOutlet weak var singlePlayerTable: UITableView!
    
    let singlePlayerItems = ItemManager().getAllItem(ofType: .single)
    let multiPlayerItems = ItemManager().getAllItem(ofType: .multi)
    
    override func viewDidLoad() {
        super.viewDidLoad()
        
        singlePlayerTable.delegate = self
        singlePlayerTable.dataSource = self
        
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
        if tableView == singlePlayerTable {
            return singlePlayerItems.count
        } else {
            return multiPlayerItems.count
        }
    }
    
    func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        if tableView == singlePlayerTable {
            let cell = singlePlayerTable.dequeueReusableCell(withIdentifier: "ItemCell", for: indexPath) as! SingleItemCell
        
            cell.itemImage.image = UIImage.init(named: singlePlayerItems[indexPath.row].imageName)
            cell.itemText.text = singlePlayerItems[indexPath.row].description
            return cell
        } else {
            let cell = multiPlayerTable.dequeueReusableCell(withIdentifier: "ItemCell", for: indexPath) as! SingleItemCell
            
            cell.itemImage.image = UIImage.init(named: multiPlayerItems[indexPath.row].imageName)
            cell.itemText.text = multiPlayerItems[indexPath.row].description
            return cell
        }
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
