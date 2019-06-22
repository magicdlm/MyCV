//
//  MasterViewController.swift
//  MyCV
//
//  Created by Leming Deng on 2019-06-20.
//  Copyright © 2019 Leming Deng. All rights reserved.
//

import UIKit

class MasterViewController: UIViewController {

    @IBOutlet weak var tableView: UITableView! {
        didSet {
            tableView.register(UINib(nibName: "ExperienceTableViewCell", bundle: nil), forCellReuseIdentifier: CellId.experience.rawValue)
        }
    }
    @IBOutlet weak var spinner: UIActivityIndicatorView!
    
    @IBAction func unwind(for unwindSegue: UIStoryboardSegue) { }
    
    private enum CellId: String {
        case summary, experience
    }
    
    var detailViewController: DetailViewController? = nil
    private let viewModel: MasterViewModel = MasterViewModel()
    private var profile: Profile?

    override func viewDidLoad() {
        super.viewDidLoad()

        if let split = splitViewController {
            let controllers = split.viewControllers
            detailViewController = (controllers[controllers.count-1] as! UINavigationController).topViewController as? DetailViewController
        }
        loadData()
    }

    private func loadData() {
        spinner.startAnimating()
        viewModel.fetchData(success: { [weak self] (profile) in
            DispatchQueue.main.async {
                self?.spinner.stopAnimating()
                self?.title = profile.name
                self?.profile = profile
                self?.navigationItem.rightBarButtonItem?.isEnabled = true
                self?.tableView.reloadData()
            }
            }, fail: { [weak self] (error) in
                DispatchQueue.main.async {
                    guard let strongSelf = self else { return }
                    strongSelf.spinner.stopAnimating()
                    strongSelf.showError(error, retryHandler: { (_) in
                        strongSelf.loadData()
                    })
                }
        })
    }
    override func viewWillAppear(_ animated: Bool) {
        if splitViewController!.isCollapsed {
            if let indexPath = tableView.indexPathForSelectedRow {
                tableView.deselectRow(at: indexPath, animated: false)
            }
        }
        super.viewWillAppear(animated)
    }

    // MARK: - Segues
    private enum Segue: String {
        case showDetail, showProfile
    }
    
    override func prepare(for segue: UIStoryboardSegue, sender: Any?) {
        guard let id = segue.identifier,
            let s = Segue(rawValue: id) else { return }
        switch s {
        case .showDetail:
            guard let nav = segue.destination as? UINavigationController,
                let vc = nav.topViewController as? DetailViewController,
                let sender = sender as? (model: Experience, image: UIImage?) else { return }
            vc.title = sender.model.company
            vc.detailItem = sender.model
            vc.image = sender.image
            
        case .showProfile:
            let vc = segue.destination as! ProfileViewController
            vc.model = profile
        }
    }
    
    
}
    // MARK: - Table View
extension MasterViewController: UITableViewDelegate, UITableViewDataSource {
    func numberOfSections(in tableView: UITableView) -> Int {
        return viewModel.sections.count
    }

    func tableView(_ tableView: UITableView, titleForHeaderInSection section: Int) -> String? {
        return viewModel.sections[section].title
    }
    
    func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        return viewModel.sections[section].itemNumber
    }

    func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        switch viewModel.sections[indexPath.section] {
        case .summary(let s):
            let cell = tableView.dequeueReusableCell(withIdentifier: CellId.summary.rawValue, for: indexPath)
            cell.textLabel?.text = s[indexPath.row]
            return cell
        case .experience(let e):
            let cell = tableView.dequeueReusableCell(withIdentifier: CellId.experience.rawValue, for: indexPath) as! ExperienceTableViewCell
            cell.experience = e[indexPath.row]
            return cell
        }
        
    }
    
    func tableView(_ tableView: UITableView, didSelectRowAt indexPath: IndexPath) {
        guard case .experience(let e) = viewModel.sections[indexPath.section],
            let cell = tableView.cellForRow(at: indexPath) as? ExperienceTableViewCell else { return }
        let sender = (model: e[indexPath.row], image: cell.logo.image)
        performSegue(withIdentifier: Segue.showDetail.rawValue, sender: sender)
    }
}

