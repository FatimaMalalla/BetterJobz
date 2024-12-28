//
//  SearchViewController.swift
//  BetterJobzApp
//
//  Created by BP-36-201-15 on 27/12/2024.
//

import UIKit

class SearchViewController: UIViewController, UITableViewDelegate, UITableViewDataSource, UISearchBarDelegate {
    
    
    @IBOutlet weak var searchBAR: UISearchBar!
    @IBOutlet weak var cellL: UITableView!
    @IBOutlet weak var filtterButtonn: UIButton!

        
        var allData: [Jopss] = [
            Jopss(name: "Software Engineer by AWS", keyword: "Amazon Web Services", company: "AWS", industry: "IT", jobType: "Full-Time", experience: "Entry-Level", location: "Remote"),
            Jopss(name: "Engineer by NovaTech", keyword: "NovaTech Solutions", company: "NovaTech", industry: "Engineering", jobType: "Part-Time", experience: "Mid-Level", location: "Hybrid"),
            Jopss(name: "Teacher by Green Valley International School", keyword: "Green Valley International School", company: "Green Valley", industry: "Academic", jobType: "Internship", experience: "Entry-Level", location: "On site"),
            Jopss(name: "Chef by Golden Spoon Restaurant", keyword: "Golden Spoon Restaurant", company: "Golden Spoon", industry: "Culinary", jobType: "Full-Time", experience: "Manager", location: "On site")
        ]

        var filteredData: [Jopss] = []
        var selectedFilters: [String: String]?

        override func viewDidLoad() {
            super.viewDidLoad()

            // Initialize filteredData
            filteredData = allData

            // Apply filters if available
            applyFilters()

            // Set the table view delegate and data source
            cellL.delegate = self
            cellL.dataSource = self

            // Set the search bar delegate
            searchBAR.delegate = self

            // Register the UITableViewCell class
            cellL.register(UITableViewCell.self, forCellReuseIdentifier: "cell")
        }

        func applyFilters() {
            if let filters = selectedFilters {
                filteredData = allData.filter { job in
                    (filters["Industry"] == nil || job.industry == filters["Industry"]) &&
                    (filters["Job Type"] == nil || job.jobType == filters["Job Type"]) &&
                    (filters["Experience"] == nil || job.experience == filters["Experience"]) &&
                    (filters["Location"] == nil || job.location == filters["Location"])
                }
            } else {
                filteredData = allData
            }
            cellL.reloadData()
        }

        // MARK: - UITableViewDelegate, UITableViewDataSource
        func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
            return filteredData.count
        }

        func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
            let cell = tableView.dequeueReusableCell(withIdentifier: "cell", for: indexPath)
            let job = filteredData[indexPath.row]
            cell.textLabel?.text = job.name
            return cell
        }

        // MARK: - UISearchBarDelegate
        func searchBar(_ searchBar: UISearchBar, textDidChange searchText: String) {
            if searchText.isEmpty {
                applyFilters()
            } else {
                filteredData = filteredData.filter { job in
                    job.name.lowercased().contains(searchText.lowercased()) ||
                    job.keyword.lowercased().contains(searchText.lowercased()) ||
                    job.company.lowercased().contains(searchText.lowercased()) ||
                    job.industry.lowercased().contains(searchText.lowercased()) ||
                    job.jobType.lowercased().contains(searchText.lowercased()) ||
                    job.experience.lowercased().contains(searchText.lowercased()) ||
                    job.location.lowercased().contains(searchText.lowercased())
                }
            }
            cellL.reloadData()
        }

        // MARK: - UITableViewDelegate - Handle row selection
        func tableView(_ tableView: UITableView, didSelectRowAt indexPath: IndexPath) {
            let job = filteredData[indexPath.row]

            // Determine the destination based on job type or another attribute
            if job.name.lowercased().contains("software engineer") {
                navigateToSoftwareEngineerViewController()
            } else if job.name.lowercased().contains("engineer") {
                navigateToEngineerViewController()
            } else if job.name.lowercased().contains("teacher") {
                navigateToTeacherViewController()
            } else if job.name.lowercased().contains("chef") {
                navigateToChefViewController()
            }
        }

        // MARK: - Navigation Methods
        func navigateToSoftwareEngineerViewController() {
            let storyboard = UIStoryboard(name: "Main", bundle: nil)
            if let vc = storyboard.instantiateViewController(withIdentifier: "SoftwareEngineerViewController") as? SoftwareEngineerViewController {
                navigationController?.pushViewController(vc, animated: true)
            }
        }

        func navigateToEngineerViewController() {
            let storyboard = UIStoryboard(name: "Main", bundle: nil)
            if let vc = storyboard.instantiateViewController(withIdentifier: "EngineerViewController") as? EngineerViewController {
                navigationController?.pushViewController(vc, animated: true)
            }
        }

        func navigateToTeacherViewController() {
            let storyboard = UIStoryboard(name: "Main", bundle: nil)
            if let vc = storyboard.instantiateViewController(withIdentifier: "TeacherViewController") as? TeacherViewController {
                navigationController?.pushViewController(vc, animated: true)
            }
        }

        func navigateToChefViewController() {
            let storyboard = UIStoryboard(name: "Main", bundle: nil)
            if let vc = storyboard.instantiateViewController(withIdentifier: "ChefViewController") as? ChefViewController {
                navigationController?.pushViewController(vc, animated: true)
            }
        }
    }
