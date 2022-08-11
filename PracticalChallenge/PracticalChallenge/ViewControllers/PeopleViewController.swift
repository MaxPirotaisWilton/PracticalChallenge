//
//  ViewController.swift
//  PracticalChallenge
//
//  Created by Max Pirotais-Wilton on 10/08/22.
//

import UIKit

class PeopleViewController: UIViewController {

    //MARK: - Outlets
        
    @IBOutlet weak var peopleTable: UITableView!
        
    //MARK: - Properties
        
    var People : [Person] = []
    let netManager = NetworkManager()
    
    override func viewDidLoad() {
        super.viewDidLoad()
        
        //Manually set table height
        peopleTable.rowHeight = 140
        
        netManager.callAPI(number: 6,pagination: false) { [weak self] (results) in
            self?.People = ModelToPeople(results: results)

          // Reload the table view using the main dispatch queue
          DispatchQueue.main.async {
            self?.peopleTable.reloadData()
          }
        }
    }
    
    //if looking into a detail of a session, assign the selected value to the next view controller's global variable
    override func prepare(for segue: UIStoryboardSegue, sender: Any?) {
        if let destination = segue.destination as? PersonViewController,
           let indexPath = peopleTable.indexPathForSelectedRow{
            destination.person = People[indexPath.row]
        }
    }
    
}

//MARK: - UITableViewDataSource
extension PeopleViewController: UITableViewDataSource {
    
    func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        //return number of rows
        return People.count
    }

    
    func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        let cell = tableView.dequeueReusableCell(withIdentifier: "PersonCell", for: indexPath) as! PeopleTableViewCell
        // Configuring the cell...
        let person: Person = People[indexPath.row]
        
        let dateFormatter = DateFormatter()
        
        dateFormatter.dateFormat = "dd/MM/yyyy"
        
        cell.thumbnailImageView.load(url: URL(string: person.thumbnailURL)!)
        cell.nameTitleLabel.text = person.title + " " + person.fName + " " + person.lName
        cell.genderLabel.text = person.gender
        cell.dobLabel.text = "Born: " + dateFormatter.string(from: person.dob)
        
        return cell
    }
    
}

//class for the custom tableview cell for results
class PeopleTableViewCell: UITableViewCell {
    
    @IBOutlet weak var thumbnailImageView: UIImageView!
    @IBOutlet weak var nameTitleLabel: UILabel!
    @IBOutlet weak var genderLabel: UILabel!
    @IBOutlet weak var dobLabel: UILabel!
    
}

//MARK: -UITableViewDelegate,UIScrollViewDelegate
extension PeopleViewController: UITableViewDelegate, UIScrollViewDelegate{
    
    func scrollViewDidScroll(_ scrollView: UIScrollView) {
        let position = scrollView.contentOffset.y
        if position > (peopleTable.contentSize.height-100-scrollView.frame.size.height){
            print("Time for more data!")
            guard !netManager.isPaginating else {
                return
            }
            netManager.callAPI(number: 3,pagination: true) { [weak self] (results) in
                self?.People.append(contentsOf: ModelToPeople(results: results))

              // Reload the table view using the main dispatch queue
              DispatchQueue.main.async {
                self?.peopleTable.reloadData()
              }
            }
        }
    }
    
}
