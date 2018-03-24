//
//  FavoritesTableViewController.swift
//  DoVale Test
//
//  Created by Jimy Suenaga on 20/08/17.
//  Copyright © 2017 Audience Marketing. All rights reserved.
//

import UIKit

class FavoritesTableViewController: UITableViewController {

    //TODO: get this guys from database
    var services:[Services] =
        [
            Services(servicePartnerName:"Jimy Suenaga", servicePartnerAddress:"Rua Joao Teodoro 55, Jacarei",servicePartnerPhone:"3962-7451", servicePreview:"Manutencao Diabolica", servicePartnerProfileImage:"jimy", serviceType: ServicesType(name:"Eletricista", image:"electricity", background: UIColor.green)),
            Services(servicePartnerName:"Juliana Nishi", servicePartnerAddress:"Rua Sao Felipe 48, Jacarei",servicePartnerPhone:"3351-1142", servicePreview:"Master Chef", servicePartnerProfileImage:"juliana", serviceType: ServicesType(name:"Cozinheira", image:"cooking", background: UIColor.red))
    ]
    
    //
    //    var servicesPartnerName = ["Top","Jimy Suenaga"]
    //    var servicesPartnerContact = ["Seul, South Korea, 0800-0000", "Rua Joao Teodoro 55, Jacarei, 3962-7451"]
    //    var servicesPreview = ["Eletricista kpop", "Manutencao Diabolica"]
    //    var servicesPartnerProfileImage = ["top","jimy"]
    
    override func viewDidLoad() {
        super.viewDidLoad()
        
        // Uncomment the following line to preserve selection between presentations
        // self.clearsSelectionOnViewWillAppear = false
        
        // Uncomment the following line to display an Edit button in the navigation bar for this view controller.
        // self.navigationItem.rightBarButtonItem = self.editButtonItem()
    }
    
    override func didReceiveMemoryWarning() {
        super.didReceiveMemoryWarning()
        // Dispose of any resources that can be recreated.
    }
    
    // MARK: - Table view data source
    
    override func numberOfSections(in tableView: UITableView) -> Int {
        // #warning Incomplete implementation, return the number of sections
        return 1
    }
    
    override func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        // #warning Incomplete implementation, return the number of rows
        return services.count
    }
    
    
    override func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        let cell = tableView.dequeueReusableCell(withIdentifier: "ServiceCell", for: indexPath) as! ServicesTableViewCell
        
        cell.servicePartnerName.text = services[indexPath.row].servicePartnerName
        cell.servicePartnerAddress.text = services[indexPath.row].servicePartnerAddress
        cell.servicePreview.text = services[indexPath.row].servicePreview
        cell.servicePartnerProfileImage.image = UIImage(named:services[indexPath.row].servicePartnerProfileImage)
        
        cell.servicePartnerProfileImage.layer.cornerRadius = 40
        cell.servicePartnerProfileImage.clipsToBounds = true
        
        return cell
    }
    
    
    /** SORT TABLEVIEW **/
    func setSort(action: UIAlertAction) {
        if let title = action.title{
            switch title {
            case "A-Z":
                services = services.sorted{$0.servicePartnerName < $1.servicePartnerName}
            case "Z-A":
                services = services.sorted{$0.servicePartnerName > $1.servicePartnerName}
            default:
                let alertController = UIAlertController(title:"Ops! Desculpe!",message:"Ainda nao implementei isso",preferredStyle: .alert)
                alertController.addAction(UIAlertAction(title: "OK", style: .default, handler: nil))
                present(alertController, animated: true, completion: nil)
            }
        }
        
        tableView.reloadData()
    }
    
    @IBAction func sortList(){
        let alertController = UIAlertController(title:"Ordenar por",message:"",preferredStyle: .actionSheet)
        alertController.addAction(UIAlertAction(title:"A-Z", style:UIAlertActionStyle.default, handler:setSort))
        alertController.addAction(UIAlertAction(title:"Z-A", style:UIAlertActionStyle.default, handler:setSort))
        alertController.addAction(UIAlertAction(title:"Mais próximos", style:UIAlertActionStyle.default, handler:setSort))
        alertController.addAction(UIAlertAction(title:"Classificação", style:UIAlertActionStyle.default, handler:setSort))
        alertController.addAction(UIAlertAction(title:"Cancelar", style:UIAlertActionStyle.default, handler:nil))
        present(alertController, animated: true, completion: nil)
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
    
    /*
     // MARK: - Navigation
     
     // In a storyboard-based application, you will often want to do a little preparation before navigation
     override func prepare(for segue: UIStoryboardSegue, sender: Any?) {
     // Get the new view controller using segue.destinationViewController.
     // Pass the selected object to the new view controller.
     }
     */
    
}
