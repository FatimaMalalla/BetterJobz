//  EFilterViewController.swift
//  BetterJobzApp
//
//  Created by BP-19-131-14 on 28/12/2024.
//

import UIKit

class EFilterViewController: UIViewController {

    @IBOutlet weak var academic: UIButton!
    @IBOutlet weak var iT: UIButton!
    @IBOutlet weak var culinary: UIButton!
    @IBOutlet weak var engineering: UIButton!
    @IBOutlet weak var creativeMedia: UIButton!

    @IBOutlet weak var fullTime: UIButton!
    @IBOutlet weak var partTime: UIButton!
    @IBOutlet weak var intership: UIButton!
    @IBOutlet weak var freelance: UIButton!

    @IBOutlet weak var entryLevel: UIButton!
    @IBOutlet weak var midLevel: UIButton!
    @IBOutlet weak var seniorLevel: UIButton!
    @IBOutlet weak var manager: UIButton!
    @IBOutlet weak var executive: UIButton!

    @IBOutlet weak var onSite: UIButton!
    @IBOutlet weak var remote: UIButton!
    @IBOutlet weak var hybrid: UIButton!

    @IBOutlet weak var apply: UIButton!
    @IBOutlet weak var clearfilter: UIButton!

    override func viewDidLoad() {
        super.viewDidLoad()

        // Do any additional setup after loading the view.
    }

    // Apply filters
    @IBAction func applyFilters(_ sender: UIButton) {
        // Add logic to collect selected filters and pass them back to the search view controller
    }

    // Clear filters
    @IBAction func clearFilters(_ sender: UIButton) {
        // Reset all filter buttons to their default state
    }
    
    /*
    // MARK: - Navigation

    // In a storyboard-based application, you will often want to do a little preparation before navigation
    override func prepare(for segue: UIStoryboardSegue, sender: Any?) {
        // Get the new view controller using segue.destination.
        // Pass the selected object to the new view controller.
    }
    */
}
