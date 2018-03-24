//
//  MapViewController.swift
//  DoVale Test
//
//  Created by Jimy Suenaga on 20/08/17.
//  Copyright © 2017 Audience Marketing. All rights reserved.
//

import UIKit
import MapKit

class MapViewController: UIViewController{
    
    @IBOutlet var mapView: MKMapView!
    
    //TODO: get this guys from database
    var services:[Services] =
    [
        Services(servicePartnerName:"Top", servicePartnerAddress:"Seul, South Korea, 0800-0000", servicePartnerPhone:"0800-0000", servicePreview:"Eletricista Big Bang", servicePartnerProfileImage:"top", serviceType: ServicesType(name:"Eletricista", image:"electricity", background: UIColor.green)),
        Services(servicePartnerName:"Jimy Suenaga", servicePartnerAddress:"Rua Joao Teodoro 55, Jacarei",servicePartnerPhone:"3962-7451", servicePreview:"Manutencao Diabolica", servicePartnerProfileImage:"jimy", serviceType: ServicesType(name:"Eletricista", image:"electricity", background: UIColor.green)),
        Services(servicePartnerName:"Juliana Nishi", servicePartnerAddress:"Rua Sao Felipe 48, Jacarei",servicePartnerPhone:"3351-1142", servicePreview:"Master Chef", servicePartnerProfileImage:"juliana", serviceType: ServicesType(name:"Cozinheira", image:"cooking", background: UIColor.red))
    ]

    override func viewDidLoad() {
        super.viewDidLoad()
        
        for s in services
        {
            let geoCoder = CLGeocoder()
            geoCoder.geocodeAddressString(s.servicePartnerAddress, completionHandler: {
                placemarks, error in
                
                if let error = error{
                    print(error)
                    return
                }
                
                if let placemarks = placemarks{
                    let placemark = placemarks[0]
                    
                    let annotation = MKPointAnnotation()
                    annotation.title = s.servicePartnerName
                    annotation.subtitle = s.servicePartnerAddress
                    
                    
                    if let location = placemark.location{
                        annotation.coordinate = location.coordinate
                        self.mapView.addAnnotation(annotation)
                        
                        let region = MKCoordinateRegionForMapRect(MKMapRectWorld);
                        self.mapView.setRegion(region, animated:false)
                    }
                }
            })
        }
        
        mapView.showsScale = true
        mapView.isZoomEnabled = true
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
