//
//  PersonViewController.swift
//  PracticalChallenge
//
//  Created by Max Pirotais-Wilton on 11/08/22.
//

import UIKit

class PersonViewController: UIViewController {
    
    //MARK: - Outlets
    
    @IBOutlet weak var image: UIImageView!
    @IBOutlet weak var nameLabel: UILabel!
    @IBOutlet weak var dobLabel: UILabel!
    @IBOutlet weak var genderLabel: UILabel!
    @IBOutlet weak var emailLabel: UILabel!
    @IBOutlet weak var phoneLabel: UILabel!
    @IBOutlet weak var cellLabel: UILabel!
    
    //MARK: - Properties
    
    var person: Person!
    
    override func viewDidLoad() {
        super.viewDidLoad()
    }
    
    override func viewWillAppear(_ animated: Bool) {
        
        let dateFormatter = DateFormatter()
        
        dateFormatter.dateFormat = "dd/MM/yyyy"
        
        image.load(url: URL(string: person.fullPictureURL)!)
        nameLabel.text = person.title + " " + person.fName + " " + person.lName
        dobLabel.text = "Born: " + dateFormatter.string(from: person.dob)
        genderLabel.text = person.gender
        emailLabel.text = person.email
        phoneLabel.text = person.phone
        cellLabel.text = person.cell
    }
    
}

