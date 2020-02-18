//
//  StudentsenderController.swift
//  NewProjectAuth
//
//  Created by Anastasiya Laptseva on 2/18/20.
//  Copyright © 2020 Anastasiya Laptseva. All rights reserved.
//
/*
import UIKit

class StudentsViewController: UIViewController, UITableViewDelegate, UITableViewDataSource {
    
    var array = [String]()
    func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        array.count
    }
    
    func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        var cell: UITableViewCell
            if indexPath.row % 2 == 0 {
                cell = tableView.dequeueReusableCell(withIdentifier: "red", for: indexPath)
            } else {
                cell = tableView.dequeueReusableCell(withIdentifier: "blue", for: indexPath)
        
            }
            cell.textLabel?.text = data[indexPath.row]
            return cell
    }
    

    
    
    
    override func viewDidLoad() {
        super.viewDidLoad()

        // Do any additional setup after loading the view.
    }
    

    
    // MARK: - Navigation

    // In a storyboard-based application, you will often want to do a little preparation before navigation
    override func prepare(for segue: UIStoryboardSegue, sender: Any?) {
        
        
        // Get the new view controller using segue.destination.
        // Pass the selected object to the new view controller.
    }
  

    func prepareArray() ->  {
        let path = Bundle.main.path(forResource: "Names", ofType: "txt")
}
  
    struct Student {
        var name: String
        var surname: String = "value"
        var age: String = "value"
        var info: String = "value"
        var gender: Gender = .preferNotToSay
        
        enum Gender {
            case mele, female, preferNotToSay
        }
}
    
    

}
 /**/*/
