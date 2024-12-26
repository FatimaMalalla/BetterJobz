//
//  FilterViewController.swift
//  BetterJobzApp
//
//  Created by BP-36-201-15 on 26/12/2024.
//

import UIKit

class FilterViewController: UIViewController {


    @IBOutlet weak var itButton: UIButton!
    @IBOutlet weak var academicButton: UIButton!
    @IBOutlet weak var culinaryButton: UIButton!
    @IBOutlet weak var engineeringButton: UIButton!
    @IBOutlet weak var creativeMediaButton: UIButton!
    
    
    @IBOutlet weak var fullTimeButton: UIButton!
    @IBOutlet weak var partTimeButton: UIButton!
    @IBOutlet weak var intershipButton: UIButton!
    @IBOutlet weak var freelanceButton: UIButton!
    
    
    @IBOutlet weak var enterLevelButton: UIButton!
    @IBOutlet weak var midLevelButton: UIButton!
    @IBOutlet weak var seniorLevelButton: UIButton!
    @IBOutlet weak var managerButton: UIButton!
    @IBOutlet weak var executiveButton: UIButton!
    
    
    @IBOutlet weak var onSiteButton: UIButton!
    @IBOutlet weak var remoteButton: UIButton!
    @IBOutlet weak var hybridButton: UIButton!
    
    
    @IBOutlet weak var applyButton: UIButton!
    @IBOutlet weak var clearFilter: UIButton!
    
    

    
    var selectedFilters: [String: Set<String>] = [
           "Industry": [],
           "JobType": [],
           "Experience": [],
           "Location": []
       ]

       var allData: [Jopss] = [
           Jopss(name: "Software Engineer by AWS", keyword: "Amazon Web Services", company: "AWS", industry: "IT", jobType: "Full-Time", experience: "Entry-Level", location: "Remote"),
           Jopss(name: "Engineer by NovaTech", keyword: "NovaTech Solutions", company: "NovaTech", industry: "Engineering", jobType: "Part-Time", experience: "Mid-Level", location: "Hybrid"),
           Jopss(name: "Teacher by Green Valley International School", keyword: "Green Valley International School", company: "Green Valley", industry: "Academic", jobType: "Internship", experience: "Entry-Level", location: "On site"),
           Jopss(name: "Chef by Golden Spoon Restaurant", keyword: "Golden Spoon Restaurant", company: "Golden Spoon", industry: "Culinary", jobType: "Full-Time", experience: "Manager", location: "On site")
       ]

       override func viewDidLoad() {
           super.viewDidLoad()
           setupButtons()
       }

       func setupButtons() {
           let buttons: [UIButton] = [
               itButton, academicButton, culinaryButton, engineeringButton, creativeMediaButton,
               fullTimeButton, partTimeButton, intershipButton, freelanceButton,
               enterLevelButton, midLevelButton, seniorLevelButton, managerButton, executiveButton,
               onSiteButton, remoteButton, hybridButton
           ]
           
           buttons.forEach { button in
               button.addTarget(self, action: #selector(toggleButton(_:)), for: .touchUpInside)
           }
       }

       @objc func toggleButton(_ sender: UIButton) {
           sender.isSelected.toggle()
           sender.backgroundColor = sender.isSelected ? .systemBlue : .systemGray4

           if let title = sender.titleLabel?.text {
               updateSelectedFilters(for: sender, title: title)
           }
       }

       func updateSelectedFilters(for button: UIButton, title: String) {
           switch button {
           case itButton, academicButton, culinaryButton, engineeringButton, creativeMediaButton:
               toggleFilter(category: "Industry", value: title)
           case fullTimeButton, partTimeButton, intershipButton, freelanceButton:
               toggleFilter(category: "JobType", value: title)
           case enterLevelButton, midLevelButton, seniorLevelButton, managerButton, executiveButton:
               toggleFilter(category: "Experience", value: title)
           case onSiteButton, remoteButton, hybridButton:
               toggleFilter(category: "Location", value: title)
           default:
               break
           }
       }

       func toggleFilter(category: String, value: String) {
           if selectedFilters[category]?.contains(value) == true {
               selectedFilters[category]?.remove(value)
           } else {
               selectedFilters[category]?.insert(value)
           }
       }

       @IBAction func applyFilters(_ sender: UIButton) {
           let filteredData = allData.filter { job in
               (selectedFilters["Industry"]?.contains(job.industry) ?? true) &&
               (selectedFilters["JobType"]?.contains(job.jobType) ?? true) &&
               (selectedFilters["Experience"]?.contains(job.experience) ?? true) &&
               (selectedFilters["Location"]?.contains(job.location) ?? true)
           }
           navigateToSearchViewController(with: filteredData)
       }

       func navigateToSearchViewController(with filteredData: [Jopss]) {
           guard let searchVC = storyboard?.instantiateViewController(identifier: "SearchViewController") as? SearchViewController else { return }
           searchVC.filteredData = filteredData
           navigationController?.pushViewController(searchVC, animated: true)
       }
   }
