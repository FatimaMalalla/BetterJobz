//
//  JoblistViewController.swift
//  BetterJobzApp
//
//  Created by BP-36-201-15 on 27/12/2024.
//

import UIKit





class JoblistViewController: UIViewController, UITableViewDelegate, UITableViewDataSource, UISearchBarDelegate {

    @IBOutlet weak var jobSearchh: UISearchBar!
    @IBOutlet weak var jobList: UITableView!



        // Sample job data
        var allData: [jmpstructlist] = [
            jmpstructlist(name: "John Doe", keyword: "Graduate", company: "AWS", industry: "IT", jobType: "Full-Time", experience: "Entry-Level", location: "Remote"),
            jmpstructlist(name: "Tariq Afandi", keyword: "Student", company: "AWS", industry: "IT", jobType: "Full-Time", experience: "Entry-Level", location: "Remote")
        ]

        var filteredData: [jmpstructlist] = []
        var selectedFilters: [String: String]?

        override func viewDidLoad() {
            super.viewDidLoad()

            filteredData = allData
            applyFilters()

            jobList.delegate = self
            jobList.dataSource = self
            jobSearchh.delegate = self

            jobList.register(UITableViewCell.self, forCellReuseIdentifier: "JobCell")

            // Customizing back button for the next view controller
            let backButton = UIBarButtonItem()
            backButton.title = "Back"
            navigationItem.backBarButtonItem = backButton
        }

        // Apply filters if any are selected
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
            jobList.reloadData()
        }

        // MARK: - TableView DataSource Methods

        func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
            return filteredData.count
        }

        func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
            let cell = tableView.dequeueReusableCell(withIdentifier: "JobCell", for: indexPath)
            let job = filteredData[indexPath.row]
            cell.textLabel?.text = job.name
            return cell
        }

        // MARK: - TableView Delegate Method

        func tableView(_ tableView: UITableView, didSelectRowAt indexPath: IndexPath) {
            let selectedJob = filteredData[indexPath.row]
            
            // Instantiate the storyboard and select the correct view controller
            let storyboard = UIStoryboard(name: "Main", bundle: nil)

            // Check the selected job and navigate to the appropriate view controller
            if selectedJob.name == "John Doe" {
                if let useroneVC = storyboard.instantiateViewController(withIdentifier: "UseroneViewController") as? UseroneViewController {
                    useroneVC.jobData = selectedJob
                    navigationController?.pushViewController(useroneVC, animated: true)
                }
            } else if selectedJob.name == "Tariq Afandi" {
                if let usertwoVC = storyboard.instantiateViewController(withIdentifier: "UsertwoViewController") as? UsertwoViewController {
                    usertwoVC.jobData = selectedJob
                    navigationController?.pushViewController(usertwoVC, animated: true)
                }
            }
        }

        // MARK: - UISearchBar Delegate Methods

        func searchBar(_ searchBar: UISearchBar, textDidChange searchText: String) {
            // If search text is empty, show all data or apply filters if any
            if searchText.isEmpty {
                applyFilters()
            } else {
                filteredData = allData.filter { job in
                    job.name.lowercased().contains(searchText.lowercased()) ||
                    job.keyword.lowercased().contains(searchText.lowercased()) ||
                    job.company.lowercased().contains(searchText.lowercased())
                }
                // Optionally, you could still apply filters after the search text is applied
                applyFilters()
            }
            jobList.reloadData()
        }

        func searchBarCancelButtonClicked(_ searchBar: UISearchBar) {
            // Reset the filtered data when the user clicks "Cancel"
            filteredData = allData
            jobList.reloadData()
        }
    }
