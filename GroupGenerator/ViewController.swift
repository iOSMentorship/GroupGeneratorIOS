//
//  ViewController.swift
//  GroupGenerator
//
//  Created by Kayode Oguntimehin on 09/03/2017.
//  Copyright © 2017 Kayode Oguntimehin. All rights reserved.
//

import UIKit
import Foundation;

class ViewController: UIViewController, UITextFieldDelegate,UITableViewDataSource, UITableViewDelegate{
    
    @IBOutlet weak var numberTextView: UITextField!
    var namesOfPeople = [String]()
    @IBOutlet weak var nameTextField: UITextField!
    
    @IBOutlet weak var addNameBtn: UIButton!
    
    @IBOutlet weak var namesToGroupTable: UITableView!

    @IBOutlet weak var submitNamesBtn: UIButton!
    var images: [UIImage] = []
    
   
    let tableIdentifier = "nameToGroupIdentifier"
    @IBOutlet weak var totalnamesaddedLabel: UILabel!
    let groupgeneratedIdentifier = "showGroups"

    
    override func viewDidLoad() {
        super.viewDidLoad()
        nameTextField.delegate = self
        numberTextView.delegate = self
        
        images = [
            UIImage(named: "avatar1.png")!,
            UIImage(named: "avatar2.png")!,
            UIImage(named: "avatar3.png")!,
            UIImage(named: "avatar4.jpg")!,
            UIImage(named: "avatar5.png")!
        ]
      
        //setup View Styles
        setupView()
    }
    

    override func didReceiveMemoryWarning() {
        super.didReceiveMemoryWarning()
        // Dispose of any resources that can be recreated.
        
    }
    
     func numberOfSections(in tableView: UITableView) -> Int {
        var sections: Int = 0
        if namesOfPeople.count > 0
        {
            tableView.separatorStyle = .singleLine
            tableView.separatorColor = UIColor.blue
            sections = 1
            tableView.backgroundView = nil
        }
        else
        {
            emptyResult(tableView: tableView, message: "There are no name to place in groups")
        }
        return sections
    }
    
    
    func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        return namesOfPeople.count
        
    }
    
    func tableView(_ tableView: UITableView, titleForHeaderInSection section: Int) -> String? {
        return "";
    }
    
    func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        let cell = tableView.dequeueReusableCell(withIdentifier: tableIdentifier, for: indexPath) as! GroupTableViewCell
        
        //generate random number between  0 and 5 (i only have 5 avatars)
        let randomNum:Int = Int(arc4random_uniform(5))
        
        let namePeople = namesOfPeople[indexPath.row]
        cell.userNameLabel.text = namePeople
        cell.userIcon.image = images[randomNum]
        cell.removeUserBut.tag = indexPath.row
        cell.removeUserBut.addTarget(self, action: #selector(ViewController.deleteName(sender:)), for: .touchUpInside)
        
        cell.tag = indexPath.row
        
        return cell
    }
    

    func tableView(_ tableView: UITableView, didSelectRowAt indexPath: IndexPath) {
        
    }
    
    func setupView() {
        addNameBtn.backgroundColor = UIColor.gray
        
        let blue = UIColor(red: 100.0/255.0, green: 130.0/255.0, blue: 230.0/255.0, alpha: 1.0)
        
        nameTextField.layer.borderColor = blue.cgColor
        UITextField.appearance().tintColor = UIColor.black
        nameTextField.layer.borderWidth = 1.0;
        nameTextField.layer.cornerRadius = 5.0;
        namesToGroupTable.layer.borderColor = blue.cgColor
        namesToGroupTable.layer.borderWidth = 1.0;
        namesToGroupTable.layer.cornerRadius = 5.0;
        
        numberTextView.layer.borderColor = blue.cgColor
        numberTextView.layer.borderWidth = 1.0;
        numberTextView.layer.cornerRadius = 5.0;
        
        
        addNameBtn.layer.borderColor = blue.cgColor
        addNameBtn.layer.backgroundColor = blue.cgColor
        addNameBtn.layer.borderWidth = 1.0
        addNameBtn.layer.cornerRadius = 5.0
        
        submitNamesBtn.layer.borderColor = blue.cgColor
        submitNamesBtn.layer.backgroundColor = blue.cgColor
        submitNamesBtn.layer.borderWidth = 1.0
        submitNamesBtn.layer.cornerRadius = 5.0
        
        namesToGroupTable.contentInset = UIEdgeInsetsMake(0, -15, 0, 0);
        
    }
    
    
    func callAlert(title:String, actionTitle:String, message:String) {
        let alertController = UIAlertController(title: title, message: message, preferredStyle: UIAlertControllerStyle.alert)
        alertController.addAction(UIAlertAction(title: actionTitle, style: UIAlertActionStyle.default, handler: nil))
        present(alertController, animated: true, completion: nil)
    }
    
    @IBAction func addNameAction() {
        
        let name_of_people: String = nameTextField.text!
        if nameTextField.text == ""{
            callAlert(title: "Error", actionTitle: "close", message: "Name field cannot be empty")
        } else if namesOfPeople.contains(name_of_people) {
            callAlert(title: "Error", actionTitle: "close", message: "Name already exist")
        } else {
            namesOfPeople.append(name_of_people)
            nameTextField.text = ""
            print(namesOfPeople)
            namesToGroupTable.reloadData()
            displayTotalNamesAdded()
        }
        
    }
    
    @IBAction func submitAction() {
        if(numberTextView.text == "") {
            callAlert(title: "Error", actionTitle: "close", message: "Please enter number of people per group")
        } else if(Int(numberTextView.text!) == nil) {
            callAlert(title: "Error", actionTitle: "close", message: "A number value is required here")
        } else if (Int(numberTextView.text!)! > namesOfPeople.count) {
            callAlert(title: "Error", actionTitle: "close", message: "Number of people per group cannot be greater than number of people to group, please check again")
            
        } else if(namesOfPeople.count <= 0) {
            callAlert(title: "Error", actionTitle: "close", message: "No name to group. Please add names")
        } else {
            self.performSegue(withIdentifier: groupgeneratedIdentifier, sender: self)
        }
    }

    
    func deleteName(sender : UIButton) {
        namesOfPeople.remove(at: sender.tag)
        namesToGroupTable.reloadData()
        displayTotalNamesAdded()
    }

    
    private func textViewDidBeginEditing(textView: UITextView) {
        numberTextView.text = ""
        nameTextField.text = ""
    }
    
    override func prepare(for segue: UIStoryboardSegue, sender: Any?)
    {
        if (segue.identifier == groupgeneratedIdentifier ) {
            let nextController: GroupsController = segue.destination as! GroupsController
            nextController.mygroups = convertToString()
        }
            
    }
    
    func convertToString() -> String {
        let test: GroupGenerator = GroupGenerator()
        let groups: [PairModel] = test.GroupPeople(namesToGroup: namesOfPeople, noPerGroup: Int(numberTextView.text!)!)
        
        var returnString: String = "The groups generated are: \n\n "
        var index: Int = 1
        for value in groups {
            let newString: String = "Group "+String(index) + " - "+value.ToString() + "\n\n "
            returnString += newString
            index = index + 1
        }
      return returnString
    }
    
    func formatNumberAdded(numberAdded: Int) -> String {
        if(numberAdded <= 1) {
            return String(numberAdded)+" name added".capitalized
        } else {
            return String(numberAdded)+" names added".capitalized
        }
    }
    
    func emptyResult(tableView: UITableView, message: String) {
        let emptyNameLabel: UILabel     = UILabel(frame: CGRect(x: 0, y: 0, width: tableView.bounds.size.width, height: tableView.bounds.size.height))
        emptyNameLabel.text          = message
        emptyNameLabel.textColor     = UIColor.gray
        emptyNameLabel.textAlignment = .center
        tableView.backgroundView  = emptyNameLabel
        tableView.separatorStyle  = .none
    }
    
    func displayTotalNamesAdded(){
        totalnamesaddedLabel.text = ""
        totalnamesaddedLabel.text = formatNumberAdded(numberAdded: namesOfPeople.count)
        
    }


    
}
