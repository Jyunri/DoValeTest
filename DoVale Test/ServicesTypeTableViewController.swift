//
//  ServicesTableViewController.swift
//  DoVale Test
//
//  Created by Jimy Suenaga on 19/08/17.
//  Copyright © 2017 Audience Marketing. All rights reserved.
//

import UIKit
import Firebase

class ServicesTypeTableViewController: UITableViewController, UISearchResultsUpdating, UISearchBarDelegate {    
    var servicesType:[ServicesType] =
    [
        ServicesType(name:"Eletricista", image:"electricity", background:UIColor(red: 128.00/255.0, green: 128.00/255.0, blue: 0.00/255.0, alpha: 1)),
        ServicesType(name:"Pedreiro",image:"pedreiro", background:UIColor.darkGray),
        ServicesType(name:"Salão de Beleza",image:"beleza", background:UIColor.magenta),
        ServicesType(name:"Professor Particular",image:"diploma", background:UIColor.purple),
        ServicesType(name:"Cozinheira",image:"cupcake", background:UIColor.red)
    ]
    
    //searchBar
    var searchController:UISearchController!
    var searchResults:[ServicesType] = []
    
    override func viewDidLoad() {
        super.viewDidLoad()
        
        //Firebase test
        let ref = Database.database().reference(withPath: "teste")
        ref.observe(.value, with: { snapshot in
            print(snapshot.value)
        })
        
        
        // Uncomment the following line to preserve selection between presentations
        // self.clearsSelectionOnViewWillAppear = false

        // Uncomment the following line to display an Edit button in the navigation bar for this view controller.
        // self.navigationItem.rightBarButtonItem = self.editButtonItem()
        
        //default sorting A-Z
        servicesType = servicesType.sorted{$0.name < $1.name}
        
        //SEARCHBAR
        searchController  = UISearchController(searchResultsController: nil)
        tableView.tableHeaderView = searchController.searchBar
        searchController.searchResultsUpdater = self
        searchController.dimsBackgroundDuringPresentation = false
        searchController.searchBar.searchBarStyle = .minimal
        searchController.searchBar.placeholder = "O que você procura?"
        searchController.searchBar.delegate = self
        
        tableView.separatorColor = UIColor.white

        
    }
    
    

    override func didReceiveMemoryWarning() {
        super.didReceiveMemoryWarning()
        // Dispose of any resources that can be recreated.
    }

    // MARK: - Table view data source

    override func numberOfSections(in tableView: UITableView) -> Int {
        // #warning Incomplete implementation, return the number of sections
        return 2
    }

    override func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        switch section {
        case 0:
            return 1
        case 1:
            if searchController.isActive{
                return searchResults.count
            }
            else{
                return servicesType.count
            }
        default:
            return 0
        }
    }

    
    override func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        switch indexPath.section {
        //let this section always visible
        case 0:
            let cell = tableView.dequeueReusableCell(withIdentifier: "AllServicesCell", for: indexPath) as! ServicesTypeTableViewCell
            return cell
        //if searchbar is active, this section is filtered
        case 1:
            let cell = tableView.dequeueReusableCell(withIdentifier: "ServiceTypeCell", for: indexPath) as! ServicesTypeTableViewCell
            
            //check which array to use based in searchController status
            let serviceType = (searchController.isActive) ? searchResults[indexPath.row] : servicesType[indexPath.row]
            
            cell.serviceTypeLabel.text  = serviceType.name
            cell.serviceTypeImageView.image = UIImage(named: serviceType.image)
            cell.serviceBackground.backgroundColor = serviceType.background
            
            
            //cell.backgroundColor = UIColor.red
            return cell
        default:
            let cell = tableView.dequeueReusableCell(withIdentifier: "ServiceTypeCell", for: indexPath) as! ServicesTypeTableViewCell
            return cell //todo bad return
        }
    }
    
    override func tableView(_ tableView: UITableView, heightForRowAt indexPath: IndexPath) -> CGFloat {
        if(indexPath.section == 0){ return 70 }
        return 160
    }
    
    override func tableView(_ tableView: UITableView, didSelectRowAt indexPath: IndexPath) {
        searchController.isActive = false
    }
    

    /*
    // Override to support conditional editing of the table view.
    override func tableView(_ tableView: UITableView, canEditRowAt indexPath: IndexPath) -> Bool {
        // Return false if you do not want the specified item to be editable.
        return true
    }
    */

    /*
    // Override to support editing the table view.
    override func tableView(_ tableView: UITableView, commit editingStyle: UITableViewCellEditingStyle, forRowAt indexPath: IndexPath) {
        if editingStyle == .delete {
            // Delete the row from the data source
            tableView.deleteRows(at: [indexPath], with: .fade)
        } else if editingStyle == .insert {
            // Create a new instance of the appropriate class, insert it into the array, and add a new row to the table view
        }    
    }
    */

    /*
    // Override to support rearranging the table view.
    override func tableView(_ tableView: UITableView, moveRowAt fromIndexPath: IndexPath, to: IndexPath) {

    }
    */

    /*
    // Override to support conditional rearranging of the table view.
    override func tableView(_ tableView: UITableView, canMoveRowAt indexPath: IndexPath) -> Bool {
        // Return false if you do not want the item to be re-orderable.
        return true
    }
    */

    
    // MARK: - Navigation

    // In a storyboard-based application, you will often want to do a little preparation before navigation
    override func prepare(for segue: UIStoryboardSegue, sender: Any?) {
        // Get the new view controller using segue.destinationViewController.
        // Pass the selected object to the new view controller.
        if(segue.identifier == "showService"){
            if let indexPath = tableView.indexPathForSelectedRow{
                let destinationController = segue.destination as! ServicesTableViewController
                destinationController.serviceType = servicesType[indexPath.row]
                
                destinationController.services = destinationController.services.filter({ (Services) -> Bool in
                    return Services.serviceType.name == servicesType[indexPath.row].name
                })
            }
        }
    }
 
    /** SEARCHBAR **/
    func filterContent(for searchText:String){
        searchResults = servicesType.filter({(serviceType)->Bool in
            let name = serviceType.name
            let isMatch = name.localizedCaseInsensitiveContains(searchText)
            return isMatch
            
                //return false
        })
    }
    
    func updateSearchResults(for searchController: UISearchController) {
        if let searchText = searchController.searchBar.text{
            filterContent(for: searchText)  //chamada da funcao
            tableView.reloadData()
        }
    }
    
}
