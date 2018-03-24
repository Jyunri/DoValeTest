//
//  ServicesTableViewController.swift
//  DoVale Test
//
//  Created by Jimy Suenaga on 19/08/17.
//  Copyright © 2017 Audience Marketing. All rights reserved.
//

import UIKit
import CoreData

class ServicesTableViewController: UITableViewController {

    //TODO: get this guys from database
    var services:[Services] =
    [
        Services(servicePartnerName:"Alan Walker", servicePartnerAddress:"Northamptom, England, 0800-0000", servicePartnerPhone:"0800-0000", servicePreview:"Electric Faded", servicePartnerProfileImage:"aw", serviceType: ServicesType(name:"Eletricista", image:"electricity", background: UIColor.green)),
        Services(servicePartnerName:"Jimy Suenaga", servicePartnerAddress:"Rua Joao Teodoro 55, Jacarei",servicePartnerPhone:"3962-7451", servicePreview:"Manutencao Diabolica", servicePartnerProfileImage:"jimy", serviceType: ServicesType(name:"Eletricista", image:"electricity", background: UIColor.green)),
        Services(servicePartnerName:"Juliana Nishi", servicePartnerAddress:"Rua Sao Felipe 48, Jacarei",servicePartnerPhone:"3351-1142", servicePreview:"Master Chef", servicePartnerProfileImage:"juliana", serviceType: ServicesType(name:"Cozinheira", image:"cooking", background: UIColor.red))
    ]
    
    var serviceType:ServicesType!
    var cosmosView:CosmosView!
    
//    
//    var servicesPartnerName = ["Top","Jimy Suenaga"]
//    var servicesPartnerContact = ["Seul, South Korea, 0800-0000", "Rua Joao Teodoro 55, Jacarei, 3962-7451"]
//    var servicesPreview = ["Eletricista kpop", "Manutencao Diabolica"]
//    var servicesPartnerProfileImage = ["top","jimy"]
    
    override func viewDidLoad() {
        super.viewDidLoad()
        
        //CoreData access
        let appDelegate = UIApplication.shared.delegate as! AppDelegate
        let context = appDelegate.persistentContainer.viewContext
        
//        //Create test object for CoreData
//        let service = NSEntityDescription.insertNewObject(forEntityName: "ServiceModel", into: context)
//        service.setValue("TestService", forKey: "servicePartnerName")
//        
//        //Saving CoreData object
//        do {
//            try context.save()
//            print("Saved data")
//        } catch {
//            print("Save error")
//        }
        
        //Load test from CoreData
        let request = NSFetchRequest<NSFetchRequestResult>(entityName: "ServiceModel")
        
        
        //Sorting data from A-Z
        let alphabeticalSort = NSSortDescriptor(key: "servicePartnerName", ascending: true)
        request.sortDescriptors = [alphabeticalSort]
        
        do {
            let servicesFetched = try context.fetch(request)
            
            if servicesFetched.count > 0 {
                for s in servicesFetched as! [NSManagedObject] {
                    if let servicePartnerName = s.value(forKey: "servicePartnerName"){
                        print(servicePartnerName)
                        
                        //updating test from CoreData
                        s.setValue("UpdatedName", forKey: "servicePartnerName")
                        
                        //Saving CoreData object
                        do {
                            try context.save()
                            print("Updated data")
                        } catch {
                            print("Update error")
                        }
                        
                    }
                }
            }else{
                print("No users fetched")
            }
        } catch {
            print("Load error")
        }

        //default sorting A-Z
        services = services.sorted{$0.servicePartnerName < $1.servicePartnerName}
        
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
        cell.serviceRating.rating = Double(services[indexPath.row].serviceRating)
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
    
    
    
    override func tableView(_ tableView: UITableView, editActionsForRowAt indexPath: IndexPath) -> [UITableViewRowAction]? {
        
        let favStatus = services[indexPath.row].isFavorite ? true : false
        let favTitle = favStatus ? "Desfavoritar" : "Favoritar"
        let newFavStatus = !favStatus
        
        let favoriteAction = UITableViewRowAction(style: UITableViewRowActionStyle.default, title: favTitle,handler: { (action, indexPath) -> Void in
            self.services[indexPath.row].isFavorite = newFavStatus
            tableView.setEditing(false, animated: true)
        })
        
        
        favoriteAction.backgroundColor = favStatus ? UIColor.lightGray : UIColor.red
        
        return [favoriteAction]
    }
    
    private func callNumber(phoneNumber:String) {
        if let phoneCallURL = URL(string: "tel://\(phoneNumber)") {
            
            let application:UIApplication = UIApplication.shared
            if (application.canOpenURL(phoneCallURL)) {
                application.open(phoneCallURL, options: [:], completionHandler: nil)
            }
            else{
                let alertController = UIAlertController(title:"Ops! Desculpe!",message:"Telefone inválido",preferredStyle: .alert)
                alertController.addAction(UIAlertAction(title: "OK", style: .default, handler: nil))
                present(alertController, animated: true, completion: nil)
            }
        }
    }
    
    private func rateService(row: Int) {
        performSegue(withIdentifier: "rateService", sender: self)
        
        let alertController = UIAlertController(title:"Ops! Desculpe!",message:"Ainda nao implementei isso",preferredStyle: .alert)
        alertController.addAction(UIAlertAction(title: "OK", style: .default, handler: nil))
        present(alertController, animated: true, completion: nil)
    }
    
    @IBAction func close(segue:UIStoryboardSegue){
        
    }
    
    private func moreInfo(){
        let request = NSMutableURLRequest(url: NSURL(string: "http://cheapit1.tempsite.ws/query/page_offers_json_jimy.php")! as URL)
        request.httpMethod = "POST"
//
//        let postString = "a=\(name.text!)&b=\(age.text!)"
//        
//        
        let postString = ""
        
        request.httpBody = postString.data(using: String.Encoding.utf8)
        
        let task = URLSession.shared.dataTask(with: request as URLRequest) {
            data, response, error in
            
            if error != nil {
                print("error=\(String(describing: error))")
                return
            }
            
            print("response = \(String(describing: response))")
            
            let responseString = NSString(data: data!, encoding: String.Encoding.utf8.rawValue)
            print("responseString = \(String(describing: responseString))")
        }
        task.resume()
//
//        
//        let alertController = UIAlertController(title: "Candidate's Name", message:
//            "Successfully Added", preferredStyle: UIAlertControllerStyle.alert)
//        alertController.addAction(UIAlertAction(title: "OK", style: UIAlertActionStyle.default,handler: nil))
//        
//        self.present(alertController, animated: true, completion: nil)
//        
//        age.text = ""
//        name.text = ""
        
    }
    
    
    override func tableView(_ tableView: UITableView, didSelectRowAt indexPath: IndexPath) {
        // CreateOptionMenu
        let optionMenu = UIAlertController(title: nil, message: "O que você deseja fazer?", preferredStyle: .actionSheet)
        
        // Add Actions
        let callAction = UIAlertAction(title: "Ligar", style: .default, handler:{action in
            self.callNumber(phoneNumber: self.services[indexPath.row].servicePartnerPhone)
        })
        optionMenu.addAction(callAction)
        
        let rateAction = UIAlertAction(title: "Avaliar", style: .default, handler: {action in
            self.rateService(row: indexPath.row)
            self.tableView.reloadRows(at: [indexPath], with: UITableViewRowAnimation.none)
        })
        optionMenu.addAction(rateAction)
        
        let favoriteAction = UIAlertAction(title: "Favoritar", style: .default, handler: {(action:UIAlertAction) -> Void in
                let alertMessage = UIAlertController(title:"Ops! Desculpe!", message: "Ainda nao implementei isso", preferredStyle: .alert)
                alertMessage.addAction(UIAlertAction(title: "OK", style: .default, handler: nil))
                self.present(alertMessage, animated: true, completion: nil)
        })
        optionMenu.addAction(favoriteAction)
        
        let infoAction = UIAlertAction(title: "Mais Informações", style: .default, handler: {(action:UIAlertAction) -> Void in
            self.moreInfo()
            let alertMessage = UIAlertController(title:"Ops! Desculpe!", message: "Ainda nao implementei isso", preferredStyle: .alert)
            alertMessage.addAction(UIAlertAction(title: "OK", style: .default, handler: nil))
            self.present(alertMessage, animated: true, completion: nil)
        })
        optionMenu.addAction(infoAction)
        
        let cancelAction = UIAlertAction(title: "Cancelar", style: .cancel,  handler: nil)
        optionMenu.addAction(cancelAction)
        
        //Display the Menu
        present(optionMenu, animated:true,completion:nil)
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
        if(segue.identifier == "rateService"){
            if let indexPath = tableView.indexPathForSelectedRow{
                let destinationController = segue.destination as! RateServiceViewController
                destinationController.tmp_serviceImage = services[indexPath.row].servicePartnerProfileImage
                destinationController.tmp_serviceName = services[indexPath.row].servicePartnerName
            }
        }
    }
 

}
