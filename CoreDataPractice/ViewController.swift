//
//  ViewController.swift
//  CoreDataPractice
//
//  Created by apple on 18/01/19.
//  Copyright © 2019 iOSProofs. All rights reserved.
//

import UIKit

class ViewController: UIViewController {

    @IBOutlet weak var carsListView: UITableView!
    
    var carsArray: [Car] = []
    
    override func viewDidLoad() {
        super.viewDidLoad()
        carsArray = CoreDataManager.shared.fetchCars()
        carsListView.reloadData()        
    }
    
    @IBAction func newCarAdded(segue: UIStoryboardSegue) {
        let ceVC = segue.source as! CarEntryViewController
        print(ceVC.brandTF.text!)
        print(ceVC.modelTF.text!)
        
        
        guard let modelString = ceVC.modelTF.text, let model = Int64(modelString) else {
            return
        }
        
        let newCar = Car(context: CoreDataManager.shared.context)
        newCar.brand = ceVC.brandTF.text ?? "No Brand Found"
        newCar.model = model
        CoreDataManager.shared.save()
        
        carsArray.removeAll()
        carsArray = CoreDataManager.shared.fetchCars()
        carsListView.reloadData()
    }
}

extension ViewController: UITableViewDelegate, UITableViewDataSource {
    
    func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        return carsArray.count
    }
    
    func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        let cell = tableView.dequeueReusableCell(withIdentifier: "CarCell")
        let aCar = carsArray[indexPath.row]
        
        cell?.textLabel?.text = "\(aCar.model)"
        cell?.detailTextLabel?.text = aCar.brand
        return cell ?? UITableViewCell()
    }
}
