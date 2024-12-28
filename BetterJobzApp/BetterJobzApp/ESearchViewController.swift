//
//  ESearchViewController.swift
//  BetterJobzApp
//
//  Created by BP-19-131-14 on 28/12/2024.
//

import UIKit



class ESearchViewController: UIViewController, UITableViewDelegate, UITableViewDataSource, UISearchBarDelegate {
    
    @IBOutlet weak var searchBAR: UISearchBar!
    @IBOutlet weak var cellL: UITableView!
    @IBOutlet weak var filtterButtonn: UIButton!

    var allData: [File] = [
        File(name: "Software Engineer by AWS", keyword: "Amazon Web Services", company: "AWS", industry: "IT", jobType: "Full-Time", experience: "Entry-Level", location: "Remote"),
        File(name: "Engineer by NovaTech", keyword: "NovaTech Solutions", company: "NovaTech", industry: "Engineering", jobType: "Part-Time", experience: "Mid-Level", location: "Hybrid"),
        File(name: "Teacher by Green Valley International School", keyword: "Green Valley International School", company: "Green Valley", industry: "Academic", jobType: "Internship", experience: "Entry-Level", location: "On site"),
        File(name: "Chef by Golden Spoon Restaurant", keyword: "Golden Spoon Restaurant", company: "Golden Spoon", industry: "Culinary", jobType: "Full-Time", experience: "Manager", location: "On site")
    ]

    var filteredData: [File] = []
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


}
